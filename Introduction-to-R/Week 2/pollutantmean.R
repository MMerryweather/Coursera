pollutantmean = pollutantmean <- function(directory, pollutant, id = 1:332){
    filesList = list.files(directory, full.names = TRUE)
    filteredList =  filesList[id]
    tmp = vector(mode = "list",length = length(filteredList))
    tmp = lapply(filteredList, read.csv)

    data = do.call(rbind,tmp)

    pollutantData = data[[pollutant]]
    pollutantmean = mean(pollutantData, na.rm = T)
    pollutantmean
}
