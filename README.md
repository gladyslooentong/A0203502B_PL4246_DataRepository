# A0203502B_PL4246_DataRepository

Project overview: This project is a network analysis of common stressors faced by Singaporean university undergraduates. The purpose of the repository is to gain insights into how 10 common stressors derived from a literature review affect university students. Data was collected in March 2023 from 108 undergraduates from the National University of Singapore. Variables of interest included the extent to which each of the 10 common stressors caused stress to each university student.

Data description: The repository is composed of two files- (1) CSV file of students' stress ratings of stressors; (2) R file of network analysis carried out on the CSV file. The CSV file was converted from an Excel file. The Excel file contained responses to a Google form, and it was cleaned to contain 108 rows of participant responses, and 11 columns comprised of participant ID and the 10 stressors. 

Repository structure: The CSV file containing students' responses ('stress_ratings.csv') can be found in the repository, followed by the R file of network construction and analysis on stressors ('stressor_network_analysis.R'). The R file uses the data in the CSV file to construct a network of stressors, and conduct a structured network analysis on it.

Instructions for use: Open the R file in RStudio, and import the CSV file into the working environment of RStudio. Install igraph, igraphdata, qgraph, influenceR, bootnet, ggplot2 and tidyverse packages in RStudio before constructing and analysing the network.

Contact details: Email at e0420708@u.nus.edu or contact 82287746 for further clarifications.

Acknowledgements: Amanda Goh Xin Yi and Ng Jian Rong
