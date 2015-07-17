add2 = function(x,y){
  x + y
}

above10 = function(x){
  use = x > 10
  x[use]
}

#Defaults are assigned by using the = operator
above = function(x,n = 10){
  use = x > n
  x[use]
}

columnMean = function(x, removeNa = TRUE){
  nc = ncol(x)
  means = numeric(nc)
  for(i in 1:nc){
    means[i] = mean(x[,i], na.rm = removeNa)
  }
  means
}