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
    #words <- removeWords(words, stopwords("english"))
    #words <- removeWords(words, profanity)
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
    #words <- removeWords(words, stopwords("english"))
    #words <- removeWords(words, profanity)
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