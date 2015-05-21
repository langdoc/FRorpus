library(dplyr)
library(FRelan)

## First we have to read in the corpus objects which are in this case saved earlier.

corpus_saami <- tbl_df(readRDS(file = "corpus_saami.rds"))
corpus_kpv <- tbl_df(readRDS(file = "corpus_kpv.rds"))

## This is a demo, not a real application, so we just generate some metadata.
## I will soon rewrite this to work with each session and not token, so it
## looks less chaotic...

corpus_saami$rectime <- sample(1970:2015, nrow(corpus_saami), replace = T)
corpus_saami$Age <- sample(10:90, nrow(corpus_saami), replace = T)

corpus_kpv$rectime <- sample(1970:2015, nrow(corpus_kpv), replace = T)
corpus_kpv$Age <- sample(10:90, nrow(corpus_kpv), replace = T)

corpus_saami$Modus <- "written"
corpus_kpv$Modus <- "spoken"

corpus_saami$Sex <- sample(c("M", "F"), nrow(corpus_saami), replace = T)
corpus_kpv$Sex <- sample(c("M", "F"), nrow(corpus_kpv), replace = T)

corpus_saami$Genre <- sample(c("narrative", "tale", "teaching", "idiom", "literature", "interview", "title", "facta", "advertisement", "science", "flyer", "preface", "menu", "song"), nrow(corpus_saami), replace = T)

corpus_kpv$Genre <- sample(c("narrative", "tale", "teaching", "idiom", "literature", "interview", "title", "facta", "advertisement", "science", "flyer", "preface", "menu", "song"), nrow(corpus_kpv), replace = T)

## This is important for regex help in the beginning

regex_eng <- read.delim("data/regex-eng.txt")

## This is the main function

filtering <- function(language, regex, after, before, ignore){
        if (language == "Saami"){
                corpus <- corpus_saami
        }
        if (language == "Komi"){
                corpus <- corpus_kpv
        }
        data <- corpus %>% filter(grepl(regex, Token, perl = TRUE))
        data <- data %>% filter(grepl(after, After, perl = TRUE))
        data <- data %>% filter(grepl(before, Before, perl = TRUE))
        data <- data %>% filter(! grepl(ignore, Token, perl = TRUE))
#         data <- data %>% filter(Birthyear >= birthmin)
#         data <- data %>% filter(Birthyear <= birthmax)
#         data <- data %>% filter(Rectime >= recmin)
#         data <- data %>% filter(Rectime <= recmax)
#         data <- data %>% filter(Age >= agemin)
#         data <- data %>% filter(Age <= agemax)
}

