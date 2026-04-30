<div align="center">
  <p><b>语言：</b> <a href="README.md">English</a> | <b>简体中文</b></p>
</div>

<div align="center">
  <h1>🫀 Robust-BP-Bench</h1>
  <p><b>专为连续血压估计打造的：高度精选、类均衡且包含高波动数据的 MIMIC-II 子集</b></p>

[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.19912053.svg)](https://doi.org/10.5281/zenodo.19912053)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![MATLAB](https://img.shields.io/badge/MATLAB-R2021a%2B-blue.svg)](https://www.mathworks.com/)

</div>

---

## 📌 项目简介 (Overview)

在开发连续无创血压（cNIBP）估计的机器学习模型时，最大的瓶颈之一是 MIMIC-II 等原始临床数据库中存在极端的类别不平衡。绝大多数数据段代表的是正常血压，导致模型在预测关键的高血压或低血压事件时表现极差。

**Robust-BP-Bench** 通过提供严格的 **4 区间分层采样协议 (4-bin stratified sampling protocol)** 解决了这一痛点。我们从 MIMIC-II 中提取了一个经过高度精选的子集，强制要求所有血压范围内的数据表示均等，从而确保你的模型能够学习到具有鲁棒性的底层特征，而不仅仅是预测一个平均值。

### 核心特性 (Key Features)
- **4 区间分层 (4-Bin Stratification)：** 在低血压 (<110)、正常 (110-130)、偏高 (130-150) 和高血压 (>150 mmHg) 四个类别间实现完美均衡。
- **严格质量控制 (Strict Quality Control)：** 内置算法自动过滤低方差信号、严重伪影和线性度极差的数据段。
- **深度学习就绪 (Ready for Deep Learning)：** 提供高信噪比 (SNR) 的生理信号，可直接用于特征提取或端到端模型训练。

---

## 🚀 零门槛快速上手 (Demo 模式)

想在不下载 50GB 原始 MIMIC-II 数据库的情况下，快速体验本筛选协议是如何工作的？我们提供了一个零依赖的合成数据生成器。

```bash
# 1. 克隆本仓库
git clone [https://github.com/phish-tech/Robust-Blood_Pressure-Benchmark.git](https://github.com/phish-tech/Robust-Blood_Pressure-Benchmark.git)
cd Robust-Blood_Pressure-Benchmark

# 2. 在 MATLAB 中运行合成数据生成器
>> generate_demo_dataset

# 3. 执行核心筛选协议 (请确保代码内 IS_DEMO_MODE = true)
>> run_data_selection
```

*该脚本将瞬间解析 Demo 数据，并输出一个完美均衡的 `demo_sampled_balanced.mat`。*

---

## 💾 下载完整数据集

源自真实 MIMIC-II 数据库、大小为 1GB 的完整“黄金子集”已托管至 Zenodo，供全球研究者永久开放访问。

👉 **通过 Zenodo 下载 [Robust-BP-Bench (dataset_sampled_balanced.mat)](https://zenodo.org/records/19912053)**

---

## 📊 数据集分布 (Demographics)

我们的协议保证了极其均衡的数据分布，这对于训练无偏回归模型至关重要。

<div align="center">
  <img src="demo_demographics.png" width="90%" alt="Dataset Demographics">
  <p><i>图 1: 精选子集的人口统计学分布，展示了完美均衡的 SBP 类别以及广泛的心率覆盖范围。</i></p>
</div>

*(通过运行我们脚本中的 demographic 部分，您可以在本地一键生成此分布图)。*

---

## 📚 引用 (Citation)

如果您在研究中使用了此数据筛选协议或我们策划的数据集，请引用我们即将发表的 EMBC 2026 论文：

```bibtex
@inproceedings{tianlab2026robustbp,
  title={Robust-BP-Bench: A Stratified Sampling Protocol for Continuous Blood Pressure Estimation},
  author={Your Name and Xiaorong Ding and Min He and Xi Tian},
  booktitle={48th Annual International Conference of the IEEE Engineering in Medicine and Biology Society (EMBC)},
  year={2026},
  organization={IEEE}
}
```
