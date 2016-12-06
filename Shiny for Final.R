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

ui <- fluidPage(
  titlePanel("Tweeting Immigration"),
  sidebarLayout(
    sidebarPanel(
      dateRangeInput('dateRange',
                     label = 'Date range input: yyyy-mm-dd',
                     start = Sys.Date() - 2, end = Sys.Date() + 2
      )
    ),
    mainPanel(
      plotOutput("wordcloud"),
      plotOutput("sentiment")
    )
  )
)


server <- function(input, output) {
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
  })
}

shinyApp(ui = ui, server = server)
