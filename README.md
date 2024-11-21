# Introduction
This R program was intended to serve as an in-class example of how to take untidied data stored in a .csv file and modify it to be a tidied data frame in R. The data used focused on various statistics related to hypoxia at different altitudes.

# Implementation
In this assignment, we started with a .csv file containing 6 observations of 9 variables related to hypoxia and its effects at different altitudes.

The first step was determining what changes would need to be made to tidy the data and outlining the steps to do so.  
To begin, we imported the data into two separate dataframes (one for labeling the final dataframe and then other for populating) and we also loaded the necessary tidyverse library.
Next, we started to create the tidied dataframe and piped in the original raw data. We renamed columns to be more informative, changed the formating of data to be consistent across all rows, and split values that held multiple pieces of information into separate columns.
# Conclusion
My main learning from this example was how each step of the tidying process works together to achieve the final tidied dataframe. Planning is important because it creates a clear set of tasks to be completed, the initial setup of data and packages ensures a smooth process, and finally the execution of the plan creates the final desired product.
In addition to a better overall understanding of the tidying process, this example also highlighted a few new methodologies that I wasn't familiar with that I can now use in my own future projects.

# Contact Information
email: ijp5139@psu.edu
