#!/usr/bin/env ruby
# frozen_string_literal: true

require "erb"
require "fileutils"
require "open3"
require "yaml"

ROOT = File.expand_path("..", __dir__)
PARAMS_PATH = File.join(ROOT, "config", "_default", "params.yaml")
LANGUAGES_PATH = File.join(ROOT, "config", "_default", "languages.yaml")
TEMPLATE_PATH = File.join(ROOT, "templates", "cv.md.erb")
BUILD_DIR = File.join(ROOT, "build", "cv")
OUTPUT_DIR = File.join(ROOT, "public", "cv")

LABELS = {
  "en" => {
    skills: "Skills",
    tools: "Tools & Datasets",
    experience: "Experience",
    education: "Education",
    publications: "Publications",
    contact: "Contact",
    stack: "Tools",
    portfolio: "Portfolio",
    headline: "Hydrologist | Geospatial Data Scientist | Research Software Engineer",
    country: "Brazil",
    current: "present"
  },
  "pt" => {
    skills: "Competências",
    tools: "Ferramentas & Dados",
    experience: "Experiência",
    education: "Formação",
    publications: "Publicações",
    contact: "Contato",
    stack: "Ferramentas",
    portfolio: "Portfólio",
    headline: "Hidrólogo | Cientista de Dados Geoespaciais | Engenheiro de Software Científico",
    country: "Brasil",
    current: "atual"
  },
  "es" => {
    skills: "Competencias",
    tools: "Herramientas y Datos",
    experience: "Experiencia",
    education: "Formación",
    publications: "Publicaciones",
    contact: "Contacto",
    stack: "Herramientas",
    portfolio: "Portafolio",
    headline: "Hidrólogo | Científico de Datos Geoespaciales | Ingeniero de Software Científico",
    country: "Brasil",
    current: "actual"
  }
}.freeze

def deep_merge(base, override)
  return base unless override.is_a?(Hash)

  base.merge(override) do |_key, old_value, new_value|
    if old_value.is_a?(Hash) && new_value.is_a?(Hash)
      deep_merge(old_value, new_value)
    else
      new_value
    end
  end
end

def load_yaml(path)
  YAML.safe_load_file(path, aliases: true) || {}
end

def strip_emoji(value)
  value.to_s
       .gsub(/[\u{1F100}-\u{1FAFF}\u{2600}-\u{27BF}\u{FE0F}\u{200D}]/, "")
       .squeeze(" ")
       .strip
end

def strip_markdown_emphasis(value)
  value.to_s.gsub(/\*\*(.*?)\*\*/, '\1').gsub(/\*(.*?)\*/, '\1')
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

def contribution_prefixes
  [
    "Main author",
    "Contributing author",
    "Autor principal",
    "Coautor"
  ]
end

def publication_summary_parts(summary)
  text = summary.to_s.strip
  prefix = contribution_prefixes.find { |item| text.start_with?("#{item};") }
  return [text, nil] unless prefix

  [text.sub(/\A#{Regexp.escape(prefix)};\s*/, ""), prefix]
end

def compact_markdown(value)
  value.to_s.strip
end

def first_sentence(value)
  value.to_s.split(/(?<=[.!?])\s+/).first.to_s.strip
end

class CvDocument
  attr_reader :lang, :params, :labels

  def initialize(lang:, params:)
    @lang = lang
    @params = params
    @labels = LABELS.fetch(lang, LABELS["en"])
  end

  def title
    params["title"].to_s
  end

  def headline
    labels[:headline]
  end

  def city_country
    badge = params.dig("hero", "locationBadge") || {}
    city = strip_emoji(badge["location"]).sub(/,\s*[A-Z]{2}\z/, "")
    [city, labels[:country]].reject { |item| blank?(item) }.join(", ")
  end

  def contact_links
    links = params.dig("hero", "socialLinks", "fontAwesomeIcons") || []
    links.map do |link|
      {
        "label" => social_label(link["icon"], link["url"]),
        "url" => social_url(link["url"])
      }
    end.reject { |link| blank?(link["url"]) }
  end

  def portfolio_link
    suffix = lang == "en" ? "" : "#{lang}/"
    {
      "label" => labels[:portfolio],
      "url" => "https://gisflw.github.io/rbcv/#{suffix}"
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
    params["skills"] || {}
  end

  def experience
    params["experience"] || {}
  end

  def education
    params["education"] || {}
  end

  def tools
    params["achievements"] || {}
  end

  def publications
    params["publications"] || {}
  end

  def render
    ERB.new(File.read(TEMPLATE_PATH), trim_mode: "-").result(binding)
  end
end

def build_pdf(lang, params)
  FileUtils.mkdir_p(BUILD_DIR)
  FileUtils.mkdir_p(OUTPUT_DIR)

  document = CvDocument.new(lang: lang, params: params)
  markdown_path = File.join(BUILD_DIR, "cv-#{lang}.md")
  pdf_path = File.join(OUTPUT_DIR, "cv-#{lang}.pdf")
  File.write(markdown_path, document.render)

  command = [
    "pandoc",
    markdown_path,
    "--from=markdown",
    "--pdf-engine=xelatex",
    "-V", "geometry:margin=1.5cm",
    "-V", "fontsize=10pt",
    "-V", "colorlinks=true",
    "-V", "linkcolor=blue",
    "-o", pdf_path
  ]

  stdout, stderr, status = Open3.capture3(*command, chdir: ROOT)
  return pdf_path if status.success?

  warn stdout unless stdout.empty?
  warn stderr unless stderr.empty?
  abort "Failed to build #{pdf_path}"
end

base_params = load_yaml(PARAMS_PATH)
languages = load_yaml(LANGUAGES_PATH)
requested = ARGV.empty? || ARGV == ["all"] ? languages.keys : ARGV

requested.each do |lang|
  language = languages.fetch(lang) { abort "Unknown language: #{lang}" }
  params = deep_merge(base_params, language["params"] || {})
  pdf_path = build_pdf(lang, params)
  puts "Built #{pdf_path.sub("#{ROOT}/", "")}"
end
