#Getting and Cleaning Data - Course Project

This is the course project for the Getting and Cleaning Data Coursera course. The R script, run_analysis.R, does the following:

1.Download the dataset if it does not already exist in the working directory
2.Loads both the training and test datasets
3.Merges the two datasets to create one common dataset
4.Load the activity and feature info
5.Extracting only mean and SD dataset
6.Descriptive activity name assignment
7.Converts the activity and subject columns into factors
8.Creates a tidy dataset that consists of the average (mean) value of each variable for each subject and activity pair.

The end result is shown in the file tidy.txt.