#Interfacing with an Excel file from R by setting and getting data in named ranges

#load the excel.link extension library (the first time need to go to Tools, 
#Install Packages, and type 'excel.link' in the install wizard 'Packages' field, and install)
library(excel.link)

#setwd("C:/Users/DECC/Documents/R_Excel_link/")#sets the working directory to where the Excel
#model is located - not required when working with an R 'project'

#opens a specific Excel file
xl.workbook.open("C:/Users/DECC/Documents/R_Excel_link/SimpleModel.xlsx")

#activate the desired worksheet in the Excel model
xl.sheet.activate("model_sheet_2")

#create some values in a vector to send to the Excel named range
input_vector <- c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10)

#turn the above vector into a dataframe 
input_data <- data.frame(input_vector)

#have a quick look at the dataframe
str(input_data)

#Writes the values from the input_data dataframe into the input.data named range in the Excel file
#which contains the inputs of the example Excel model
xl[input.data] <- input_data

#create a new R vector and set it equal to the values in the output.data named range in the Excel file
#which contains the example model outputs
output_data <- xl[output.data]

#have a quick look at the new R vector
str(output_data)

#make a simple plot of the results (output_data)
plot(output_data)
lines(output_data)
