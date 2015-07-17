complete <- function(directory, id = 1:332) {
    filesList = list.files(directory, full.names = TRUE)
    filteredList =  filesList[id]
    tmp = vector(mode = "list",length = length(filteredList))
    tmp = lapply(filteredList, read.csv)

    tmpData = vector(mode = "list", length =  length(filteredList) )
    completeRows = function(df){
        nobs = sum(complete.cases(df))
        idNum = df[1,4]
        cbind(idNum,nobs)
    }
    tmpData = lapply(tmp, completeRows)
    data = as.data.frame(do.call(rbind,tmpData))
    data
}