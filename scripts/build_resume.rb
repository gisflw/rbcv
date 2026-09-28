#!/usr/bin/env ruby
# frozen_string_literal: true

require "fileutils"
require "open3"
require "pathname"

ROOT = File.expand_path("..", __dir__)
PDF_PREAMBLE_PATH = File.join(ROOT, "templates", "cv-preamble.tex")
OUTPUT_DIR = File.join(ROOT, "build", "applications")

def command_available?(command)
  ENV.fetch("PATH", "").split(File::PATH_SEPARATOR).any? do |directory|
    File.executable?(File.join(directory, command))
  end
end

input_argument = ARGV[0]
abort "Usage: ruby scripts/build_resume.rb applications/<name>.md [output.pdf]" unless input_argument

input_path = File.expand_path(input_argument, ROOT)
abort "Markdown input not found: #{input_argument}" unless File.file?(input_path)
abort "Resume input must be a Markdown file" unless File.extname(input_path).downcase == ".md"

output_path = if ARGV[1]
                File.expand_path(ARGV[1], ROOT)
              else
                File.join(OUTPUT_DIR, "#{File.basename(input_path, ".md")}.pdf")
              end

FileUtils.mkdir_p(File.dirname(output_path))

command = [
  "pandoc",
  input_path,
  "--from=markdown+raw_tex",
  "--pdf-engine=xelatex",
  "--include-in-header", PDF_PREAMBLE_PATH,
  "-V", "geometry:margin=1.9cm",
  "-V", "fontsize=10.7pt",
  "-V", "colorlinks=true",
  "-V", "linkcolor=cvaccent",
  "-o", output_path
]

stdout, stderr, status = Open3.capture3(*command, chdir: ROOT)
unless status.success?
  warn stdout unless stdout.empty?
  warn stderr unless stderr.empty?
  abort "Failed to build #{output_path}"
end

validated_checks = []

if command_available?("pdfinfo")
  info, info_error, info_status = Open3.capture3("pdfinfo", output_path)
  abort info_error unless info_status.success?

  pages = info[/^Pages:\s+(\d+)/, 1].to_i
  abort "Resume must be exactly 2 pages; generated #{pages} page(s)" unless pages == 2
  validated_checks << "2 pages"
else
  warn "Warning: pdfinfo is unavailable; page-count validation was skipped"
end

if command_available?("pdftotext")
  text, text_error, text_status = Open3.capture3("pdftotext", "-layout", output_path, "-")
  abort text_error unless text_status.success?
  abort "Generated PDF does not contain enough extractable text for an ATS-friendly resume" if text.scan(/\S+/).length < 250
  validated_checks << "extractable text"
else
  warn "Warning: pdftotext is unavailable; text-extraction validation was skipped"
end

relative_output = Pathname.new(output_path).relative_path_from(Pathname.new(ROOT))
puts "Built #{relative_output}"
puts "Validated: #{validated_checks.join(" with ")}" unless validated_checks.empty?
