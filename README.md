

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

### Overall Dataset Distribution
<img width="2000" height="615" alt="image" src="https://github.com/user-attachments/assets/49eca6e4-651d-4a46-8817-81798c7be748" />

### Selected Sample Dataset Distribution

<img width="2611" height="1064" alt="demo_demographics" src="https://github.com/user-attachments/assets/ae6e108d-2124-4b16-9d9f-439f174032de" />


## 📚 Citation
If you use this data selection protocol or the curated dataset in your research, please cite our upcoming EMBC 2026 paper:

[From Elastic to Viscoelastic: An EEMD-Enhanced Pulse Transit Time Model for Robust Blood Pressure Estimation](https://arxiv.org/abs/2604.27500)


---

## 🔬 Research Based on This Dataset: Accepted by EMBC 2026

The open-sourced `Robust-BP-Bench` dataset in this repository was curated specifically to support our group's latest breakthrough in continuous non-invasive blood pressure (cNIBP) estimation. This work has been officially accepted by **IEEE EMBC 2026**.

> 📄 **Paper Title:** *From Elastic to Viscoelastic: An EEMD-Corrected PTT Model for Precise Blood Pressure Tracking*

### 💡 Why Do Traditional PTT Models Fail?
Existing Pulse Transit Time (PTT) models are widely based on the Moens-Korteweg equation, which fundamentally assumes human blood vessels are "purely elastic" rigid tubes. However, real biological tissues exhibit **Viscoelasticity**. During severe blood pressure fluctuations, this viscoelasticity introduces a significant "Hysteresis" effect between PTT and actual BP, causing the accuracy of traditional models to drop precipitously.

### 🚀 Our Approach (The Secret Sauce)
We propose a novel EEMD-corrected PTT physical hybrid model, achieving a paradigm shift from "purely elastic" to "viscoelastic":

1. **Intersecting Tangent Method for Foot Localization:** Abandoning highly unstable peak detection, we utilize 10x Makima high-fidelity interpolation and the maximum rising slope tangent to provide a stable benchmark for PTT calculation that strictly aligns with hemodynamic definitions.
2. **Viscoelastic Compensation via EEMD:** Utilizing Ensemble Empirical Mode Decomposition (EEMD), we "dismantle" the PPG signal and extract the differential energy of high-frequency modes as the "viscoelastic compensation feature." This perfectly quantifies the signal's kinematic intensity, drastically offsetting motion artifacts and hysteresis errors.

<div align="center">
  <img width="1175" height="847" alt="Methodology" src="https://github.com/user-attachments/assets/21b2eef9-6601-438a-911b-d91ae0709aa5" />
</div>

### 🏆 Experimental Performance
Tested on the extreme clinical dataset open-sourced in this repository (which includes 23.4% hypertensive samples), our algorithm demonstrated excellent performance:

<div align="center">
  <img width="1480" height="1125" alt="Results" src="https://github.com/user-attachments/assets/7be5a667-f898-42cc-a32e-f8ea1608fb8f" />
</div>

* **Robust Beat-to-Beat Tracking:** Whether the blood pressure is experiencing severe fluctuations, sharp ascents, or downward trends, the EEMD-corrected model closely tracks the true arterial blood pressure (Ground Truth).

<br>

🔔 **Full Core Code Teaser:** The algorithmic framework, including EEMD signal decomposition and tangent foot localization, will be open-sourced in this repository upon the official publication of the paper.  
**[⭐ Star this repository]** to get notified of updates instantly!

🌐 For more information about the EMBC 2026 conference, please visit: [EMBC Official Website](https://embc.embs.org/)
