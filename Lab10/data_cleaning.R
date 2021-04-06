############################################
######## Cleaning Brazil LAPOP Data #######
############# 2017/18 Round ###############
##########################################

# Clean Environment

rm(list = ls())

#packages
library(foreign)
library(tidyverse)
library(standardize)
library(dplyr)
library(haven)
library(labelled)


#set working directory

setwd("/Users/IsabelLaterzo/Dropbox/Poli784_2021/Labs/Lab10_Multinom_OrderedProb")

LAPOP <- list()

listdta <- dir(pattern = "*2018.dta")

myvars <- c("idnum",
            "vb3n", #vote choice
            "q1", #sex
            "q2", #age
            "capital1", #death penalty
            "b21") #confidence in political parties

#loop to read through data sets and bind them
for(i in 1:length(listdta)){
  if(i ==1) {
    LAPOP <- read_dta(listdta[i])[myvars]
  } else {
    object <- read_dta(listdta[i])
    newdata <- object[myvars]
    LAPOP <- rbind(LAPOP, newdata)}
  print(paste("Completed with", listdta[i]))
}

#changing various NAs to NA
LAPOP[is.na(LAPOP)] <- NA

#removing all labels
LAPOP <- remove_labels(LAPOP)

LAPOP$vote_choice <- LAPOP$vb3n

LAPOP$sex <- LAPOP$q1

LAPOP$age <- LAPOP$q2

LAPOP$capital_pun <- LAPOP$capital1


LAPOP <- LAPOP %>% dplyr::select(vote_choice, sex, age, capital_pun)
saveRDS(LAPOP, "BrazilLAPOP_2018.rds")
