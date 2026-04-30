

<div align="center">
  <h1>🫀  Robust_Blood_Pressure_Benchmark</h1>
  <p><b>A Curated, Balanced, and High-Fluctuation MIMIC-II Subset for Continuous Blood Pressure Estimation</b></p>

[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.19912053.svg)](https://doi.org/10.5281/zenodo.19912053)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![MATLAB](https://img.shields.io/badge/MATLAB-R2021a%2B-blue.svg)](https://www.mathworks.com/)

</div>

---

<div align="center">
  <p><b>Language:</b> <b>English</b> | <a href="README_ZH.md">简体中文</a></p>
</div>

## 📌 Overview

One of the major bottlenecks in developing Machine Learning models for continuous non-invasive blood pressure (cNIBP) estimation is the extreme class imbalance in raw clinical databases like MIMIC-II. Most segments represent normal blood pressure, making models perform poorly on critical hypertensive or hypotensive events.

**Robust-BP-Bench** solves this by providing a rigorous **4-bin stratified sampling protocol**. We extracted a highly curated subset from MIMIC-II that forces an equal representation across all BP ranges, ensuring your models learn robust features rather than just predicting the mean.

### Key Features
- **4-Bin Stratification:** Perfectly balanced classes across Hypotension (<110), Normal (110-130), Pre-hypertension (130-150), and Hypertension (>150 mmHg).
- **Strict Quality Control:** Built-in algorithms to filter out low-variance signals, severe artifacts, and poor linearity segments.
- **Ready for Deep Learning:** High Signal-to-Noise Ratio (SNR) segments ready for feature extraction or end-to-end training.

---

## 🚀 Zero-Setup Quickstart (Demo Mode)

Want to see how the selection protocol works without downloading the 50GB raw MIMIC-II database? We provide a zero-dependency synthetic data generator.

```bash
# 1. Clone the repository
git clone [https://github.com/phish-tech/Robust-BP-Bench.git](https://github.com/phish-tech/Robust-Blood_Pressure-Benchmark.git)
cd Robust-BP-Bench

# 2. Run the synthetic data generator in MATLAB
>> generate_demo_dataset

# 3. Execute the core selection protocol (Ensure IS_DEMO_MODE = true)
>> run_data_selection
```

The script will instantly parse the demo data and output a perfectly balanced demo_sampled_balanced.mat.


## 💾 Download the Full Dataset
The complete, 1GB curated "Golden Subset" derived from the actual MIMIC-II database is hosted on Zenodo for permanent open access.

👉 Download [Robust-BP-Bench]{https://zenodo.org/records/19912053} (dataset_sampled_balanced.mat) via Zenodo

## 📊 Dataset Demographics
Our protocol guarantees a balanced distribution, which is crucial for training unbiased regression models.

(Generate this plot locally by running the demographic section in our scripts).

## 📚 Citation
If you use this data selection protocol or the curated dataset in your research, please cite our upcoming EMBC 2026 paper:

Code snippet
