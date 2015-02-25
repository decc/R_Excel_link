library(excel.link)

xl.workbook.open("C:/Users/DECC/Documents/Github/R_Excel_link/example.xlsx")

xl.sheet.activate("sheet1")

xl[a1] <- 10
xl[a2] <- 20


result = xl[a4]
result








