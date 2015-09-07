corr = function(directory, threshold = 0) {
    filesList = list.files(directory, full.names = TRUE)
    tmp = vector(mode = "list",length = length(filesList))
    tmp = lapply(filesList, read.csv)

    #Fill a data frame with the number of observations
    nobs = complete(directory)
    stationAboveThreshold = nobs$nobs > threshold
    totalStationsAboveThreshold = sum(stationAboveThreshold)

    if (totalStationsAboveThreshold == 0) {
        #zero length vector
        corr = numeric()
        return(corr)
    }else{
        sulfateNitrateCorrelation = function(dataFrame) {
            #Extract just the data columns
            data = dataFrame[2:3]
            correlations = cor(data, use = "complete.obs")
            correlations[1,2]
        }

        allCorrelations = vector(mode = "list",length = length(filesList))
        for (i in seq_along(tmp)) {
            if (stationAboveThreshold[i] == TRUE) {
                allCorrelations[i] = sulfateNitrateCorrelation(tmp[[i]])
            }
        }
        #merge together and output as a vector
        corr = do.call(rbind,allCorrelations)
        corr = as.vector(corr)
        corr
    }
}