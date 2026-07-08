# AGENTS.md

Instructions for Codex and other agents working in this repository.

## Repository Root

Treat this directory, `rbcv`, as the repository root. The parent directory may
contain scratch material, but implementation work belongs here unless the user
explicitly asks otherwise.

## Project Intent

This is an under-construction Hugo CV/portfolio site for Rafael Barbedo. The
goal is to maintain one structured source of truth that can generate:

- the public website;
- detailed pages for projects, tools/datasets, and publications;
- PDF versions of the CV.

## Edit Source, Not Output

Prefer edits in:

- `hugo.yaml`
- `data/`
- `content/`
- `layouts/`
- `static/`
- `assets/`

Avoid manual edits in `public/`; it is generated Hugo output. If generated files
change during a build, make sure that is intentional before presenting the
result.

## Hugo and Theme Conventions

- Preserve the `hugo-profile` theme as the base site theme.
- Prefer project-level overrides in `layouts/` instead of editing
  `themes/hugo-profile/` directly.
- The current custom experience layout is
  `layouts/partials/sections/experience.html`.
- Keep `hugo.yaml` valid YAML and avoid large unrelated rewrites.

## Intended Structure

The current bootstrap stores too much content in `hugo.yaml`. Future work should
move CV/profile content into structured files under `data/`, keeping
`hugo.yaml` mostly for Hugo configuration, language setup, menus, and global
site settings.

Detailed public pages should live under multilingual content paths, for example:

- `content/en/projects/...`
- `content/pt/projects/...`
- `content/es/projects/...`
- `content/en/tools/...`
- `content/en/publications/...`

Keep translations and cross-language links aligned when adding or changing
content.

## PDF CV Direction

PDF CVs should eventually be generated from the same structured data used by the
website. Do not create a workflow that requires manually duplicating CV content
between web pages and PDF files unless the user explicitly chooses that
tradeoff.

## Verification

After structural, content, layout, or configuration changes, run:

```bash
hugo
```

Also check:

- language navigation;
- important homepage sections;
- internal links to project/tool/publication pages;
- CV download links;
- whether any changes under `public/` are expected generated output.

For purely documentation-only changes, a Hugo build is still useful to confirm
the repository remains healthy.
