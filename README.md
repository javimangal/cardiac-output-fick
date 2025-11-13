# The Two-Gasometry Indirect Fick Method for Cardiac Output Measurement in Critical Patients

[![Dataverse](https://img.shields.io/badge/Dataverse%20DOI-10.7910/DVN/J4ONSU-red)](https://dataverse.harvard.edu/dataset.xhtml?persistentId=doi:10.7910/DVN/J4ONSU) [![Preprint DOI](https://img.shields.io/badge/preprint_DOI-10.1101%2F2025.03.05.25323438v2-%23000080?label=medRxiv&link=https%3A%2F%2Fwww.medrxiv.org%2Fcontent%2F10.1101%2F2025.03.05.25323438v2)](https://www.medrxiv.org/content/10.1101/2025.03.05.25323438v2)

Project documentation for reproducibility of the study ***"The Two-Gasometry Indirect Fick Method for Cardiac Output Measurement in Critical Patients"***. The study aimed to determine agreement and clinical interchangeability of cardiac output and cardiac index measurements from transthoracic echocardiography (reference test) and the two-gasometry indirect Fick method (index test) in critical care patients from a low-resource hospital in Querétaro, México. 

The linked dataset for this study can be found in the [Harvard Dataverse](https://dataverse.harvard.edu/dataset.xhtml?persistentId=doi:10.7910/DVN/J4ONSU). The main analysis scripts import the data directly from the Harvard Dataverse, so it is not necessary to download a copy of the data to reproduce the analyses.

## How to use

The suggested use of this repository starts with making sure that R and RStudio are installed in your computer:
1. Install [R and RStudio](https://posit.co/download/rstudio-desktop/) on your computer if you haven't done so. (Note that these analyses were conducted under R version 4.5.0 and RStudio 2025.05.0).
2. [Clone this repository](https://docs.github.com/en/repositories/creating-and-managing-repositories/cloning-a-repository). If you do not know how to do this, [you can follow these instructions](https://docs.github.com/en/desktop/overview/getting-started-with-github-desktop). Alternatively, you can [download the ZIP file](https://github.com/javimangal/cardiac-output-fick/archive/refs/heads/main.zip), unpack it, and place it in a folder in your computer.
3. You should now have all these files in your computer with an identical folder structure (described in the following section).
4. In the main directory, open the file named ***cardiac-output-fick.Rproj*** in RStudio.
5. You can navigate through the folders on the right-bottom panel of R Studio. Open the **R** folder. You should now see a series of files ending with ***.qmd***.
6. Open one of the .qmd files. You can run every chunk of code sequentially to reproduce the analyses. Make sure to respect the order and if something fails, I recommend that you start running al chunks of code from the beginning. If you don't know how to run a chunk of code, you can [imitate what this person is doing](https://youtu.be/RPF6gGyeJmg?feature=shared&t=30). If you get a message saying "Access denied", change from *Visual* to *Source* mode which can be done with the Ctrl+Shift+F4 command.
7. Please note that scripts are meant to be sourced into the flow of analyses in the main .qmd files. You may encounter problems if you attempt to run the scripts independently. 

If you are not able to follow the prior steps, you may also consider reviewing the [PDF reports](docs/reports) documenting the analyses. 

-   [Part 0](R/parte_0_limpieza_datos.qmd). Descriptions for importing variable attributes and data cleaning for analysis. [PDF](docs/reports/parte_0_limpieza_datos.pdf), [docx](docs/reports/parte_0_limpieza_datos.docx)
-   [Part 1](R/parte_1_descriptivos.qmd). Descriptive analyses. [PDF](docs/reports/parte_1_descriptivos.pdf), [docx](docs/reports/parte_1_descriptivos.docx)
-   [Part 2](R/parte_2_cardiac_output.qmd). Comparisons of the two-gasometry indirect Fick method against TTE for cardiac output measurement. [PDF](docs/reports/parte_2_cardiac_output.pdf), [docx](docs/reports/parte_2_cardiac_output.docx)
-   [Part 3](R/parte_3_cardiac_index.qmd). Comparisons of the two-gasometry indirect Fick method against TTE for cardiac index measurement. [PDF](docs/reports/parte_3_cardiac_index.pdf), [docx](docs/reports/parte_3_cardiac_index.docx)

## Project Structure

The project structure distinguishes three kinds of folders:
- read-only (RO): not edited by either code or researcher
- human-writeable (HW): edited by the researcher only.
- project-generated (PG): folders generated when running the code; these folders can be deleted or emptied and will be completely reconstituted as the project is run.

```         
.
├── .gitignore
├── CITATION.cff
├── LICENSE
├── README.md
├── cardiac-output-fick.Rproj
├── data                  <- All project data files
│   ├── processed         <- The final, canonical data sets for modeling. (PG)
│   ├── raw               <- The original, immutable data. (RO)
│   └── temp              <- Intermediate data that has been transformed. (PG)
├── docs                  <- Documentation for users (HW)
│   ├── manuscript        <- Manuscript source, docx. (HW)
│   └── reports           <- Project reports, pdf. (HW)
├── results
│   ├── output_figures    <- Figures for the manuscript or reports (PG)
│   └── output_tables     <- Output tables for the manuscript (PG)
└── R                     <- Source code for this project (HW)
    ├── scripts           <- Scripts sourced in main R markdown documents (PG)
    └── sessions          <- Text files with information of R sessions (PG)

```

## License

This project is licensed under the terms of the [MIT License](/LICENSE).

This project structure template repository is adapted from the [Good Enough Project](https://github.com/bvreede/good-enough-project) Cookiecutter template by Barbara Vreede (2019).
