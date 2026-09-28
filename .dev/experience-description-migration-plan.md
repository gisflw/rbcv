# Experience and Project Content Migration Plan

Status: implemented. The English project copy below was used as the source for the migrated data.

## 1. Objective

Separate role summaries from project detail. The Experience section should give a broader view of each role, using the Experience section in `applications/company-role.md` as the reference for its level of detail. Do not copy that text into this plan.

The Projects section should hold the descriptions of individual projects, each linked to its role and carrying structured start and end date metadata. Replace each project's single `description` paragraph with three clearly labelled parts:

- **Scope:** one short paragraph explaining the purpose and boundaries of the project.
- **Main activities:** concise bullet points describing the work performed.
- **Main outcomes:** concise bullet points describing the principal deliverables and results, followed by the software and publications associated with that project.

The website and main PDF CV should draw roles and projects from the same structured data. Generate the shorter resume from that main CV source, using Experience, selected Software, and selected Publications, followed by short Education and Languages sections. The English project wording proposed below is the source for implementation and translation.

## 2. Recommended content model

Give each role a stable `id` and a short, translatable overview. Move the existing projects out of `experience.items[].projects` into a canonical project list; retain their current IDs and link each one to its role through `role`:

```yaml
experience:
  items:
  - id: example-role
    title: Example Role
    overview: [] # write from the company-role reference during migration
projects:
  items:
  - id: example-project
    role: example-role
    title: Example Project
    description: >-
      One combined paragraph.
```

Replace each project's `description` with the detailed structure, and add date metadata:

```yaml
projects:
  items:
  - id: example-project
    role: example-role
    title: Example Project
    startDate: '2025-07'
    endDate: null # ongoing; use YYYY, YYYY-MM, or YYYY-MM-DD as known
    scope: >-
      A brief description of the project's purpose and boundaries.
    mainActivities:
    - First activity.
    - Second activity.
    mainOutcomes:
    - First project result or deliverable.
```

Keep role dates and project dates distinct. Store project dates at the precision supported by the source, and derive localized display ranges from them; an open end date means ongoing work. Preserve existing client, partner, funder, and link metadata on the project records. The current `projects.items` cards are a separate, broad portfolio summary: reconcile their links and presentation with the canonical project records during migration so project descriptions are maintained in one place.

Add translatable section labels under `projects`:

```yaml
projects:
  scopeLabel: 'Scope:'
  activitiesLabel: 'Main activities:'
  outcomesLabel: 'Main outcomes:'
```

### Software and publication linking

Software and publications should continue to live only in their existing canonical lists (`achievements.items` and `publications.items`). During project rendering, select every item whose `project` value matches the project’s `id`, and append it as a bullet under **Main outcomes**.

This intentionally repeats those outputs in the Projects, Software, and Publications sections for readers, but avoids copying their metadata into multiple YAML locations. It also means that a future title, URL, DOI, type, or year correction needs to be made only once.

Recommended rendered forms:

- `Software: [Title](primary URL) — short description.`
- `Publication (Type, Year): [Title](DOI or URL).`

Where a software record contains both `url` and `repository`, use `url` as the title link and optionally add a separate `Repository` link after the description. Use the DOI as the preferred publication link, falling back to `url` when no DOI is present.

Publication bullets within a project must retain the order of the canonical publication list: descending `sortDate`, with source order preserved for equal dates. Software bullets should retain the order of the canonical software list.

## 3. Proposed English project copy

The role headings below group project drafts for editorial review; they are not proposed Experience copy. The bullets marked **Software** and **Publication** are output records that would be selected automatically through the existing `project` identifiers.

### Postdoctoral Researcher — Federal University of Rio Grande do Sul (UFRGS)

#### The Brazilian National Water Model

**Scope:** Development and evaluation of a national-scale implementation of the MGB hydrological model for Brazil.

**Main activities:**

- Assembly and harmonization of hydrological observations, environmental datasets, and geospatial inputs.
- Model parameterization and performance assessment across Brazilian river basins.
- Representation of reservoirs and water uses within the modeling framework.
- Development of reproducible workflows for data preparation, model evaluation, and scenario analysis.
- Model preparation for studies of land-use change, climate variability, and hydrological forecasting.

**Main outcomes:**

- A reproducible national MGB model configuration and supporting data-processing workflows, currently under development.
- **Software:** [MGB Vechy](https://github.com/gisflw/mgb-vechy) — utilities and workflows supporting hydrological data preparation for hydrological modeling.

#### Flood Alert System for Rio Grande do Sul

**Scope:** Supporting basin-scale flood monitoring and forecasting in Rio Grande do Sul.

**Main activities:**

- Validation and integration of water-level, streamflow, and geospatial datasets for flood monitoring.
- Development of water-level and streamflow modeling workflows for basin-scale forecasts.
- Production of operational visualizations for flood-warning activities.
- Development of quality-control procedures for flood-related environmental data.
- Rating-curve exploration for streamflow-observation preparation and interpretation.

**Main outcomes:**

- Integrated datasets, modeling workflows, and visual products supporting operational flood-warning activities.
- **Software:** [Flood QC](https://github.com/gisflw/flood-qc) — tools for quality control and validation of flood-related environmental data.
- **Software:** [Rating Curve Explorer](https://github.com/gisflw/rating-curve-explorer) — tools for organizing, visualizing, and performing initial analyses of streamflow data used in rating-curve derivation.

### Hydrology & Data Consultant — Independent

#### Priority Conservation Mapping

**Scope:** Identification of priority areas for native-vegetation conservation and restoration for water availability in the Cerrado region (Brazilian Savannah).

**Main activities:**

- Contribution of hydrological-modeling and spatial-analysis methods, emphasizing high-resolution topographic-data processing.
- Development and application of a topographic hydrological-importance indicator from digital terrain models, integrating HAND (Height Above Nearest Drainage) and TWI (Topographic Wetness Index) as measures of soil-saturation tendency, wetland and valley-bottom occurrence, and natural-infiltration potential.
- Geospatial-data processing and integration; definition of indicator transformations and methodological criteria; and contribution to analysis and visualization of results.

**Main outcomes:**

- A detailed spatial representation of topographic conditions associated with soil saturation and infiltration potential, distinguishing wetter valley bottoms and wetlands from slopes and plateaus with greater potential to receive and infiltrate rainfall.
- A topographic indicator incorporated into the natural hydrological-importance index and the method for classifying priority areas for water conservation in the Cerrado.
- **Software:** [Cerrado APCAC View](https://github.com/gisflw/cerrado-apcac-view) — interactive viewer for Cerrado APCAC data products and geospatial analyses.
- **Publication (Conference abstract, 2026):** [A geomorphology-based framework for identifying water conservation priorities in the Brazilian Cerrado savanna](https://doi.org/10.5194/egusphere-egu26-3592).
- **Publication (Dataset, 2026):** [Base de Dados Geoespaciais para Avaliação Multiescalar de Áreas Prioritárias de Conservação de Água no Bioma Cerrado](https://doi.org/10.5281/zenodo.21540477).

#### Water Availability Database

**Scope:** Redesign and migration of ANA’s geospatial database for water-availability information into a unified, documented PostgreSQL/PostGIS system.

**Main activities:**

- Diagnosis of the existing database structure, including tables, relationships, and spatial routines.
- Design of the new logical and physical PostgreSQL/PostGIS data model.
- Development of processing functions and migration routines for legacy records.
- Consolidation of water-availability data in a unified structure.
- Preparation of a user manual and technical training materials for data querying, updating, and ingestion.

**Main outcomes:**

- A unified database model, migration workflow, and documentation package for managing water-availability data.
- **Software:** [Brazilian Hydrological Availability Data System](https://github.com/gisflw/db-disphid) — an ETL framework for consolidating geospatial hydrological data in ANA’s water-availability data system, with traceable processing across versions of the national hydrographic network.

### Spatial Data Scientist — UK Centre for Ecology & Hydrology (UKCEH)

#### National River Flow Archive (NRFA)

**Scope:** Modernization of the spatial-data infrastructure of the UK’s official river-flow archive, including hydrological data, metadata, and catchment information for more than 1,600 stations. Replacement of manual processes and dispersed geographic files with a centralized system for data management and querying.

**Main activities:**

- Modeling and implementation of a PostgreSQL/PostGIS spatial database, with consolidation and standardization of data from shapefiles, rasters, spreadsheets, and other files.
- Development of Python routines for spatial processing, data ingestion, and calculation of catchment environmental attributes.
- Precomputation of attributes across the UK drainage network and reduced repeated processing per query.
- Database maintenance and support for catchment data products, including CAMELS-GB.

**Main outcomes:**

- A centralized spatial database with more than 3 million drainage-network points, each linked to more than 100 spatial and environmental attributes, in an architecture smaller than 3 GB.
- SQL queries completed in minutes instead of manual procedures and queries that could take days, with easier access across teams and more efficient, reproducible updates and addition of new stations.
- **Publication (Journal article, 2026):** [CAMELS-GB v2: hydrometeorological time series and landscape attributes for 671 catchments in Great Britain](https://doi.org/10.5194/essd-18-4345-2026).
- **Publication (Dataset, 2025):** [Catchment boundaries, daily and sub-daily hydrometeorological time series, groundwater level time series and attributes for 671 catchments in Great Britain (CAMELS-GB v2)](https://doi.org/10.5285/9a46d428-958f-4ac1-86eb-94eee70c0955).

#### Floods and Droughts Research Infrastructure (FDRI)

**Scope:** Transformation of high-resolution LiDAR data into integrated terrain products and reusable analysis resources for floods-and-droughts research in England and Wales.

**Main activities:**

- Development of workflows for high-resolution LiDAR processing into terrain-model inputs.
- Merging of source data into consistent digital terrain and digital surface models for England and Wales.
- Preparation of analysis examples on integrated elevation data in research workflows.

**Main outcomes:**

- An integrated LiDAR-based terrain and surface model for England and Wales, accompanied by reusable analysis examples.
- **Software:** [High Resolution DTM & DSM Processing Workflows](https://github.com/NERC-CEH/dtm-analysis) — Jupyter notebooks and scripts for processing high-resolution LiDAR-derived terrain and surface models for England and Wales.
- **Publication (Dataset, 2026):** [Merged LiDAR based Digital Terrain Model (DTM) and Digital Surface Model (DSM) for England and Wales](https://doi.org/10.5285/34443359-64c0-4909-9f27-bb5d47f1153f).

#### Modern Approaches to the Monitoring of Biodiversity (MAMBO)

**Scope:** Development of remote-sensing methods for MAMBO's habitat monitoring work, focusing on shrub mapping and height estimation from drone imagery, with LiDAR measurements used as height references.

**Main activities:**

- Development of an Attention U-Net workflow for shrub-segmentation model training and tiled inference across large drone RGB images.
- Conversion of segmentation predictions into mapped shrub outlines for spatial analysis.
- Development of a shrub-height workflow for normalization of structure-from-motion (SfM) surface models with terrain data, LiDAR reference-height extraction from point clouds at shrub polygons, and SfM-metric derivation for those polygons.
- Evaluation of machine-learning models for shrub-height estimation from SfM metrics using cross-validation.

**Main outcomes:**

- Reusable code for shrub delineation and height estimation, providing shrub extent and height information for habitat assessment and subsequent biomass research.
- **Software:** [Attention UNet for Shrub Segmentation](https://github.com/MAMBO-Habitat/attn-unet-shrub-id) — PyTorch training and tiled-inference workflow for extracting shrub outlines from drone-derived RGB imagery.
- **Software:** [Shrub Height Estimation](https://github.com/MAMBO-Habitat/shrub-height) — Scripts combining structure-from-motion surface models, terrain data, and LiDAR reference measurements to estimate height at shrub polygons.
- **Publication (Conference abstract, 2026):** [Deriving shrub biomass and carbon from affordable UAV observations](https://doi.org/10.5194/egusphere-egu26-13800).
- **Publication (Conference abstract, 2025):** [Biomass allometry for shrubs at a UK rewilding site](https://doi.org/10.5194/egusphere-egu25-11605).
- **Publication (Conference abstract, 2025):** [Shrub species, cover and biomass from affordable UAV observations](https://doi.org/10.5194/egusphere-egu25-1632).

#### Environmental Information Data Centre (EIDC)

**Scope:** Curation and preparation of environmental research datasets for ingestion, publication, and reuse through the EIDC’s data workflows.

**Main activities:**

- Review and preparation of submitted research datasets for ingestion.
- Application of consistent data-management practices throughout the preparation and release process.
- Resolution of data-organization issues affecting publication or downstream reuse.

**Main outcomes:**

- Publication-ready environmental datasets made available in forms suitable for reuse by other researchers.

### Researcher — Federal University of Rio Grande do Sul (UFRGS)

#### Integration of the Brazilian Official River Network to the MGB Hydrological Model

**Scope:** Integration of the MGB large-basin hydrological model with the Brazilian Ottocodified Hydrographic Base (BHO) for alignment of model units with the national vector river network.

**Main activities:**

- Development of methods for BHO river-network discretization during MGB preprocessing.
- Derivation of hydrological parameters from national hydrographic data.
- Development of procedures for consistent translation of the vector network into model units and inputs.
- Evaluation of the effects of discretization choices on national-scale hydrological modeling workflows.

**Main outcomes:**

- Preprocessing and parameter-derivation procedures enabling consistent use of the BHO river network in MGB applications.
- **Software:** [BHO2MGB](https://github.com/HGE-IPH/BHO2MGB) — a QGIS plugin for preprocessing the MGB Large Basin Model with Brazil’s Ottocodified Hydrographic Base (BHO).
- **Publication (Technical report, 2021):** [Cooperação em tecnologias para análises hidrológicas em escala nacional: sub-projeto — regionalização de vazões via modelagem hidrológica: métodos de discretização do modelo MGB e sua relação com a BHO](https://lume.ufrgs.br/handle/10183/253797).
- **Publication (Technical report, 2021):** [Cooperação em tecnologias para análises hidrológicas em escala nacional: sub-projeto — regionalização de vazões via modelagem hidrológica: MGB-BHO: pré-processamento do MGB em cima da base hidrográfica ottocodificada](https://lume.ufrgs.br/handle/10183/253840).

#### System of Environmental-Economic Accounting for Water (SEEA-Water) for Brazil

**Scope:** Quantification of the spatial and temporal variability of water stocks and fluxes across Brazil’s hydrographic regions for the System of Environmental-Economic Accounting for Water (SEEA-Water).

**Main activities:**

- Assembly of national datasets on precipitation, soil moisture, evapotranspiration, and water storage.
- Analysis of spatial and temporal variability across Brazilian hydrographic regions.
- Integration of hydrological evidence with information on water stocks and flows in environmental-economic accounts.

**Main outcomes:**

- National hydrological estimates and analyses supporting Brazil’s environmental-economic water accounts.
- **Publication (Journal article, 2022):** [Water storage variability across Brazil](https://doi.org/10.1590/2318-0331.272220220077).
- **Publication (Technical report, 2022):** [Cooperação em tecnologias para análises hidrológicas em escala nacional: subprojeto estimativas hidrológicas para contas econômicas ambientais da água (CEAA) no Brasil](https://lume.ufrgs.br/handle/10183/274942).
- *Global Evapotranspiration Datasets Assessment Using Water Balance in South America* (2022). (use the metadata in the data/)

#### Reference Streamflow Regionalization

**Scope:** Estimating long-term mean streamflow and Q95 low flow at ungauged locations across Brazil using machine-learning models and environmental predictors.

**Main activities:**

- Assembly of streamflow observations and environmental predictors for model development.
- Development of machine-learning models for long-term mean streamflow and Q95 estimation.
- Evaluation of model performance and uncertainty across different hydrological settings.
- Comparison of machine-learning estimates with alternative reference-streamflow methods.
- Generation of predictions for ungauged locations across the national hydrographic network.

**Main outcomes:**

- National reference-streamflow estimates for more than 400,000 ungauged river points, with associated performance and uncertainty assessments.
- **Software:** [ML Pipeline](https://github.com/gisflw/ml-pipeline) — reusable machine-learning pipeline components for environmental and geospatial modeling.
- **Publication (Preprint, 2025):** [Modeling Long-Term Flow Regimes in Ungauged Basins: An Evaluation of Machine Learning Performance and Uncertainty](https://doi.org/10.22541/essoar.175336960.03823488/v1).
- **Publication (Dataset, 2024):** [Reference Mean and Low Streamflow for all Brazilian Catchments Generated Using Machine Learning Models](https://doi.org/10.5281/zenodo.14217002).
- **Publication (Conference abstract, 2023):** [Streamflow Estimation in Ungauged Catchments in Brazil using Machine Learning Approaches](https://doi.org/10.5194/egusphere-egu23-844).
- **Publication (Technical report, 2021):** [Cooperação em tecnologias para análises hidrológicas em escala nacional: sub-projeto — regionalização de vazões via modelagem hidrológica: comparação de métodos para estimativas de vazões de referência: vazão média e Q95](https://lume.ufrgs.br/handle/10183/253831).
- **Publication (Technical report, 2021):** [Cooperação em tecnologias para análises hidrológicas em escala nacional: sub-projeto — regionalização de vazões via modelagem hidrológica: estimativa de vazão em locais sem dados usando machine learning](https://lume.ufrgs.br/handle/10183/253843).

#### Hydrological Assessment of Riparian Zones in the Brazilian Savannah

**Scope:** Identification of riparian zones and large-scale assessment of vegetation behavior in an agricultural-expansion region of the Brazilian Savannah.

**Main activities:**

- Extraction and mapping of drainage networks from digital elevation models for river-corridor identification.
- Analysis of terrain and topographic position, with representation of spatial variation in drainage density.
- Combination of remote sensing, vegetation indices, and evapotranspiration data for riparian-vegetation assessment.
- Application of the resulting methods to large-scale analysis of riparian zones in the Cerrado.

**Main outcomes:**

- A terrain-based method and mapped drainage information supporting large-scale identification and assessment of riparian vegetation.
- **Software:** [Topographic Position-based Stream definition (TPS)](https://github.com/gisflw/TPS) — an algorithm for extracting drainage networks from digital elevation models using topographic position.
- **Publication (Journal article, 2022):** [Topographic Position-based Stream definition (TPS): A simple method to address spatial variability of drainage density in stream networks](https://doi.org/10.1080/02626667.2022.2047190).
- *A comprehensive strategy for modeling watershed restoration priority areas under epistemic uncertainty: A case study in the Atlantic Forest, Brazil* (2023). [use the metadata in data/]

## 4. Record not attached to a project

The following publication has no `project` value and remains only in the Publications section:

- *How much inundation occurs in the Amazon River basin?* (2022).

## 5. Acceptance criteria

- Experience gives a broad overview for every role, with the Experience section in `applications/company-role.md` used as the editorial reference.
- Every one of the 12 projects has a role association, structured date metadata, one brief scope paragraph, an activities list, and an outcomes list in the canonical Projects data.
- Project descriptions appear in the Projects section and main CV; Experience does not duplicate the detailed project prose.
- The visible project labels are **Scope:**, **Main activities:**, and **Main outcomes:** in English, with approved equivalents in Portuguese and Spanish.
- All 11 software records, including both MAMBO repositories, appear under their linked projects and remain in the standalone Software section.
- All 20 project-linked publication records appear under their linked projects and remain in the standalone Publications section.
- The Amazon inundation publication remains without a project association.
- Related publications remain in descending `sortDate` order, preserving source order where dates are equal.
- Software/publication titles and links come from their canonical lists rather than copied project metadata.
- The resume is generated from the same source as the main CV and contains Experience, selected Software, selected Publications, then short Education and Languages; its selected records require no manually maintained duplicate descriptions.
- Website and main PDF CV present equivalent content in English, Portuguese, and Spanish.
- `hugo`, all three main PDF builds, and the resume build complete successfully.
- No files under `themes/hugo-profile/` are modified.