
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

#User Interface
shinyUI(
  fluidPage(
    titlePanel("Tweeting Immigration"),
    sidebarLayout(
      sidebarPanel(
        h3("Instructions"),
        p("1. Wait patiently to see the input box. Type a word or words that you might find in a tweet about immigration"),
        p("2. Wait patiently again. See a wordcloud and sentiment analysis plot appear for your word(s)."),                    
        p("3. What do you make of all of this?"),
        hr(),
        em("Tweets were compiled at the end of November and all include the word 'immigrant' or the word 'immigration.'"),
        hr(),
        uiOutput("wordInput")
      ),
      mainPanel(
        plotOutput("wordcloud"),
        plotOutput("sentiment"))
    )
  )
)