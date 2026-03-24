# Multimodal Single-Cell Genomics: Technology Evaluation, Methodological Development, and Applications in Acute Myeloid Leukaemia

**Author:** Reza Ghamsari  
**Institution:** University of New South Wales (UNSW) Sydney  
**Degree:** Doctor of Philosophy  
**Year:** 2022-2026

---

## Overview

This repository contains the analysis scripts, figure generation code, and supporting materials for my PhD thesis. The thesis investigates the regulatory and transcriptional architecture of acute myeloid leukaemia (AML) using integrative multimodal single-cell genomics, spanning snRNA-seq and scRNA-seq benchmarking, AML atlas construction, and characterisation of the molecular consequences of monosomy 7.

---

## Repository Structure

```
thesis_multimodal_single_cell/
│
├── chapter4_snRNA_scRNA_benchmarking/   # snRNA-seq vs scRNA-seq comparative analysis
│   ├── scripts/                          # Analysis scripts in order of execution
│   └── figures/                          # Generated figures
│
├── chapter5_mini_atlas/                 # Multimodal AML mini-atlas construction
│   ├── scripts/
│   └── figures/
│
├── chapter6_monosomy7/                  # Monosomy 7 single-cell characterisation
│   ├── scripts/
│   └── figures/
```

---

## Chapters

### Chapter 1 — CRISPR Single-Cell Perturbation Toolkit for Enhancer Interrogation
> Published review article

**Ghamsari R., Rosenbluh J., Menon A.V., Lovell N.H., Alinejad-Rokny H.**  
*Technological Convergence: Highlighting the Power of CRISPR Single-Cell Perturbation Toolkit for Functional Interrogation of Enhancers.*  
Cancers 2023, 15, 3566. https://doi.org/10.3390/cancers15143566

---

### Chapter 2 — Benchmarking snRNA-seq and scRNA-seq in AML
> Preprint / Submitted manuscript

Comparative analysis of matched single-nucleus and single-cell RNA sequencing datasets from 11 healthy donor bone marrow mononuclear cell (BMMC) samples. Characterises systematic biases including gene-length bias, ambient RNA contamination, and library complexity differences between the two platforms.

📁 Scripts: `chapter4_snRNA_scRNA_benchmarking/scripts/`  
📊 Data: Available at NCBI BioProject [PRJNA799242](https://www.ncbi.nlm.nih.gov/bioproject/PRJNA799242)  
📊 In-house data: Available at GEO [GSE303762](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE303762)

---

### Chapter 3 — Integrative Single-Cell Multiome Profiling of AML: A Longitudinal Reference Mini-Atlas

Construction of the first single-cell multiome (paired snRNA-seq + snATAC-seq) reference atlas of AML bone marrow, spanning 29 libraries from 11 AML patients across diverse cytogenetic subtypes and longitudinal disease stages, integrated with 10 healthy donor datasets.

📁 Scripts: `chapter5_mini_atlas/scripts/`

---

### Chapter 4 — Dissecting Intra-Tumour Heterogeneity across Cytogenetic Groups of AML
> Preprint / Submitted manuscript

Application of the multimodal atlas to characterise the cellular and regulatory consequences of monosomy 7 at single-cell resolution, including monosomy 7 clone tracking, and lineage-resolved transcriptional and chromatin accessibility analysis.

📁 Scripts: `chapter6_monosomy7/scripts/`

---

## Data Availability

| Chapter | Data | Accession |
|---------|------|-----------|
| Chapter 2 | BMMC benchmarking dataset | [PRJNA799242](https://www.ncbi.nlm.nih.gov/bioproject/PRJNA799242) |
| Chapter 2 | In-house cell line dataset | [GSE303762](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE303762) |
| Chapters 3 & 4 | AML multiome dataset | [EGAD50000002359](https://ega-archive.org/datasets/EGAD50000002359) |

---

## Software and Dependencies

Full session information is provided in each chapter's script folder.

---

## How to Use

Scripts within each chapter folder are numbered in order of execution:

---

## Citation

If you use any code or findings from this repository, please cite the relevant manuscript(s) listed above.

---

## Contact

**Reza Ghamsari**  
School of Biomedical Engineering  
University of New South Wales, Sydney, Australia  
📧 r.ghamsari@unsw.edu.au  
🔗 [GitHub](https://github.com/GhamsariReza)

---

## Acknowledgements

This work was supported by the University of New South Wales and conducted in collaboration with the Walter and Eliza Hall Institute of Medical Research (WEHI), Melbourne, Australia.
