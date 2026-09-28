# Experience Project Description Migration Plan

Status: draft for editorial review and approval. This document does not change the current website, CV data, templates, or generated files.

## 1. Objective

Replace each project’s single `description` paragraph with three clearly labelled parts:

- **Scope:** one short paragraph explaining the purpose and boundaries of the project.
- **Main activities:** concise bullet points describing the work performed.
- **Main outcomes:** concise bullet points describing the principal deliverables and results, followed by the software and publications associated with that project.

The same structure should eventually appear on the website and in all generated PDF CVs. The English wording proposed below is the source for implementation and translation.

## 2. Recommended content model

Each project would move from this shape:

```yaml
- id: example-project
  title: Example Project
  description: >-
    One combined paragraph.
```

to this shape:

```yaml
- id: example-project
  title: Example Project
  scope: >-
    A brief description of the project’s purpose and boundaries.
  mainActivities:
  - First activity.
  - Second activity.
  mainOutcomes:
  - First project result or deliverable.
```

Add translatable section labels under `experience`:

```yaml
experience:
  scopeLabel: 'Scope:'
  activitiesLabel: 'Main activities:'
  outcomesLabel: 'Main outcomes:'
```

### Software and publication linking

Software and publications should continue to live only in their existing canonical lists (`achievements.items` and `publications.items`). During rendering, select every item whose `project` value matches the experience project’s `id`, and append it as a bullet under **Main outcomes**.

This intentionally repeats those outputs in the Experience, Software, and Publications sections for readers, but avoids copying their metadata into multiple YAML locations. It also means that a future title, URL, DOI, type, or year correction needs to be made only once.

Recommended rendered forms:

- `Software: [Title](primary URL) — short description.`
- `Publication (Type, Year): [Title](DOI or URL).`

Where a software record contains both `url` and `repository`, use `url` as the title link and optionally add a separate `Repository` link after the description. Use the DOI as the preferred publication link, falling back to `url` when no DOI is present.

Publication bullets within a project must retain the order of the canonical publication list: descending `sortDate`, with source order preserved for equal dates. Software bullets should retain the order of the canonical software list.

## 3. Proposed English write

The bullets marked **Software** and **Publication** below are the output records that would be selected automatically through the existing `project` identifiers.

### Postdoctoral Researcher — Federal University of Rio Grande do Sul (UFRGS)

#### National Water Model Development

**Scope:** Develop and evaluate a national-scale implementation of the MGB hydrological model for Brazil, integrating observations and environmental and geospatial datasets for water-resources analysis and forecasting.

**Main activities:**

- Assemble and harmonize hydrological observations, environmental datasets, and geospatial inputs.
- Parameterize the model and assess its performance across Brazilian river basins.
- Represent reservoirs and water uses within the modelling framework.
- Build reproducible workflows for data preparation, model evaluation, and scenario analysis.
- Prepare the model for studies of land-use change, climate variability, and hydrological forecasting.

**Main outcomes:**

- A reproducible national MGB model configuration and supporting data-processing workflows, currently under development.
- **Software:** [MGB Vechy](https://github.com/gisflw/mgb-vechy) — utilities and workflows supporting MGB hydrological modelling applications.

#### Flood Alert System for Rio Grande do Sul

**Scope:** Support basin-scale flood monitoring and forecasting in Rio Grande do Sul through integrated hydrological time series, geospatial data, modelling, and operational visualization.

**Main activities:**

- Validate and integrate water-level, streamflow, and geospatial datasets used in flood monitoring.
- Develop water-level and streamflow modelling workflows for basin-scale forecasts.
- Produce operational visualizations for flood-warning activities.
- Develop quality-control procedures for flood-related environmental data.
- Explore rating curves to support the preparation and interpretation of streamflow observations.

**Main outcomes:**

- Integrated datasets, modelling workflows, and visual products supporting operational flood-warning activities.
- **Software:** [Flood QC](https://github.com/gisflw/flood-qc) — tools for quality control and validation of flood-related environmental data.
- **Software:** [Rating Curve Explorer](https://github.com/gisflw/rating-curve-explorer) — tools for organizing, visualizing, and performing initial analyses of streamflow data used in rating-curve derivation.

### Hydrology & Data Consultant — Independent

#### Priority Conservation Mapping

**Scope:** Assess the hydrological benefits of vegetation protection and restoration scenarios in the Cerrado and identify priority areas for water conservation.

**Main activities:**

- Develop and calibrate PLANS models representing alternative vegetation protection and restoration scenarios.
- Evaluate changes in infiltration, evapotranspiration, and surface runoff.
- Integrate remote-sensing observations, historical climate series, and land-use maps in Python and QGIS workflows.
- Assess hydrological additionality at regional scale.
- Produce conservation indicators, prioritization maps, geospatial visualizations, and technical reports.

**Main outcomes:**

- A multiscale geospatial evidence base and priority maps for water-conservation planning in the Cerrado.
- **Software:** [Cerrado APCAC View](https://github.com/gisflw/cerrado-apcac-view) — interactive viewer for Cerrado APCAC data products and geospatial analyses.
- **Publication (Conference abstract, 2026):** [A geomorphology-based framework for identifying water conservation priorities in the Brazilian Cerrado savanna](https://doi.org/10.5194/egusphere-egu26-3592).
- **Publication (Dataset, 2026):** [Base de Dados Geoespaciais para Avaliação Multiescalar de Áreas Prioritárias de Conservação de Água no Bioma Cerrado](https://doi.org/10.5281/zenodo.21540477).

#### Water Availability Database

**Scope:** Redesign and migrate ANA’s geospatial database for water-availability information into a unified, documented PostgreSQL/PostGIS system.

**Main activities:**

- Diagnose the existing database structure, including tables, relationships, and spatial routines.
- Design the new logical and physical PostgreSQL/PostGIS data model.
- Develop processing functions and migration routines for legacy records.
- Consolidate water-availability data in a unified structure.
- Prepare a user manual and technical training materials for querying, updating, and ingesting data.

**Main outcomes:**

- A unified database model, migration workflow, and documentation package for managing water-availability data.
- **Software:** [Brazilian Hydrological Availability Data System](https://github.com/gisflw/db-disphid) — an ETL framework for consolidating geospatial hydrological data in ANA’s water-availability data system, with traceable processing across versions of the national hydrographic network.

### Spatial Data Scientist — UK Centre for Ecology & Hydrology (UKCEH)

#### National River Flow Archive (NRFA)

**Scope:** Maintain and analyse catchment and environmental information for monitored river basins in the United Kingdom, supporting hydrological data products and water-resources research.

**Main activities:**

- Process and maintain catchment boundaries and environmental datasets.
- Perform spatial analyses for monitored river basins.
- Derive catchment descriptors and mapping outputs that summarize basin characteristics.
- Apply consistency and quality checks during updates to the underlying catchment information.

**Main outcomes:**

- Maintained catchment information, derived descriptors, and maps used in national hydrological data products.
- **Publication (Journal article, 2026):** [CAMELS-GB v2: hydrometeorological time series and landscape attributes for 671 catchments in Great Britain](https://doi.org/10.5194/essd-18-4345-2026).
- **Publication (Dataset, 2025):** [Catchment boundaries, daily and sub-daily hydrometeorological time series, groundwater level time series and attributes for 671 catchments in Great Britain (CAMELS-GB v2)](https://doi.org/10.5285/9a46d428-958f-4ac1-86eb-94eee70c0955).

#### Floods and Droughts Research Infrastructure (FDRI)

**Scope:** Transform high-resolution LiDAR data into integrated terrain products and reusable analysis resources for floods-and-droughts research in England and Wales.

**Main activities:**

- Develop workflows for processing high-resolution LiDAR data into terrain-model inputs.
- Merge source data into consistent digital terrain and digital surface models for England and Wales.
- Prepare analysis examples demonstrating the use of the integrated elevation data in research workflows.

**Main outcomes:**

- An integrated LiDAR-based terrain and surface model for England and Wales, accompanied by reusable analysis examples.
- **Software:** [High Resolution DTM & DSM Processing Workflows](https://github.com/NERC-CEH/dtm-analysis) — Jupyter notebooks and scripts for processing high-resolution LiDAR-derived terrain and surface models for England and Wales.
- **Publication (Dataset, 2026):** [Merged LiDAR based Digital Terrain Model (DTM) and Digital Surface Model (DSM) for England and Wales](https://doi.org/10.5285/34443359-64c0-4909-9f27-bb5d47f1153f).

#### Modern approaches to biodiversity monitoring (MAMBO)

**Scope:** Develop a deep-learning workflow for mapping individual shrubs and shrub clumps in drone-derived RGB imagery for biodiversity monitoring.

**Main activities:**

- Prepare drone-derived RGB imagery for semantic segmentation.
- Develop and apply an attention U-Net workflow for shrub identification.
- Convert model predictions into mapped vegetation features.
- Support analyses of shrub cover, spatial patterns, biomass, and carbon.

**Main outcomes:**

- Reproducible shrub delineations that convert drone imagery into spatial vegetation information for biodiversity research.
- **Software:** [Attention UNet for shrub segmentation](https://github.com/gisflw/att-unet-shrub-id) — a deep-learning pipeline for identifying shrub individuals or clumps in drone-derived RGB imagery.
- **Publication (Conference abstract, 2026):** [Deriving shrub biomass and carbon from affordable UAV observations](https://doi.org/10.5194/egusphere-egu26-13800).
- **Publication (Conference abstract, 2025):** [Biomass allometry for shrubs at a UK rewilding site](https://doi.org/10.5194/egusphere-egu25-11605).
- **Publication (Conference abstract, 2025):** [Shrub species, cover and biomass from affordable UAV observations](https://doi.org/10.5194/egusphere-egu25-1632).

#### Environmental Information Data Centre (EIDC)

**Scope:** Curate and prepare environmental research datasets for ingestion, publication, and reuse through the EIDC’s data workflows.

**Main activities:**

- Review and prepare submitted research datasets for ingestion.
- Apply consistent data-management practices throughout the preparation and release process.
- Resolve data-organization issues that could limit publication or downstream reuse.

**Main outcomes:**

- Publication-ready environmental datasets made available in forms suitable for reuse by other researchers.

### Researcher — Federal University of Rio Grande do Sul (UFRGS)

#### MGB–BHO

**Scope:** Integrate the MGB large-basin hydrological model with the Brazilian Ottocodified Hydrographic Base (BHO), allowing model units to follow the national vector river network.

**Main activities:**

- Develop methods to discretize the BHO river network during MGB preprocessing.
- Derive hydrological parameters from the national hydrographic data.
- Build procedures for consistently translating the vector network into model units and inputs.
- Evaluate how discretization choices affect national-scale hydrological modelling workflows.

**Main outcomes:**

- Preprocessing and parameter-derivation procedures enabling consistent use of the BHO river network in MGB applications.
- **Software:** [BHO2MGB](https://github.com/HGE-IPH/BHO2MGB) — a QGIS plugin for preprocessing the MGB Large Basin Model with Brazil’s Ottocodified Hydrographic Base (BHO).
- **Publication (Technical report, 2021):** [Cooperação em tecnologias para análises hidrológicas em escala nacional: sub-projeto — regionalização de vazões via modelagem hidrológica: métodos de discretização do modelo MGB e sua relação com a BHO](https://lume.ufrgs.br/handle/10183/253797).
- **Publication (Technical report, 2021):** [Cooperação em tecnologias para análises hidrológicas em escala nacional: sub-projeto — regionalização de vazões via modelagem hidrológica: MGB-BHO: pré-processamento do MGB em cima da base hidrográfica ottocodificada](https://lume.ufrgs.br/handle/10183/253840).

#### Water Accounting

**Scope:** Quantify the spatial and temporal variability of water stocks and fluxes across Brazil’s hydrographic regions to support the System of Environmental-Economic Accounting for Water (SEEA-Water).

**Main activities:**

- Assemble national datasets describing precipitation, soil moisture, evapotranspiration, and water storage.
- Analyse spatial and temporal variability across Brazilian hydrographic regions.
- Integrate hydrological evidence with the information required to describe water stocks and flows in environmental-economic accounts.

**Main outcomes:**

- National hydrological estimates and analyses supporting Brazil’s environmental-economic water accounts.
- **Publication (Journal article, 2022):** [Water storage variability across Brazil](https://doi.org/10.1590/2318-0331.272220220077).
- **Publication (Technical report, 2022):** [Cooperação em tecnologias para análises hidrológicas em escala nacional: subprojeto estimativas hidrológicas para contas econômicas ambientais da água (CEAA) no Brasil](https://lume.ufrgs.br/handle/10183/274942).

#### Reference Streamflow Regionalization

**Scope:** Estimate long-term mean streamflow and Q95 low flow at ungauged locations across Brazil using machine-learning models and environmental predictors.

**Main activities:**

- Assemble streamflow observations and environmental predictors for model development.
- Develop machine-learning models for long-term mean streamflow and Q95 estimation.
- Evaluate model performance and uncertainty across different hydrological settings.
- Compare machine-learning estimates with alternative reference-streamflow methods.
- Generate predictions for ungauged locations across the national hydrographic network.

**Main outcomes:**

- National reference-streamflow estimates for more than 400,000 ungauged river points, with associated performance and uncertainty assessments.
- **Software:** [ML Pipeline](https://github.com/gisflw/ml-pipeline) — reusable machine-learning pipeline components for environmental and geospatial modelling.
- **Publication (Preprint, 2025):** [Modeling Long-Term Flow Regimes in Ungauged Basins: An Evaluation of Machine Learning Performance and Uncertainty](https://doi.org/10.22541/essoar.175336960.03823488/v1).
- **Publication (Dataset, 2024):** [Reference Mean and Low Streamflow for all Brazilian Catchments Generated Using Machine Learning Models](https://doi.org/10.5281/zenodo.14217002).
- **Publication (Conference abstract, 2023):** [Streamflow Estimation in Ungauged Catchments in Brazil using Machine Learning Approaches](https://doi.org/10.5194/egusphere-egu23-844).
- **Publication (Technical report, 2021):** [Cooperação em tecnologias para análises hidrológicas em escala nacional: sub-projeto — regionalização de vazões via modelagem hidrológica: comparação de métodos para estimativas de vazões de referência: vazão média e Q95](https://lume.ufrgs.br/handle/10183/253831).
- **Publication (Technical report, 2021):** [Cooperação em tecnologias para análises hidrológicas em escala nacional: sub-projeto — regionalização de vazões via modelagem hidrológica: estimativa de vazão em locais sem dados usando machine learning](https://lume.ufrgs.br/handle/10183/253843).

#### Riparian vegetation hydrological assessment

**Scope:** Identify riparian zones and assess vegetation behaviour at large scale in an agricultural-expansion region of the Brazilian Cerrado.

**Main activities:**

- Extract and map drainage networks from digital elevation models to identify river corridors.
- Analyse terrain and topographic position to represent spatial variation in drainage density.
- Combine remote sensing, vegetation indices, and evapotranspiration data to assess riparian vegetation.
- Apply the resulting methods to a large-scale analysis of riparian zones in the Cerrado.

**Main outcomes:**

- A terrain-based method and mapped drainage information supporting large-scale identification and assessment of riparian vegetation.
- **Software:** [Topographic Position-based Stream definition (TPS)](https://github.com/gisflw/TPS) — an algorithm for extracting drainage networks from digital elevation models using topographic position.
- **Publication (Journal article, 2022):** [Topographic Position-based Stream definition (TPS): A simple method to address spatial variability of drainage density in stream networks](https://doi.org/10.1080/02626667.2022.2047190).

## 4. Records not attached to an experience project

The following publications currently have no `project` value and therefore would remain only in the Publications section unless an explicit relationship is added later:

- *A comprehensive strategy for modeling watershed restoration priority areas under epistemic uncertainty: A case study in the Atlantic Forest, Brazil* (2023).
- *How much inundation occurs in the Amazon River basin?* (2022).
- *Global Evapotranspiration Datasets Assessment Using Water Balance in South America* (2022).

No project association should be inferred during this migration without editorial confirmation.

## 5. Implementation plan after approval

1. **Approve the English copy and associations.** Edit this document until every scope, activity, outcome, and linked output is accepted. Decide whether the three currently unassigned publications should remain unassigned.
2. **Add the new English fields.** In `data/en.yaml`, replace each project’s `description` with `scope`, `mainActivities`, and `mainOutcomes`. Keep every project `id` unchanged because it is the join key for software and publications.
3. **Translate the approved copy.** Apply the identical structure and project IDs to `data/pt.yaml` and `data/es.yaml`; translate the three labels and authored prose, while keeping formal output titles in their canonical form unless a translated title is intentionally preferred.
4. **Update the website renderer.** Modify the project block in `layouts/partials/sections/experience.html` to render the scope paragraph and both lists. Select related software and publications by project ID and append them to the outcomes list with accessible links.
5. **Update the PDF renderer.** Modify `templates/cv.md.erb` so the PDF displays the same structure and derives the same related outputs. Avoid adding duplicated output records to the project data.
6. **Adjust project-description styling.** Add narrowly scoped rules to `static/css/career-canvas-overrides.css` for label spacing, compact lists, and readable wrapping on mobile. Preserve the existing theme and project-level override approach.
7. **Use a safe transition.** During implementation, optionally support `description` as a temporary fallback in both renderers until all three language files have migrated. Remove the fallback once migration is complete and verified.
8. **Validate the data relationships.** Check that project IDs are unique and identical across languages; every non-empty software/publication `project` points to an existing project; and each expected output appears under the correct project exactly once.
9. **Build and inspect.** Run `hugo`, then build all PDF CVs. Review all three languages, project anchors, links, mobile layout, page breaks, and publication ordering. Confirm that changes under `public/` are generated and intentional.

## 6. Acceptance criteria

- Every one of the 12 experience projects has one brief scope paragraph, an activities list, and an outcomes list.
- The visible labels are **Scope:**, **Main activities:**, and **Main outcomes:** in English, with approved equivalents in Portuguese and Spanish.
- All ten software records appear under their linked projects and remain in the standalone Software section.
- All 18 project-linked publication records appear under their linked projects and remain in the standalone Publications section.
- The three publications without a project association are not attached automatically.
- Related publications remain in descending `sortDate` order, preserving source order where dates are equal.
- Software/publication titles and links come from their canonical lists rather than copied project metadata.
- Website and PDF versions present equivalent content in English, Portuguese, and Spanish.
- `hugo` and all three PDF builds complete successfully.
- No files under `themes/hugo-profile/` are modified.

## 7. Editorial points to confirm before implementation

- Whether “A reproducible national MGB model configuration” is an appropriate outcome while that project is still in progress.
- Whether “Support analyses of shrub cover, spatial patterns, biomass, and carbon” accurately describes Rafael’s contribution to MAMBO, or whether biomass and carbon should appear only in the publication bullets.
- Whether the EIDC activities should mention metadata, licensing, DOI registration, or repository-specific quality assurance if those were part of the role.
- Whether “more than 400,000 ungauged river points” should remain in the Reference Streamflow outcome.
- Whether the three currently unassigned publications belong to an existing experience project or should remain standalone.
- Whether long publication titles should be shown in full in Experience or shortened there while retaining full titles in Publications.
