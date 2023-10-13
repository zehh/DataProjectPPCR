require(tidyverse)
url <- 'https://contattafiles.s3.us-west-1.amazonaws.com/tnt45405/T9gKrWnaRr5K0yT/FINAL%20-%20ELSI_students.dta'
dest_file <- 'C:/Users/Pedro Henrique/Documents/PPCR/Data Analysis Project/DataProjectPPCR/data.csv'
download.file(url, dest_file)
data <- read.csv('data.csv')
data <- as_tibble(data)

