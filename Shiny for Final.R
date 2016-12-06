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

ui <- fluidPage(
  titlePanel("Tweeting Immigration"),
  sidebarLayout(
    sidebarPanel(
      textInput("word", "Word","Data Summary"),
      verbatimTextOutput("value")
    ),
  mainPanel(
    plotOutput("test"), #placeholder
    plotOutput("wordcloud"),
    plotOutput("sentiment"))
  ))



server <- shinyServer(function(input, output) {
  
  #output$test <- renderTable({
  #  print(input$word[1])
  #})
  
  
  output$wordcloud <- renderPlot({
    tweet_words_count <- tweet_dates2 %>%
      count(word, sort = TRUE) %>%
      arrange(desc(n)) %>%
      filter(word != "immigration",
             word != "immigrant",
             word != "#immigration",
             word != "immigrants")
    wordcloud(words = tweet_words_count$word, freq = tweet_words_count$n,
              min.freq = 1500, random.order = FALSE, colors = TRUE)
    output$value <- renderText({ input$word })
  })
  
})

shinyApp(ui = ui, server = server)
