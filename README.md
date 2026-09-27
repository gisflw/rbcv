# rbcv

Personal CV and portfolio site for Rafael Barbedo.

The multilingual CV content lives in `data/en.yaml`, `data/pt.yaml`, and
`data/es.yaml`. These files are the shared source for the Hugo site and the
three generated PDF CVs.

## Purpose

- Build and maintain Rafael Barbedo's personal CV/portfolio website.
- Keep web content, project descriptions, publications, tools, and CV data in a
  reusable structure.
- Generate PDF CV versions from the same structured source data, avoiding
  manual duplication between website and documents.

## Current state

- Hugo configuration and shared theme settings are under `config/_default/`.
- Language-specific profile, CV, project, tool, and publication summaries are in
  `data/en.yaml`, `data/pt.yaml`, and `data/es.yaml`.
- The `hugo-profile` theme is vendored under `themes/hugo-profile`.
- `layouts/partials/sections/experience.html` renders roles with dated project blocks;
  catalog entries link back to those projects where a relationship is documented.
- Detailed project, tool, and publication pages can be added under
  multilingual `content/<lang>/...` paths.
- `public/` contains generated Hugo output and should not be edited by hand.
- `../scratch.md` is raw CV source material outside this repo.

## Repo map

- `config/_default/` - Hugo setup, shared site parameters, languages, and menus.
- `data/en.yaml`, `data/pt.yaml`, `data/es.yaml` - structured multilingual
  profile and CV content used by the website and PDF builder.
- `content/` - multilingual project, tool, and publication detail pages.
- `layouts/` - project-level Hugo layout overrides.
- `scripts/build_cv.rb` and `templates/` - PDF CV generation from `data/`.
- `static/` and `assets/` - project images, styles, and other site assets.
- `themes/hugo-profile/` - vendored Hugo theme. Prefer local overrides instead
  of editing the theme directly.
- `public/` - generated site output.

## Common commands

Run commands from this directory:

```bash
hugo server
hugo
hugo --gc --minify
ruby scripts/build_cv.rb all
```

Use `hugo server` for local development, `hugo` for a normal production build,
`hugo --gc --minify` for an optimized build, and the Ruby script to generate all
three PDFs. Pass `en`, `pt`, or `es` to build one PDF.

## Near-term roadmap

- Add detailed pages for projects, tools/datasets, and publications under
  multilingual `content/<lang>/...` paths.
- Keep translations aligned across English, Portuguese, and Spanish.
- Replace placeholder/example assets with semantically accurate images and CV
  files.
- Clarify generated-output conventions, including whether `public/` should
  stay committed or be generated during deployment.

## Working conventions

- Edit source files, configuration, content, layouts, and assets; do not
  manually edit generated files in `public/`.
- Add project-level layout overrides in `layouts/` when the theme needs custom
  behavior.
- Avoid editing `themes/hugo-profile/` unless the change is intentionally
  vendored theme maintenance.
- After structural or content changes, run `hugo` and check important pages,
  language links, and internal links.
