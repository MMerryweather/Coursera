best = function(state, outcome){
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

    outcomeData = allData[,c(2,col,7)]
    names(outcomeData) = c("Hospital","OutcomeRate","State")
    stateOutcomes = subset(outcomeData, outcomeData$State == state)
    validData = subset(stateOutcomes, stateOutcomes$OutcomeRate != "Not Available")
    validData[,2] = as.numeric(as.character(validData[,2]))
    sortedData = validData[order(validData$OutcomeRate, validData$Hospital),]
    best = as.character(sortedData[1,1])
    best
}