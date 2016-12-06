
library(tidyverse)
library(lubridate)
library(stringr)
library(tidytext)
library(broom)
library(scales)
library(knitr)
library(neat)
library(tm)
library(syuzhet)
library(ggplot2)
library(scales)
library(reshape2)
library(dplyr )
library(twitteR)
library(rtweet)


tweets_immigrant<- searchTwitter('immigrant', n=1000)
tweets_immigration<- searchTwitter('immigration', n=1000)
tweets_illegal<- searchTwitter('illegal immigrant', n=1000)
tweets_freemovement<- searchTwitter('#freemovementofpeople', n=100)
tweets_immigrantnacion<- searchTwitter('immigrantnacion', n=100)
tweets_immigranttrump<- searchTwitter('immigrant4trump', n=1000)
tweets_american<- searchTwitter('#american', n=1000)


df_immigrant <- twListToDF(tweets_immigrant) %>%
  tbl_df()
df_immigrant

df_immigration <- twListToDF(tweets_immigration) %>%
  tbl_df()
df_immigration

df_ilegal <- twListToDF(tweets_illegal) %>%
  tbl_df()
df_ilegal

df_all <- list(`immigrant` = tweets_immigrant,
               `immigration` = tweets_immigration,
               `illegal immigrant` = tweets_illegal,
               `#freemovementofpeople` = tweets_freemovement,
               `immigrantnacion` = tweets_immigrantnacion,
               `immigrant4Trump` = tweets_immigranttrump,
               `#american` = tweets_american) %>%
  map_df(twListToDF, .id = "searchTerm") %>%
  write_csv("data/all_immigration.csv")


##this will be the code we use to pull particular usernames- can't tell if we need to specify dates for these as well... 
Xperson <- userTimeline("realDonaldTrump", n = 1000)

Xperson_df <- twListToDF(Xperson) %>%
  tbl_df()
Xperson_df


##Sentiment analysis

theme_set(theme_bw())
get_sentiments("bing")
get_sentiments("afinn")

immigration_tweets <- read.csv("data/all_immigration.csv", stringsAsFactors = FALSE)


#cleaining tweets
immigration_tweets$text <- clean_tweets(immigration_tweets$text)

#calculating sentiments from words



#looking at the sentiment scores 

head(mySentiment)

#binding sentiments to dataframe

immigration_tweets <- cbind(immigration_tweets, mySentiment)

View(immigration_tweets)

#coming up with a total sentiment score and graph

sentimentTotals <- data.frame(colSums(immigration_tweets[,c("anger", "anticipation", "disgust", "fear", "joy", "sadness", "surprise", "trust")]))
names(sentimentTotals) <- "count"
sentimentTotals <- cbind("sentiment" = rownames(sentimentTotals), sentimentTotals)
rownames(sentimentTotals) <- NULL
ggplot(data = sentimentTotals, aes(x = sentiment, y = count)) +
  geom_bar(aes(fill = sentiment), stat = "identity") +
  theme(legend.position = "none") +
  xlab("Sentiment") + ylab("Total Count") + ggtitle("Total Sentiment Score for All Tweets about Immigration")

#Highest sentiment is fear

