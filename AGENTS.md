# AGENTS.md

Instructions for Codex and other agents working in this repository.

## Repository Root

Treat this directory, `rbcv`, as the repository root. The parent directory may
contain scratch material, but implementation work belongs here unless the user
explicitly asks otherwise.

## Project Intent

This is an under-construction Hugo CV/portfolio site for Rafael Barbedo. Keep
one structured English source of truth that can generate the public website,
detailed project/tool/publication pages, and PDF CV and résumé documents.

## Language and CV Writing

Write English content in American English. Portuguese, Spanish, and other
languages may appear as language proficiency or original publication metadata;
they are not website or CV translation targets.

Never use verbs to describe experience or projects. Write experience overviews,
project scopes, and project contributions as noun phrases, without finite verbs,
verb-led bullets, or gerund-led descriptions. Never use semicolons in
experience or project descriptions, including scopes, overviews, and
contributions. Each experience overview or project contribution bullet must
express one coherent idea as a continuous noun phrase, without a period
anywhere in the bullet. Use a separate bullet for a distinct idea.
Preserve distinct methods, inputs, outputs, metrics, and status. Remove
duplicated information only. Do not shorten descriptions at the cost of detail.

Keep Publications in descending date order in the website and generated PDFs.
Use the documented `sortDate` at year, month, or day precision; keep the
relative order of entries with the same date. For EGU abstracts, use the source
page's "updated on" date for sorting, without presenting it as the publication
date.

## Edit Source, Not Output

Prefer edits in `config/`, `data/`, `content/`, `layouts/`, `static/`, and
`assets/`. Do not manually edit `public/`; it is generated Hugo output. If
generated files change during a build, make sure that is intentional before
presenting the result.

## Hugo and Theme Conventions

Preserve the `hugo-profile` theme as the base site theme. Do not edit files under
`themes/hugo-profile/` directly; treat the theme as vendor code. Use project
level overrides in `layouts/`, `static/`, or `assets/` for custom behavior,
styling, and markup. If a theme change seems unavoidable, ask the user before
touching the theme. The custom experience layout is
`layouts/partials/sections/experience.html`. Keep configuration YAML valid and
avoid large unrelated rewrites.

## Content Structure

CV and profile content lives in section YAML files under `data/`; Hugo config
contains site settings, menus, and the sole English language definition.
Detailed public pages belong under `content/projects/`, `content/tools/`, and
`content/publications/`. Keep links from data catalogs to detailed pages
aligned.

PDF CVs and the default résumé must use the same structured data as the
website. Do not introduce manual duplication between website content and PDF
sources unless the user explicitly chooses that tradeoff.

## Verification

After structural, content, layout, or configuration changes, run `hugo`. Also
check the homepage sections, internal project/tool/publication links, CV
download link, and whether any `public/` changes are expected generated output.
For documentation-only changes, a Hugo build is still useful to confirm the
repository remains healthy.
