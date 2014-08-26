#Interfacing (read/write) with an Excel file from R

library(excel.link) #loads the excel.link extension library (the first time need to go to Tools, 
#Install Packages, and type 'excel.link' in the install wizard 'Packages' field, and install)

setwd("C:/Users/DECC/Documents/R_Greg/Excel_link_to_R/")#sets the working directory to where the Excel
#model is located

xl.workbook.open("SimpleModel.xlsx") #opens a specific Excel file

xl.sheet.activate("model_sheet_1") #activates the desired worksheet in the Excel model

xl[a1] <- 40 #Sets =[SimpleModel.xlsx]model_sheet_1!$A$1 equal to 40.  This is the input cell
#within the Excel model

result = xl[a6] #set 'result' equal to the new result from the model, haiving changed our input above

result #prints the result
