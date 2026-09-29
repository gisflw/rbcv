#!/usr/bin/env ruby
# frozen_string_literal: true

require "date"
require "erb"
require "fileutils"
require "open3"
require "yaml"

ROOT = File.expand_path("..", __dir__)
DATA_DIR = File.join(ROOT, "data")
TEMPLATE_PATH = File.join(ROOT, "templates", "cv.md.erb")
PDF_PREAMBLE_PATH = File.join(ROOT, "templates", "cv-preamble.tex")
BUILD_DIR = File.join(ROOT, "build", "cv")
OUTPUT_DIR = File.join(ROOT, "public", "cv")
CV_SECTIONS = %w[labels hero about skills resume experience education projects achievements contact publications navigation].freeze

def load_yaml(path)
  YAML.safe_load_file(path, aliases: true) || {}
end

def load_cv_data
  sections = CV_SECTIONS.to_h do |section|
    [section, load_yaml(File.join(DATA_DIR, "#{section}.yaml"))]
  end
  sections.merge(load_yaml(File.join(DATA_DIR, "profile.yaml")))
end

def strip_emoji(value)
  value.to_s
       .gsub(/[\u{1F100}-\u{1FAFF}\u{2600}-\u{27BF}\u{FE0F}\u{200D}]/, "")
       .squeeze(" ")
       .strip
end

def strip_markdown_emphasis(value)
  value.to_s.gsub(/\*\*(.*?)\*\*/, '\\1').gsub(/\*(.*?)\*/, '\\1')
end

def blank?(value)
  value.nil? || (value.respond_to?(:empty?) && value.empty?)
end

def social_label(icon, url)
  return "Email" if url.to_s.start_with?("mailto:")
  return "GitHub" if icon.to_s.include?("github") || url.to_s.include?("github.com")
  return "LinkedIn" if icon.to_s.include?("linkedin") || url.to_s.include?("linkedin.com")

  url.to_s.sub(%r{\Ahttps?://}, "").sub(%r{/\z}, "")
end

def social_url(url)
  url.to_s.sub(/\Amailto:/, "")
end

def compact_markdown(value)
  value.to_s.strip
end

def first_sentence(value)
  value.to_s.split(/(?<=[.!?])\s+/).first.to_s.strip
end

class CvDocument
  attr_reader :data, :labels

  def initialize(data:)
    @data = data
    @labels = data.fetch("labels", {}).transform_keys(&:to_sym)
  end

  def title
    data["name"].to_s
  end

  def headline
    labels[:headline]
  end

  def city_country
    badge = data.dig("hero", "locationBadge") || {}
    city = strip_emoji(badge["location"]).sub(/,\s*[A-Z]{2}\z/, "")
    [city, labels[:country]].reject { |item| blank?(item) }.join(", ")
  end

  def contact_links
    links = data.dig("hero", "socialLinks", "fontAwesomeIcons") || []
    links.map do |link|
      {
        "label" => social_label(link["icon"], link["url"]),
        "url" => social_url(link["url"])
      }
    end.reject { |link| blank?(link["url"]) }
  end

  def portfolio_link
    {
      "label" => labels[:portfolio],
      "url" => data["portfolioUrl"]
    }
  end

  def profile_links
    [portfolio_link] + contact_links.reject { |link| link["label"] == "Email" }
  end

  def email
    email_link = contact_links.find { |link| link["label"] == "Email" }
    email_link && email_link["url"]
  end

  def skills
    data["skills"] || {}
  end

  def experience
    data["experience"] || {}
  end

  def education
    data["education"] || {}
  end

  def resume
    data["resume"] || {}
  end

  def tools
    data["achievements"] || {}
  end

  def publications
    data["publications"] || {}
  end

  def render(template_path: TEMPLATE_PATH)
    ERB.new(File.read(template_path), trim_mode: "-").result(binding)
  end
end

def build_pdf(data)
  FileUtils.mkdir_p(BUILD_DIR)
  FileUtils.mkdir_p(OUTPUT_DIR)

  document = CvDocument.new(data: data)
  markdown_path = File.join(BUILD_DIR, "rbcv-en.md")
  pdf_path = File.join(OUTPUT_DIR, "rbcv-en.pdf")
  File.write(markdown_path, document.render)

  command = [
    "pandoc",
    markdown_path,
    "--from=markdown",
    "--pdf-engine=xelatex",
    "--include-in-header", PDF_PREAMBLE_PATH,
    "-V", "geometry:margin=1.9cm",
    "-V", "fontsize=10.7pt",
    "-V", "colorlinks=true",
    "-V", "linkcolor=cvaccent",
    "-o", pdf_path
  ]

  stdout, stderr, status = Open3.capture3(*command, chdir: ROOT)
  return pdf_path if status.success?

  warn stdout unless stdout.empty?
  warn stderr unless stderr.empty?
  abort "Failed to build #{pdf_path}"
end

if $PROGRAM_NAME == __FILE__
  abort "Usage: ruby scripts/build_cv.rb" unless ARGV.empty?

  pdf_path = build_pdf(load_cv_data)
  puts "Built #{pdf_path.sub("#{ROOT}/", "")}"
end
