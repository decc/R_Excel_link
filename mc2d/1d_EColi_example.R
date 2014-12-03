library(mc2d)
ndvar(100)
conc <- 10
cook <- mcstoc(rempiricalD, values=c(1,1/5,1/50), prob=c(0.027, 0.0373, 0.600))
serving <- mcstoc(rgamma, shape=3.93, rate=0.0806)
expo <- conc * cook * serving
dose <- mcstoc(rpois,lambda=expo)
r <- 0.001
risk <- 1-(1-r)^dose
EC1 <- mc(cook,serving,expo,dose,risk)
print (EC1)
summary(EC1)

#Correlated input variables
serving <- serving/183
plot(cook, serving)


cornode(cook, serving, target=0.5, result=TRUE)
#make some plots/summaries of cook and serving before and after running this to compare.
#Does this make new versions of these variable that are correleated?


#Greg's plot
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

threshold(risk, 0.02)
