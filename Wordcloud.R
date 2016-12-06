
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

View(tweet_words_count)

ggplot(tweet_words_count[1:20,], aes(x= reorder(word, -n), y = n)) +
  geom_bar(alpha = 0.8, stat = "identity", show.legend = FALSE) + 
  coord_flip() +
  xlab("Number of Occurances") + ylab("Word") + ggtitle("Words Used in Tweets about Immigration")

# plot word cloud
# made a word cloud, but we should remove the words immigrant and immigration, immigrants and #immigrant, because those were our search terms, so of course they will come up the most
# the -c(1,2,5,8) removse those words

library(wordcloud)
wordcloud_words <- tweet_words_count[-c(1, 2, 5, 8), ]
wordcloud(words = wordcloud_words$word, freq = wordcloud_words$n, min.freq = 1500,
          random.order = FALSE, colors = TRUE)

#different type of word cloud
library(RXKCD)
library(tm)
library(wordcloud)
library(RColorBrewer)
pal <- brewer.pal(9, "BuGn")
pal <- pal[-(1:2)]
wordcloud(wordcloud_words$word,wordcloud_words$n, scale=c(8,.3),min.freq=2500, random.order=FALSE, rot.per=.15, colors= pal, vfont=c("sans serif","plain"))

#and another word cloud
pal2 <- brewer.pal(8,"Set3")
#this is th eone i like, i think
wordcloud(wordcloud_words$word,wordcloud_words$n, scale=c(8,.2),min.freq=1500,
          max.words=Inf, random.order=FALSE, rot.per=.15, colors=pal2)

wordcloud(wordcloud_words$word,wordcloud_words$n, scale=c(8,.3),min.freq=1500, random.order=FALSE, rot.per=.15, colors= pal2, vfont=c("sans serif","plain"))

#function if we wanted to make a wordcloud for a particular time period: 

wordcloudAtXTime <- function(y, m, d, y2, m2, d2) {
  
}
