#monte carlo simulation example from: http://johnpurchase.com/monte-carlo-with-R.html

setwd("C:/Users/DECC/Documents/R_Greg/R_Excel_link/")#sets the working directory to where the Excel
#model is located

library(excel.link) #loads the excel.link extension library (the first time need to go to Tools, 
#Install Packages, and type 'excel.link' in the install wizard 'Packages' field, and install)

xl.workbook.open("SimpleModel.xlsx") #opens a specific Excel file

xl.sheet.activate("mc_model") #activates the desired worksheet in the Excel model


#a function for performing montecarlo analysis
monteSim <- function(low, high, ci=0.9, n=100){
  mu = mean(c(low,high))
  z = qnorm(1-(1-ci)/2)
  s = (high - mu)/z
  rnorm(n, mu, s)
}


#use the monteSim function to generate the vectors required for the problem
maintenance = monteSim(xl[c4],xl[d4])
labour = monteSim(xl[c5],xl[d5])
material = monteSim(xl[c6],xl[d6])
production = monteSim(xl[c7],xl[d7])

result = (maintenance + labour + material) * production

#plot the results
threshold <- function(v, t, low.col="red", high.col="green") {
  d = density(v)
  l = length(d$x)
  n = length(d$x[d$x<t])
  plot(d)
  x = c(d$x[1:n], d$x[n])
  y = c(d$y[1:n], d$y[1])
  polygon(x,y, col=low.col)
  x = c(d$x[n], d$x[n:l])
  y = c(d$y[1], d$y[n:l])
  polygon(x, y, col = high.col)
  pct = c(length(v[v<t])/length(v), 1 - length(v[v<t])/length(v))
  pct = pct * 100   
  labels = c("below", "above")  
  labels = paste(labels, pct)
  labels = paste(labels, "%", sep="")  
  legend(min(d$x) ,max(d$y), labels, fill=c(low.col, high.col))
}

threshold(result, 400000)
