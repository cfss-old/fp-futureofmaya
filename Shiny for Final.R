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


tweetswords <-read_csv("tweetswords.csv")

tweetswords %>%
  head() %>%
  knitr::kable(caption = "Tweets with the word immigration")

reg <- "([^A-Za-z\\d#@']|'(?![A-Za-z\\d#@]))"

tweet_words <-tweetswords %>%
  filter(!str_detect(text, '^"')) %>%
  mutate(text = str_replace_all(text, "https://t.co/[A-Za-z\\d]+|&amp;", "")) %>%
  unnest_tokens(word, text, token = "regex", pattern = reg) %>%
  filter(!word %in% stop_words$word,
         str_detect(word, "[a-z]"))
 
 tweet_dates2 <- tweet_words %>%
separate(created, into = c("date", "time"), sep = -9)

feather::write_feather(tweet_dates2, "tweet_dates2.feather")

tweet_dates2 <- feather::read_feather("tweet_dates2.feather")


#User Interface
ui <- fluidPage(
  titlePanel("Tweeting Immigration"),
  sidebarLayout(
    sidebarPanel(
      selectizeInput(
        "word",
        "Words",
        choices = sort(unique(tweet_words$word)),
        multiple = TRUE
      )
    ),
    mainPanel(
      plotOutput("wordcloud"),
      plotOutput("sentiment"))
  ))


#Server Code
server <- shinyServer(function(input, output) {
  
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
              min.freq = 500, random.order = FALSE, rot.per=.15, colors = brewer.pal(8,"Dark2"))
  })
  
})

shinyApp(ui = ui, server = server)

