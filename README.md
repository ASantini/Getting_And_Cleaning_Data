### How to Execute the R Script in the R Console
First and formost the working directory that you are using must contain the unzipped "UCI HAR Dataset" directory that can be downloaded at [https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip].
Once the data set has been unzipped calling 
`source("run_analysis.R")`
in the R Console will cause the script to be executed. **The script uses the "reshape2" library which will need to be installed if it hasn't been already.**

### How to view the data in the R console
After the script has been executed the user should find a "TidyData.txt" file in their working directory.
To view the data in the R Console use the following code
`viewData <- read.table("TidyData.txt", header=TRUE)
head(viewData)`

### What the Script Does
Once the data set has been manually downloaded from [https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip] has been unzipped the script executed the following tasks

1. Reads the "X\_test.txt" and "X\_train.txt" files into memory as dataframes and then combines them in to on large data frame
2. Read the "features.txt" files into memory as a data frame, then extracts the second column and assigns the result to the column names of the data set.
3. Using the grepl() function, the columns that contain standard deviation and mean values are extracted into a new data frame.
4. The column names of the new data frame are then extracted and made more readable using the sub() function. Once this is done the new names are the assigned to the columns in the data frame, replacing the old, less readable column names.
5. Using the same process as in Step 1, the script reads the data that identifies the Subject and the Activity that was performed and then binds that data to the data set with the measurements
6. The number identifiers for the activity are replaced with the corresponding text values from the "activity_labels.txt" files.
7. Using the melt function from the "reshape2" library the data is cast into a form that uses the "Subject" and "Activity" columns as ids and the remaining columns as variables. This is then recast to the tidy data set's final form which has the two ids column followed by the means of all of the variables.
8. This dataset is the written to the file "TidyData.txt" in the current working directory.
