#monte carlo simulation example from: http://johnpurchase.com/monte-carlo-with-R.html

setwd("C:/Users/DECC/Documents/Github/R_Excel_link/")#sets the working directory to where the Excel
#model is located

library(excel.link) #loads the excel.link extension library (the first time need to go to Tools, 
#Install Packages, and type 'excel.link' in the install wizard 'Packages' field, and install)

library(mc2d) #loads the mc2d two dimensional monte carlo extension package

xl.workbook.open("SimpleModel.xlsx") #opens a specific Excel file

xl.sheet.activate("mc_model") #activates the desired worksheet in the Excel model


#a function for performing montecarlo analysis
monteSim <- function(low, high, conf_int=0.9, n=200){
  mu = mean(c(low,high))
  z = qnorm(1-(1-conf_int)/2)
  s = (high - mu)/z
  rnorm(n, mu, s)
}


#use the monteSim function to generate the vectors required for the problem
maintenance = monteSim(xl[e5],xl[f5])
labour = monteSim(xl[e6],xl[f6])
material = monteSim(xl[e7],xl[f7])
production = monteSim(xl[e9],xl[f9])



#assume a correlation between material costs and the level of production

matprod <-cbind(material, production)
plot(matprod) #a plot of the new matrix

matprodcor <- cornode(matprod, target = -0.75, result=TRUE)
plot(matprodcor)





#****create the posterior distribution
posterior.distribution = NULL #set up an empty vector to store the posterior distribution


for (i in 1:length(maintenance)){
  
  
  #enter the input assumptions from the distribution vectors  
  
  xl[h5] = maintenance[i]
  xl[h6] = labour[i]
  xl[h7] = matprodcor[i,1]
  xl[h9] = matprodcor[i,2]
  
  posterior.distribution[i] = xl[i11] #add result to vector
}



#result = (maintenance + labour + material) * production  #this is old - ignore
hist(posterior.distribution)


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

threshold(posterior.distribution, 400000)


