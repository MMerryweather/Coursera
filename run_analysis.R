run_analysis = function() {
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
    setnames(
        features, old = c("V1","V2"), new = c("featureColumn","featureName")
    )
    setnames(subject_test, old = names(subject_test), new = "subject")
    setnames(subject_train, old = names(subject_train), new = "subject")
    setnames(Y_test,old = names(Y_test), new = "activityID")
    setnames(Y_train,old = names(Y_train), new = "activityID")
    setnames(X_test, old = names(X_test), new = features$featureName)
    setnames(X_train, old = names(X_train), new = features$featureName)
    setnames(
        activityLabels, old = names(activityLabels), new = c("activityID","activityLabel")
    )

    ## Create a logical vector for means and std dev then OR them together
    means = grepl(pattern = "-mean()",features$featureName, fixed = TRUE)
    stds = grepl(pattern = "-std()",features$featureName, fixed = TRUE)
    ## Use | over || as | is vectorized while || isn't
    meanAndStds = means | stds
    rm(means, stds, features)

    ## select affects cols while subset affects rows
    X_testSubset = subset(X_test, select = meanAndStds)
    X_trainSubset = subset(X_train, select = meanAndStds)
    rm(X_test, X_train, meanAndStds)

    ## Create a single testing and training data frame
    test = cbind(subject_test, X_testSubset, Y_test)
    train = cbind(subject_train, X_trainSubset, Y_train)
    rm(subject_test, X_testSubset, Y_test, subject_train, X_trainSubset, Y_train)

    ## Merge into one dataset
    data = rbind(test,train)
    rm(test,train)

    ## Add Activity Labels and get rid of activityID
    setkey(activityLabels, activityID)
    data = merge(data, activityLabels, by = "activityID")
    data[,activityID:= NULL]
    rm(activityLabels)
    ## -------------
    ## END OF PART 1
    ## -------------


    ## Summarize data
    setkey(data, activityLabel, subject)
    summaryDataWide = data %>% group_by(activityLabel, subject) %>%
        summarise_each(funs(mean))
    rm(data)

    ## Generate Tidy Data
    gatherCols = 3:68
    SummaryDataLong = summaryDataWide %>% gather(measurement, value, gatherCols)
    setcolorder(SummaryDataLong, c("subject", "activityLabel","measurement", "value"))
    SummaryDataLong[order(subject,activityLabel,measurement,value)]

    ## Output and return Tidy Data
    write.table(
        SummaryDataLong, file = "run_analysis.txt", append = FALSE, quote = FALSE, sep = ",", row.names = FALSE, col.names = TRUE
    )
    SummaryDataLong
}