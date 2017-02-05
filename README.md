# Getting-Cleaning-Data-Week-4-Project
# 
#
# In this resporitory, you will find:
# 1) readme.md (this file)
# 2) codebook.md (codebook of the output dataset from the secript) 
# 3) Run_analysis.R (the script to download and process the raw data and output the processed dataset ("UCI HAR Dataset tidied.txt", and relevant dataframe in R enironment) for further analysis) 
#
# To create a tidied version of the dataset from the raw data:
# 1) Run "Run_analysis.R" with internet connection
# 2) The scripts will donwload the relevent information, unzip and process the data
# 3) The tidied dataset will be created as a .txt file with the name "UCI HAR Dataset tidied.txt" in your working directory
# 4) the following data frame will be in your environment:
#     test: all data from the 'test' group in the experiment
#     train: all data fro the 'training' group in the experiment
#     fullset: full set of data, combining both experimental groups
#     mean_std: extracted all variables which are mean and standard deviation from the fullset dataset
#     tidy_dataset: the tidied dataset groupping by each participant and each activity with the mean values of the mean and standard deviation. This dataset is the exported "UCI HAR Dataset tidied.txt" file. 
#
#
# 
