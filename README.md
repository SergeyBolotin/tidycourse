# How the script works

1. Firstly the script reads test data, subject data for the test data, activity data for the test data and adds columns of activity and subjects to the test data table
2. The same things the script does for train data
3. After that the script merges rows of the test data and the train data into table "set"
4. Then the script reads the labels of features from "features.txt" and renames the  features columns.
5. Then the script selects columns that contains "mean" and "std" and creates a table "ext"  
6. Then the script reads labels of activity from "activity_labels.txt" and merges the "set" table and the table of names of activites by the acvtivity code key to add the column with the readable names of activities.
7. At  last the script makes tidy table "tid" by gathering columns of features of the table "ext", grouping them and summurising the average value for groups of activity, subject and feature. Then the script removes from the columns names the temp prefix 1-, 2- etc.
