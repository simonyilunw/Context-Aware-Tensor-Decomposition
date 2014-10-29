Context-Aware-Tensor-Decomposition
==================================

Context Aware Tensor Decomposition method for our KDD 2014 and UbiComp 2014 paper

Please cite the following two papers when using the dataset.

[1] Yilun Wang*, Yu Zheng, Yexiang Xue. Travel Time Estimation of a Path using Sparse 
Trajectories. In the Proc. of KDD 2014

[2] Yu Zheng, Tong Liu, Yilun Wang, Yanchi Liu, Yanmin Zhu, Eric Chang. Diagnosing New York City’s
Noises with Ubiquitous Data. In Proceedings of UbiComp 2014.

[3] Yilun Wang, Yu Zheng, Tong Liu. A noise map of New York City. In Proc. of UbiComp 2014.


Description
--------
1. File folder TensorData encloses the text files of features extracted from original datasets.
2. TransformTxt2Mat.m reads the text files and transforms them by normalization. The results
are saved as .mat files enclosed in TensorMat file folder.
3. TensorForExperiment.m runs tensor decomposition (TD) with four different settings: (1) TD
without features, (2) TD plus spatial feature extracted POIs and road networks (TD+B), (3)
TD+B plus check-in feature (TD+B+D), and (4) TD+B+D plus the feature of noise category
correlations (TD+B+C+D). To evaluate the performance, we randomly choose 70% data as
train data and other 30% data as test data. The error metrics of the results of TD are RMSE
and MAE.
4. TensorForDemo.m obtains the result of tensor decomposition with all three features without
choosing 70% data as train data. The result is stored in .mat files, in folder TensorResult.
