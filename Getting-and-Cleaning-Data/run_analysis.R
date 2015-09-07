run_analysis = function(output = FALSE) {
    library(data.table)
    library(dplyr)
    library(tidyr)

    ## Include only text files from the desired folders
    features = fread(input = "UCI HAR Dataset/features.txt")
    subject_test = fread(input = "UCI HAR Dataset/test/subject_test.txt")
    Y_test = fread(input = "UCI HAR Dataset/test/y_test.txt")
    subject_train = fread(input = "UCI HAR Dataset/train/subject_train.txt")
    Y_train = fread(input = "UCI HAR Dataset/train/y_train.txt")
    activityLabels = fread(input = "UCI HAR Dataset/activity_labels.txt")

    ## data.table(read.table) is due to bug #1256 in fread
    ## https://github.com/Rdatatable/data.table/issues/1256
    X_test = data.table(read.table(file = "UCI HAR Dataset/test/X_test.txt"))
    X_train = data.table(read.table(file = "UCI HAR Dataset/train/X_train.txt"))

    ## Add descriptive names to all our variables
    setnames(features, old = c("V1","V2"), new = c("featureColumn","featureName"))
    setnames(subject_test, old = names(subject_test), new = "subject")
    setnames(subject_train, old = names(subject_train), new = "subject")
    setnames(Y_test,old = names(Y_test), new = "activityID")
    setnames(Y_train,old = names(Y_train), new = "activityID")
    setnames(X_test, old = names(X_test), new = features$featureName)
    setnames(X_train, old = names(X_train), new = features$featureName)
    setnames(activityLabels, old = names(activityLabels), new = c("activityID","activity"))
    rm(features)

    ## Helper function to acoid lots of variables floating about
    ## Returns a data table containing just the cols with means and std devs
    meansAndStds = function(input){
        means = select(input, contains("mean"))
        stds = select(input, contains("std"))
        meansAndStds = dplyr::bind_cols(means, stds)
    }

    ## select affects cols while subset affects rows
    X_testSubset = meansAndStds(X_test)
    X_trainSubset = meansAndStds(X_train)
    rm(X_test, X_train)

    ## Create a single testing and training data frame
    test = dplyr::bind_cols(subject_test, X_testSubset, Y_test)
    train = dplyr::bind_cols(subject_train, X_trainSubset, Y_train)
    rm(subject_test, X_testSubset, Y_test, subject_train, X_trainSubset, Y_train)

    ## Merge into one dataset
    data = dplyr::bind_rows(test,train)
    rm(test,train)

    ## Add Activity Labels and get rid of activityID
    data = dplyr::inner_join(data,activityLabels,by="activityID")
    data = select(data,-activityID)
    rm(activityLabels)
    ## -------------
    ## END OF PART 1
    ## This is the datset requested in Q4
    ## -------------

    ## Summarize data
    data = data.table(data)
    setkey(data, activity, subject)
    summaryDataWide = data %>% group_by(activity, subject) %>%
        summarise_each(funs(mean))
    rm(data)

    ## Generate Tidy Data
    gatherCols = 3:88
    SummaryDataLong = summaryDataWide %>% gather(measurement, value, gatherCols)
    setcolorder(SummaryDataLong, c("subject", "activity","measurement", "value"))
    SummaryDataLong[order(subject,activity,measurement,value)]

    # Make columns nice factors
    for (col in 1:3) set (SummaryDataLong, j=col,value = as.factor(SummaryDataLong[[col]]))

    ## Output and return Tidy Data
    if (output == TRUE) {
        write.table(
            SummaryDataLong, file = "run_analysis.txt", append = FALSE, quote = FALSE, sep = ",", row.names = FALSE, col.names = TRUE
        )
    }
    SummaryDataLong
}