<p align="center">
<br>
  <img src="docs/images/logo.png" alt="ClassyRadiomics">
</p>

[![License](https://img.shields.io/badge/license-Apache%202.0-green.svg)](https://opensource.org/licenses/Apache-2.0)
[![CI Build](https://github.com/pwoznicki/ClassyRadiomics/actions/workflows/testing.yml/badge.svg)](https://github.com/pwoznicki/ClassyRadiomics/commits/deploy)
[![codecov](https://codecov.io/gh/pwoznicki/ClassyRadiomics/branch/deploy/graph/badge.svg)](https://codecov.io/gh/pwoznicki/ClassyRadiomics)

## Simple pipeline for experimenting with radiomics features

## Installation

```bash
git clone https://github.com/piotrekwoznicki/ClassyRadiomics.git
cd classrad
pip install -e .
```

## Example - Hydronephrosis detection from CT images:

### Extract radiomics features and save them to CSV table

```python
df = pd.read_csv(table_dir / "paths.csv")
extractor = FeatureExtractor(
    df=df,
    out_path=(table_dir / "features.csv"),
    image_col="img_path",
    mask_col="seg_path",
    verbose=True,
)
extractor.extract_features()
```

### Create a dataset from the features table

```python
feature_df = pd.read_csv(table_dir / "features.csv")
data = Dataset(
    dataframe=feature_df,
    features=feature_cols,
    target=label_col="Hydronephrosis",
    task_name="Hydronephrosis detection"
)
data.cross_validation_split_test_from_column(
    column_name="cohort", test_value="control"
)
```

### Select classifiers to compare

```python
classifier_names = [
    "Gaussian Process Classifier",
    "Logistic Regression",
    "SVM",
    "Random Forest",
    "XGBoost",
]
classifiers = [MLClassifier(name) for name in classifier_names]
```

### Create an evaluator to train and evaluate selected classifiers

```python
evaluator = Evaluator(dataset=data, models=classifiers)
evaluator.evaluate_cross_validation()
evaluator.boxplot_by_class()
evaluator.plot_all_cross_validation()
evaluator.plot_test()
```
