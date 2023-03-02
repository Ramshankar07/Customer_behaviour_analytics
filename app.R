#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#
install.packages("data.table")
#### Load required libraries
library(data.table)
library(ggplot2)
library(ggmosaic)
library(readr)

# Assigning to variables
transac <- QVI_transaction_data
purchase <- QVI_purchase_behaviour

str(transac)
str(purchase)
#summaries the csv
summary(transac)
# printing first 6 rows
head(transac)

#changing the format of date
transac$DATE <- as.Date(transac$DATE, origin = "1899-12-30")
# printing first 6 rows
head(transac)

#summaries the csv
summary(transac$PROD_NAME)

# Examining the words in PROD_NAME 
productWords <- data.table(unlist(strsplit(unique(transac$PROD_NAME), " 
")))
setnames(productWords, 'words')
head(productWords)

#deleting and replacing blank for digits in prod_name
transac$PROD_NAME <- gsub('[[:digit:]]+', '', transac$PROD_NAME)
transac$PROD_NAME <- gsub('[[:punct:]]+', '', transac$PROD_NAME)
head(transac)

#Remove digits, and special characters, and then sort the distinct words by frequency of occurrence.
word_freq <- sort(table(transac$PROD_NAME), decreasing=TRUE) 
head(word_freq)

### Remove salsa products
transac[ SALSA = grepl("salsa", tolower(PROD_NAME))]

#missing values
sum(is.na(transac))
#summary 
summary(transac)

#filtering out to find out customers who bought 200 chips
transac_1 <- transac[transac$PROD_QTY == 200,]
head(transac_1)

#Clear out customers who bought 200 chips
transac_2 <- transac[transac$LYLTY_CARD_NBR != 226000,]
head(transac_2)

#count txn by date
install.packages("plyr")
library('plyr')
Freq_count_by_date <- count(transac_2$DATE)

range <- seq(as.Date("2018-07-1"), as.Date("2019-06-30"), by = "days")

library(fuzzyjoin)
head(range)
fuzz <-  
