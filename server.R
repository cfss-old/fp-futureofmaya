library(shiny)
library(tidyverse)
library(readr)
library(dplyr)
library(ggplot2)
library(twitteR)
library(httpuv)
library(scales)
library(tm)
library(stringr)
library(wordcloud)
library(knitr)
library(tidytext)
library(syuzhet)
library(lubridate)
library(scales)
library(reshape2)
library(dplyr )
library(rtweet)
library(feather)
library(RColorBrewer)
library(rsconnect)

tweetswords <-read_csv("tweetswords.csv") %>%
  distinct()

reg <- "([^A-Za-z\\d#@']|'(?![A-Za-z\\d#@]))"

tweet_words <-tweetswords %>%
  filter(!str_detect(text, '^"')) %>%
  mutate(text = str_replace_all(text, "https://t.co/[A-Za-z\\d]+|&amp;", "")) %>%
  unnest_tokens(word, text, token = "regex", pattern = reg) %>%
  filter(!word %in% stop_words$word,
         str_detect(word, "[a-z]"))

#Server Code
shinyServer(function(input, output) {
  
  #Filter Tweets
  filtered_tweets <- reactive({
    if(is.null(input$word)) {
      return(NULL)
    }
    
    #Function to take term input, filter, and inner join with other words
    tweet_words %>%
      filter(word %in% input$word) %>%
      select(id) %>%
      unique() %>%
      inner_join(tweet_words)
  })
  
  filtered_tweets2 <- reactive({
    if(is.null(input$word)) {
      return(NULL)
    }
    
    
    tweet_words %>%
      filter(word %in% input$word) %>%
      select(id) %>%
      unique() %>%
      inner_join(tweet_words) %>%
      filter(word != "immigration",
             word != "immigrant",
             word != "#immigration",
             word != "immigrants") %>%
      left_join(get_sentiments("nrc")) %>%
      na.omit() %>%
      count(created, id, sentiment)
  })
  
  # create input for words
  output$wordInput <- renderUI({
    selectizeInput(
      "word",
      "Words",
      choices = sort(unique(tweet_words$word)),
      multiple = TRUE
    )
  })
  
  output$wordcloud <- renderPlot({
    if(is.null(filtered_tweets())){
      return()
    }
    
    tweet_words_count <- filtered_tweets() %>%
      count(word, sort = TRUE) %>%
      arrange(desc(n)) %>%
      filter(word != "immigration",
             word != "immigrant",
             word != "#immigration",
             word != "immigrants")
    
    wordcloud(words = tweet_words_count$word, freq = tweet_words_count$n, scale=c(8,.3),
              min.freq = 50, random.order = FALSE, rot.per=.15, colors = brewer.pal(8,"Dark2"))
  })
  
  output$sentiment <- renderPlot({
    if(is.null(filtered_tweets())){
      return()
    }
    
    sentimentTotals <- filtered_tweets2() %>%
      group_by(sentiment) %>%
      summarize(count = sum(n))
    
    ggplot(data = sentimentTotals, aes(x = sentiment, y = count)) +
      geom_bar(aes(fill = sentiment), stat = "identity") +
      theme(legend.position = "none") +
      xlab("Sentiment") +
      ylab("Total Count") +
      ggtitle("Number of Words in Selected Tweets Associated with Given Sentiment")
  })
  
})
