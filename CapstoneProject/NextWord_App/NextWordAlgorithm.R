# Load packages
library(NLP)
library(tm)
library(RWeka)
library(data.table)
library(markdown)
library(stringi)


# Download data
if(!file.exists("Coursera-SwiftKey.zip")){
    download.file("https://d396qusza40orc.cloudfront.net/dsscapstone/dataset/Coursera-SwiftKey.zip",
                  "Coursera-SwiftKey.zip")
    unzip("Coursera-SwiftKey.zip")
}

# Download profanity
if(!file.exists("profanity.zip")){
    download.file("http://www.freewebheaders.com/wordpress/wp-content/uploads/full-list-of-bad-words-banned-by-google-txt-file.zip", "profanity.zip")
    unzip("profanity.zip")
    file.rename(list.files(pattern = "full-"), "profanity.txt")
}

# Set variables to the corpus
blogs <- readLines("./Coursera-SwiftKey/final/en_US/en_US.blogs.txt", encoding = "UTF-8", skipNul=TRUE)
news <- readLines("./Coursera-SwiftKey/final/en_US/en_US.news.txt", encoding = "UTF-8", skipNul=TRUE)
twitter <- readLines("./Coursera-SwiftKey/final/en_US/en_US.twitter.txt", encoding = "UTF-8", skipNul=TRUE)

# Sample 5% from each and create a new dataset if it doesn't already exist
if(!file.exists("./Coursera-SwiftKey/final/en_US/data")){
    dir.create("./Coursera-SwiftKey/final/en_US/data")
}
if(!file.exists("./Coursera-SwiftKey/final/en_US/data/BNTdata.txt")){
    set.seed(18)
    sampleBlogs <- blogs[sample(1:length(blogs),(length(blogs)*0.05))]
    sampleNews <- news[sample(1:length(news),(length(news)*0.05))]
    sampleTwitter <- twitter[sample(1:length(twitter),(length(twitter)*0.05))]
    dataset <- c(sampleBlogs,sampleNews,sampleTwitter)
    writeLines(dataset, "./Coursera-SwiftKey/final/en_US/data/dataset.txt")
}

# Clean the corpus of unnecessary characters
# Strip white space and any empty space at the end each word
profanity <- readLines("profanity.txt")
profanity <- stripWhitespace(profanity)
profanity <- sub("\\s+$", "", profanity)

data <- Corpus(DirSource("./Coursera-SwiftKey/final/en_US/data", "UTF-8"))

# lowercase
data <- tm_map(data, content_transformer(tolower))
# remove punctuation
data <- tm_map(data, removePunctuation)
# remove numbers
data <- tm_map(data, removeNumbers)
# strip whitespace
data <- tm_map(data, stripWhitespace)
# remove stop words
# data <- tm_map(data, removeWords, stopwords("english"))
# remove profanity
data <- tm_map(data, removeWords, profanity)

# Create document term matrix with different length (N-gram) tokens from the corpus
# N-gram tokenizers
gram1Tokenizer <- function(x) NGramTokenizer(x, Weka_control(min = 1, max = 1))
gram2Tokenizer <- function(x) NGramTokenizer(x, Weka_control(min = 2, max = 2))
gram3Tokenizer <- function(x) NGramTokenizer(x, Weka_control(min = 3, max = 3))
gram4Tokenizer <- function(x) NGramTokenizer(x, Weka_control(min = 4, max = 4))

# N-gram document term matrix
gram1dt <- DocumentTermMatrix(data, control = list(tokenize = gram1Tokenizer))
gram2dt <- DocumentTermMatrix(data, control = list(tokenize = gram2Tokenizer))
gram3dt <- DocumentTermMatrix(data, control = list(tokenize = gram3Tokenizer))
gram4dt <- DocumentTermMatrix(data, control = list(tokenize = gram4Tokenizer))

# Sum up each N-gram and sort by highest frequency
fq1 <- sort(colSums(as.matrix(gram1dt)), decreasing = TRUE)
fq2 <- sort(colSums(as.matrix(gram2dt)), decreasing = TRUE)
fq3 <- sort(colSums(as.matrix(gram3dt)), decreasing = TRUE)
fq4 <- sort(colSums(as.matrix(gram4dt)), decreasing = TRUE)

# Create data tables of N-grams
gram1 <- as.data.frame(data.table(word = names(fq1), freq = fq1))
gram2 <- as.data.frame(data.table(word = names(fq2), freq = fq2))
gram3 <- as.data.frame(data.table(word = names(fq3), freq = fq3))
gram4 <- as.data.frame(data.table(word = names(fq4), freq = fq4))

# Remove all instances with a frequency of 1
gram1 <- gram1[gram1$freq > 1,]
gram2 <- gram2[gram2$freq > 1,]
gram3 <- gram3[gram3$freq > 1,]
gram4 <- gram4[gram4$freq > 1,]

# Save the RData to file and NextWord application
save(gram1, file = "./Coursera-SwiftKey/final/en_US/gram1.RData")
save(gram2, file = "./Coursera-SwiftKey/final/en_US/gram2.RData")
save(gram3, file = "./Coursera-SwiftKey/final/en_US/gram3.RData")
save(gram4, file = "./Coursera-SwiftKey/final/en_US/gram4.RData")
save(gram1, file = "./NextWord_App/gram1.RData")
save(gram2, file = "./NextWord_App/gram2.RData")
save(gram3, file = "./NextWord_App/gram3.RData")
save(gram4, file = "./NextWord_App/gram4.RData")



# The following NextWord function will take an input phrase, clean it, 
# and search for the last 3 words (at the highest frequency) of the phrase in the 4-gram tokens.
# If no 4-gram is found, the algorithm will back-off to search the 3-gram tokens for the
# last 2 words in the phrase. If no 3-gram is found, the algorithm will back-off to search
# the 2-gram tokens for the last word in the phrase. Finally, if no 2-gram tokens are found,
# the algorithm will back-off to the highest frequency 1-gram token.
NextWord <- function(phrase){
    
    # process the phrase
    phrase <- tolower(phrase)
    words <- unlist(stri_extract_all_words(phrase))
    words <- removeWords(words, stopwords("english"))
    words <- removeWords(words, profanity)
    words <- removePunctuation(words)
    words <- removeNumbers(words)
    words <- stripWhitespace(words)
    words <- words[!(words == "")]
    
    # set upper bound of phrase length
    i = length(words)
    
    # clear NextWord
    NextWord <- as.character(NULL)
    
    # set exit as boolean
    found <- FALSE
    
    # search the 4-grams for the last 3 words in the phrase
    if(i >= 3 & !found){
        # build a string of the last 3 words
        wstr <- stri_c_list(list(words[(i-2):i]), sep = " ")
        wstr <- paste0(wstr, " ")
        wstr <- gram4[grep(wstr, gram4$word), ]
        
        # check for any matching N-gram
        if(length(wstr[,1]) >= 1){
            NextWord <- wstr[1,1]
            found <- TRUE
        }
    }
    
    # search the 3-grams for the last 2 words in the phrase
    if(i >= 2 & !found){
        # build a string of the last 2 words
        wstr <- stri_c_list(list(words[(i-1):i]), sep = " ")
        wstr <- paste0(wstr, " ")
        wstr <- gram3[grep(wstr, gram3$word), ]
        
        # check for any matching N-gram
        if(length(wstr[,1]) >= 1){
            NextWord <- wstr[1,1]
            found <- TRUE
        }
    }
    
    # search the 2-grams for the last word in the phrase
    if(i >= 1 & !found){
        # build a string of the last word
        wstr <- stri_c_list(list(words[i]), sep = " ")
        wstr <- paste0(wstr, " ")
        wstr <- gram2[grep(wstr, gram2$word), ]
        
        # check for any matching N-gram
        if(length(wstr[,1]) >= 1){
            NextWord <- wstr[1,1]
            found <- TRUE
        }
    }
    
    # if no word is found, display the highest frequency 1-gram 
    if(i > 0 & !found){
        NextWord <- gram1$word[1]
    }
    
    if(i > 0){
        NextWord <- stri_extract_last_words(NextWord)
        return(NextWord)
    }   
}

# This is same algorithm with the adjustment to return top results for data table
NextWords <- function(phrase){
    
    # process the phrase
    phrase <- tolower(phrase)
    words <- unlist(stri_extract_all_words(phrase))
    words <- removeWords(words, stopwords("english"))
    words <- removeWords(words, profanity)
    words <- removePunctuation(words)
    words <- removeNumbers(words)
    words <- stripWhitespace(words)
    words <- words[!(words == "")]
    
    # set upper bound of phrase length
    i = length(words)
    
    # clear NextWord
    NextWords <- as.character(NULL)
    
    # set exit as boolean
    found <- FALSE
    
    # search the 4-grams for the last 3 words in the phrase
    if(i >= 3 & !found){
        # build a string of the last 3 words
        wstr <- stri_c_list(list(words[(i-2):i]), sep = " ")
        wstr <- paste0(wstr, " ")
        wstr <- gram4[grep(wstr, gram4$word), ]
        NextWords <- wstr
        
        # check for any matching N-gram
        if(length(wstr[,1]) >= 1){
            found <- TRUE
        }
    }
    
    # search the 3-grams for the last 2 words in the phrase
    if(i >= 2 & !found){
        # build a string of the last 2 words
        wstr <- stri_c_list(list(words[(i-1):i]), sep = " ")
        wstr <- paste0(wstr, " ")
        wstr <- gram3[grep(wstr, gram3$word), ]
        NextWords <- wstr
        
        # check for any matching N-gram
        if(length(wstr[,1]) >= 1){
            found <- TRUE
        }
    }
    
    # search the 2-grams for the last word in the phrase
    if(i >= 1 & !found){
        # build a string of the last word
        wstr <- stri_c_list(list(words[i]), sep = " ")
        wstr <- paste0(wstr, " ")
        wstr <- gram2[grep(wstr, gram2$word), ]
        NextWords <- wstr
        
        # check for any matching N-gram
        if(length(wstr[,1]) >= 1){
            found <- TRUE
        }
    }
    
    # if no word is found, display the highest frequency 1-gram 
    if(i > 0 & !found){
        NextWords <- gram1
    }
    
    if(i > 0){
        colnames(NextWords)[which(names(NextWords) == "word")] <- "Words"
        colnames(NextWords)[which(names(NextWords) == "freq")] <- "Frequency"
        NextWords <- datatable(head(NextWords,10), rownames = FALSE,
                               options = list(paging = FALSE, searching = FALSE))
        return(NextWords)
    }
}
