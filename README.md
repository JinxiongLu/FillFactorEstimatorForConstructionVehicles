
# FillFactorEstimatorForConstructionVehicles
[![DOI](https://zenodo.org/badge/260600483.svg)](https://zenodo.org/badge/latestdoi/260600483)

## Visualization of the result
![alt text](https://github.com/JinxiongLu/FillFactorEstimatorForConstructionVehicles/blob/master/Datasets/result.png)

## Description
Datasets and source code for paper "A neural network-based approach for fill factor estimation and bucket detection on construction  vehicles" submitted to ["Computer-Aided Civil and Infrastructure Engineering"](https://onlinelibrary.wiley.com/journal/14678667)

## Abstract
Bucket fill factor is of paramount importance in measuring the productivity of construction vehicles, which is the percentage of materials loaded in the bucket within one scooping. Additionally, the locational information of the bucket is also indispensable for scooping trajectory planning. Some research has been conducted to measure it via state-of-the-art computer vision approaches, but the robustness of applied system against various environment condition is not considered. In this study, we aim to fill this gap and six distinctive environment settings are included. Images are captured by a stereo camera and used to generate point clouds before being structured into 3D maps. This novel preprocessing pipeline for deep learning is originally proposed and its feasibility has been validated through this study. Moreover, Multi-Task Learning (MTL) is employed to exploit the positive relationship among two tasks: fill factor prediction and bucket detection.  Therefore, after preprocessing, 3D maps are forwarded to a Faster Region with Convolutional Neural Network (Faster R-CNN) incorporated with an improved Residual Neural Network (ResNet). The value of fill factor is acquired via a classification and probabilistic-based approach, which is novel and achieving an inspiring result (overall volume estimation accuracy:95.23$\%$ and detection precision:92.62$\%$) at the same time. This study validates the practicality of deep learning-based fill factor estimation and object detection solutions for real-time construction application.

## Remarks
* The Estimator/Detector is available [here](https://github.com/JinxiongLu/FillFactorEstimatorForConstructionVehicles/blob/master/trainedDetector.mat)
* Make sure MATLAB$^{TM}$ version is 2019b or above.
* Download datasets from [this link](https:www.baidu.com) with password (XXXX).
* Place all folders to D root directory (D:/) under Windows OS. For other OS, specific path written in the code are required to be modified accordingly.
* Most files and folders are named to be self-explanatory. For clarity, some names and its alternative are listed below.
'Datasets_ptd_map'----->'Training_sets'
'ptd_map'----->'3D map' 
'Tbl'----->'Table'
* The datasets under folders "1,", "2", "3" contain sparse types of volume only ranging from three to ten types, and they are exclusively for training set.
* Folders "1", "2", "3", "4" correspond to condition I, folder 5 relates to condition II and etc.
* To evaluate the model, please run script [EvaluationVolumeEstimation.m]([https://github.com/JinxiongLu/FillFactorEstimatorForConstructionVehicles/blob/master/Code/EvaluationVolumeEstimation.m](https://github.com/JinxiongLu/FillFactorEstimatorForConstructionVehicles/blob/master/Code/EvaluationVolumeEstimation.m)) and [EvaluationBucketDetection.m]([https://github.com/JinxiongLu/FillFactorEstimatorForConstructionVehicles/blob/master/Code/EvaluationBucketDetection.m](https://github.com/JinxiongLu/FillFactorEstimatorForConstructionVehicles/blob/master/Code/EvaluationBucketDetection.m))
*To inspect the structure of the Network, please load [RCNN.mat]([https://github.com/JinxiongLu/FillFactorEstimatorForConstructionVehicles/blob/master/RCNN.mat](https://github.com/JinxiongLu/FillFactorEstimatorForConstructionVehicles/blob/master/RCNN.mat)) and enter 
```deepNetworkDesigner```
in MATLAB$^{TM}$ command prompt.





<a rel="license" href="http://creativecommons.org/licenses/by-sa/4.0/"><img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by-sa/4.0/88x31.png" /></a><br />This work is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by-sa/4.0/">Creative Commons Attribution-ShareAlike 4.0 International License</a>.


