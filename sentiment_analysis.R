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
library(rtweet)
library(httpuv)
library(readr)
library(tm)
library(stringr)
library(wordcloud)
library(plyr)

##Sentiment analysis

theme_set(theme_bw())
get_sentiments("bing")
get_sentiments("afinn")

##getting tweets
immigrant_immigration_tweets <- read.csv("allthetweets.csv", stringsAsFactors = FALSE)
immigrant_immigration_tweets <- immigrant_immigration_tweets %>%
select(screenName, text, created) 

##so it looks like this did change the dates, but it's still a character string, so I don't know if we're going to be able to do math on this
immigrant_immigration_tweets$created <- with_tz(ymd_hms(immigrant_immigration_tweets$created), "America/Chicago")



###Sentiment analysis
#calculating sentiments from words

mySentiment <- get_nrc_sentiment(immigrant_immigration_tweets$text)


#looking at the sentiment scores 

head(mySentiment)

#binding sentiments to dataframe


immigrant_tweets_with_sentiment <- cbind(immigrant_immigration_tweets, mySentiment)
View(immigrant_tweets_with_sentiment)
write_csv(immigrant_tweets_with_sentiment, "immigrant_tweets_with_sentiment.csv")

#coming up with a total sentiment score and graph

sentimentTotals <- data.frame(colSums(immigrant_tweets_with_sentiment[,c("anger", "anticipation", "disgust", "fear", "joy", "sadness", "surprise", "trust")]))
names(sentimentTotals) <- "count"
sentimentTotals <- cbind("sentiment" = rownames(sentimentTotals), sentimentTotals)
rownames(sentimentTotals) <- NULL
ggplot(data = sentimentTotals, aes(x = sentiment, y = count)) +
  geom_bar(aes(fill = sentiment), stat = "identity") +
  theme(legend.position = "none") +
  xlab("Sentiment") + ylab("Total Count") + ggtitle("Total Sentiment Score for All Tweets about Immigration")

#Highest sentiment is fear, but closely followed by trust...which is pretty weird

#looking at it in terms of positive or negative

sentimentTotals2 <- data.frame(colSums(immigrant_tweets_with_sentiment[,c("positive","negative")]))
names(sentimentTotals2) <- "count"
sentimentTotals2 <- cbind("sentiment" = rownames(sentimentTotals2), sentimentTotals2)
ggplot(data = sentimentTotals2, aes(x = sentiment, y = count)) +
geom_bar(aes(fill = sentiment), stat = "identity") +
theme(legend.position = "none") +
xlab("Sentiment") + ylab("Total Count") + 
ggtitle("Total Sentiment Score for All Tweets")

##So there are more positive sentiments than negative.. That is an interesting result




##tweets by month... let's see if I can get this code to work. 

immigrant_tweets_with_sentiment$month <- month(immigrant_tweets_with_sentiment$created, label = TRUE)
monthlysentiment <- immigrant_tweets_with_sentiment %>%
  mutate(month = month(created, label = TRUE)) %>%
  group_by(month) %>% 
  summarise(anger = mean(anger), 
            anticipation = mean(anticipation), 
            disgust = mean(disgust), 
            fear = mean(fear), 
            joy = mean(joy), 
            sadness = mean(sadness), 
            surprise = mean(surprise), 
            trust = mean(trust)) %>%
  ungroup() %>%
  mutate(anger_change = anger - lag(anger)) %>%
  mutate(disgust_change = disgust - lag(disgust)) %>%
  mutate(fear_change = fear - lag(fear)) %>%
  mutate(joy_change = joy - lag(joy)) %>%
  mutate(sadness_change = sadness - lag(sadness)) %>%
  mutate(surprise_change = surprise - lag(surprise)) %>%
  mutate(trust_change = trust - lag(trust))

ggplot(data = monthlysentiment, aes(x = month, y = meanvalue, group = sentiment)) +
  geom_line(size = 2.5, alpha = 0.7, aes(color = sentiment)) +
  geom_point(size = 0.5) +
  ylim(0, NA) +
  geom_smooth() +
  theme(legend.title=element_blank(), axis.title.x = element_blank()) +
  ylab("Average sentiment score") + 
  ggtitle("Sentiment During the Year")

##figuring out the words that contribute most to these sentiments

allthetweets <-read_csv("allthetweets.csv")
tweetswords <- allthetweets %>%
  select(text) 

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

tweet_words_count <- tweet_words %>%
  count(word, sort = TRUE) %>%
  arrange(desc(n))

## we need to remove the words immigrant, immigration, immigrants, #immigrant, and trump, because it is throwing off our sentiments

sentiment_words <- tweet_words_count[-c(1, 2, 4, 5, 8), ]


nrcfear <- get_sentiments("nrc") %>% 
  filter(sentiment == "fear")

nrctrust <- get_sentiments("nrc") %>% 
  filter(sentiment == "trust")

sentiment_words_fear %>%
  semi_join(nrcfear) %>%
  count(word, sort = TRUE) %>%
  head() %>%
  knitr::kable(caption = "Words that affect fearful sentiment")

sentiment_words_trust %>%
  semi_join(nrctrust) %>%
  count(word, sort = TRUE) %>%
  head() %>%
  knitr::kable(caption = "Words that affect fearful sentiment")


bing_word_counts <- sentiment_words %>%
  inner_join(get_sentiments("bing")) %>%
  count(word, sentiment, sort = TRUE) %>%
  ungroup()


bing_word_counts %>%
  filter(n > 1500) %>%
  mutate(n = ifelse(sentiment == "negative", -n, n)) %>%
  mutate(word = reorder(word, n)) %>%
  ggplot(aes(word, n, fill = sentiment)) +
  geom_bar(alpha = 0.8, stat = "identity") +
  labs(y = "Contribution to sentiment",
       x = NULL) +
  coord_flip()
