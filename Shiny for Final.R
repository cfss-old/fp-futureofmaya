library(shiny)
library(tidyverse)
library(readr)
library(dplyr)
library(ggplot2)
library(twitteR)
library(httpuv)
library(ggplot2)
library(scales)
library(readr)
library(tm)
library(stringr)
library(wordcloud)
library(knitr)
library(twitteR)
library(tidytext)
library(syuzhet)
library(lubridate)
library(ggplot2)
library(scales)
library(reshape2)
library(dplyr )
library(rtweet)
library(tidyverse)

allthetweets <-read_csv("allthetweets.csv")
tweetswords <- allthetweets %>%
  select(text, created) 

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

ui <- fluidPage(titlePanel("Tweeting Immigration"),
                sidebarLayout(
                  sidebarPanel(
                    dateRangeInput('dateRange',
                                   label = 'Date range input: yyyy-mm-dd',
                                   start = Sys.Date() - 2, end = Sys.Date() + 2
                    )
                  ),
                  mainPanel(plotOutput("daterange"),
                )))

server <- function(input, output) {
  filtered <- reactive({
    if(is.null(input$subtypeInput)) {
      return(NULL)
    }
    
  output$daterange <- renderPlot({
    if (is.null(filtered())) {
      return()
    }
    wordcloudAtXTime <- function(time1, time2) {
      time1= input$start
      time2= input$end
      starttime <- as.POSIXct("time1")
      endtime <- as.POSIXct("time2")
      forfunction <- tweet_dates2$date %>%
        filter(interval(starttime,endtime))
      tweet_words_count_function <- forfunction %>%
        count(word, sort = TRUE) %>%
        arrange(desc(n))
      ggplot(tweet_words_count_function[1:20,], aes(x= reorder(word, -n), y = n)) +
        geom_bar(alpha = 0.8, stat = "identity", show.legend = FALSE) + 
        coord_flip() +
        xlab("Number of Occurances") + ylab("Word") + ggtitle("Words Used in Tweets about Immigration")
      
  })
  
}

shinyApp(ui = ui, server = server)
