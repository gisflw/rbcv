# rbcv

Personal CV and portfolio site for Rafael Barbedo.

This repository is under construction. The current version is a Hugo bootstrap
using the `hugo-profile` theme, with most profile and CV content still stored in
`hugo.yaml`. The intended direction is for this repo to become the source of
truth for both the public website and generated PDF versions of the CV.

## Purpose

- Build and maintain Rafael Barbedo's personal CV/portfolio website.
- Keep web content, project descriptions, publications, tools, and CV data in a
  reusable structure.
- Generate PDF CV versions from the same structured source data, avoiding manual
  duplication between website and documents.

## Current State

- Hugo site configured in `hugo.yaml`.
- Theme: `hugo-profile`, vendored under `themes/hugo-profile`.
- Most homepage content, multilingual text, projects, tools, and publications
  are currently embedded in `hugo.yaml`.
- `layouts/partials/sections/experience.html` overrides the theme experience
  section to support companies with multiple jobs.
- `content/`, `data/`, `static/`, `assets/`, and `i18n/` exist as source
  directories but are currently mostly empty.
- `public/` contains generated Hugo output and should not be edited by hand.
- `../scratch.md` is raw CV source material outside this repo.

## Repo Map

- `hugo.yaml` - Hugo configuration plus current site content.
- `content/` - intended home for multilingual pages such as project, tool, and
  publication detail pages.
- `data/` - intended home for structured CV/profile data shared by website and
  PDF generation.
- `layouts/` - project-level Hugo layout overrides.
- `static/` and `assets/` - intended home for project images, CV PDFs, and other
  site assets.
- `themes/hugo-profile/` - vendored Hugo theme. Prefer local overrides instead
  of editing the theme directly.
- `public/` - generated site output.

## Common Commands

Run commands from this directory:

```bash
hugo server
hugo
hugo --gc --minify
```

Use `hugo server` for local development, `hugo` for a normal production build,
and `hugo --gc --minify` for a cleaner optimized build.

## Near-Term Roadmap

- Move profile/CV data out of the monolithic `hugo.yaml` into structured YAML
  files under `data/`.
- Keep `hugo.yaml` focused on Hugo configuration, menus, languages, and site
  settings.
- Add detailed pages for projects, tools/datasets, and publications under
  multilingual `content/<lang>/...` paths.
- Build a PDF CV workflow that reads from the same structured data used by the
  website.
- Replace placeholder/example assets with semantically accurate images and CV
  files.
- Clarify generated-output conventions, including whether `public/` should stay
  committed or be generated during deployment.

## Working Conventions

- Edit source files, configuration, content, layouts, and assets; do not
  manually edit generated files in `public/`.
- Keep multilingual content aligned across English, Portuguese, Spanish, and any
  future languages.
- Add project-level layout overrides in `layouts/` when the theme needs custom
  behavior.
- Avoid editing `themes/hugo-profile/` unless the change is intentionally
  vendored theme maintenance.
- After structural or content changes, run `hugo` and check important pages,
  language links, and internal links.
