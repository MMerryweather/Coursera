rankhospital = function(state, outcome, num = "best"){
    allData = read.csv("outcome-of-care-measures.csv")
    allStates = state.abb
    # Check to see if state is valid
    validState = (sum(allStates==state)) == 1
    if(validState == F){
        stop("invalid state")
    }

    # Check to see if the outcome is valid
    allOutcomes = c("heart attack", "heart failure","pneumonia")
    validOutcome = (sum(allOutcomes==outcome)) == 1
    if(validOutcome == F){
        stop("invalid outcome")
    }
    outcomeColumns = c(11,17,23)
    names(outcomeColumns) = allOutcomes
    col = outcomeColumns[outcome]

    # Collect the Name, the value and the state
    outcomeData = allData[allData$State == state & allData[col] != "Not Available",c(2,col)]
    names(outcomeData) = c("Hospital","OutcomeRate")

    # Convert factors to reals
    outcomeData[,outcomeData$OutcomeRate] = as.numeric(as.character(outcomeData$OutcomeRate))


}