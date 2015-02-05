setwd("C:/Users/DECC/Documents/Github/R_Excel_link/cluster")#sets the working directory to where the Excel
#model is located

library(excel.link) #loads the excel.link extension library

xl.workbook.open("heat_data.xlsx")

#xl.sheet.activate("data") #activates the desired worksheet in the Excel model
#(don't ned when using named ranges)

data <- data.frame(xl[data.heat])


datas <- data[c(10,11,21)]
names(datas) <- c("TEMPHOME", "TEMPGONE", "TOTALBTUSPH")

km <- kmeans(datas[,1:3], 3)
png("1.png")
plot(datas[,1], datas[,3], col=km$cluster, xlab="temp at home", ylab="temp out")
points(km$centers[,c(1,3)], col=1:3, pch=8, cex=2)
dev.off()
cluster.plot = current.graphics(filename = "1.png")
xl.sheet.activate("cluster") #activates the desired worksheet in the Excel model
xl[a1] = cluster.plot


#dumps the cluster allocations back into the table

xl.sheet.activate("data") #activates the desired worksheet in the Excel model
xl[v4] <- km$cluster 
