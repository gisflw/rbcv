# rbcv

Personal CV and portfolio site for Rafael Barbedo. English content under
`data/` is the shared source for the Hugo website, PDF CV, and default résumé.

## Purpose

- Maintain the website, project descriptions, publications, tools, and CV from
  reusable structured data.
- Generate the PDF CV and default résumé without duplicating their content.
  Detailed project pages appear on the website and are excluded from the PDF CV.

## Repository map

- `config/_default/` contains Hugo configuration and site settings.
- `data/` contains one YAML file per content section. `profile.yaml` holds the
  name and portfolio URL; `labels.yaml` holds shared labels. `projects.yaml`
  and `publications.yaml` are the catalogs used across pages and documents.
- `content/projects/` contains project page stubs; their details come from the
  project catalog in `data/`.
- `layouts/` contains project-level Hugo overrides. `themes/hugo-profile/` is
  vendored theme code and should not be edited directly.
- `scripts/` and `templates/` generate the English PDF CV and application
  résumés from the section files.
- `static/` contains site assets. `public/` is generated output; do not edit it
  by hand.

## Build

Run from the repository root:

```bash
hugo server
hugo
hugo --gc --minify
ruby scripts/build_cv.rb
```

The CV builder writes `public/cv/rbcv-en.pdf`, which the website links to.
`make deploy-build` runs both the Hugo and PDF builds.

## Application résumés

The default two-page English résumé uses the same role, education, software,
and publication records as the CV. Build it with:

```bash
make resume
```

It writes `build/applications/company-role.pdf`, which is not published with
this site. To build a custom Markdown résumé from `applications/`, run:

```bash
make resume RESUME=applications/another-role.md
```

The PDF is written to `build/applications/`. When `pdfinfo` and `pdftotext` are
available, the builder checks that the default résumé has exactly two pages
and extractable text.

## Working conventions

- Edit source files rather than generated files in `public/`.
- Use local layout overrides; keep the `hugo-profile` theme as vendor code.
- Add future tool and publication pages under `content/tools/` and
  `content/publications/`, drawing their content from the corresponding data
  catalogs.
- Keep Publications in descending `sortDate` order. Preserve relative order
  for entries with the same date.
- After structural or content changes, run `hugo` and check the homepage,
  project links, and CV download link.
