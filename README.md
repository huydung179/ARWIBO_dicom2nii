# ARWIBO_dicom2nii

Images are from:

http://www.arwibo.it


Diagnosis:

- CN: cognitively normal 
- AD: Alzheimer's Disease
- CBD: Corticobasal degeneration
- FTD: Frontotemporal disorders
- LBD: Lewy body dementia
- MCI: Mild Cognitive Impairment
- MDD: Major Depressive Disorder
- MSA: Multiple system atrophy
- ND: ???
- PD: Parkinson's disease
- SMI: Severe mental illness
- SVD: Cerebral small vessel disease
- OTHER: Other


The original data repository contains 3481 DICOM images.

To convert DICOM data to .nii format:
- Clone file "convert.sh" from https://github.com/huydung179/ARWIBO_dicom2nii 
- Run the following command:
    ```bash convert.sh [DICOM images directory]```

Please note that one DICOM image can be converted into several different .nii images.
We need to select the best image among them.
Some other .nii image are in 4D format (For exemple: img.shape = [100, 100, 100, 2] with img[..., 0] is the left hemisphere, img[..., 1] is the right hemisphere). 
We need to transform these images to 3D format.
You can do that with the help of "arwibo_quality_control.ipynb" from https://github.com/huydung179/ARWIBO_dicom2nii  


After the quality control, we retain only FLAIR and T1w images:
1679 FLAIR, 1455 T1w.
Some minimal information from patients can be found in "flair_info.csv" and "t1w_info.csv" from https://github.com/huydung179/ARWIBO_dicom2nii 
