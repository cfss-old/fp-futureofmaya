#tidying

reg <- "([^A-Za-z_\\d#@']|'(?![A-Za-z_\\d#@]))"
immigrant_tweets_words <- immigrant_immigration_tweets %>% 
  mutate(text = 
           str_replace_all(text, "https://t.co/[A-Za-z\\d]+|http://[A-Za-z\\d]+|&amp;|&lt;|&gt;|@[a-z,A-Z]*", "")) %>%
  unnest_tokens(word, text, token = "regex", pattern = reg) %>%
  filter(!word %in% stop_words$word,
         str_detect(word, "[a-z]"))


tweet_words_count <- immigrant_tweets_words %>%
  count(word, sort = TRUE) %>%
  arrange(desc(n))
 
tweet_words_count

ggplot(tweet_words_count[1:20,], aes(x= reorder(word, -n), y = n)) 
  + geom_bar(alpha = 0.8, stat = "identity", show.legend = FALSE) +
  +  coord_flip() 
  +  xlab("Number of Occurences") + ylab("Word") + ggtitle("Words Used in Tweets about Immigration")
+#Just ignore "immigrant," "rt," and "https." Couldn't figure out how to get rid of them. 

##so this is another way to clean the body of text, but I've tried to run it line by line and am having trouble still


immigrant_tweets_text <- str_replace_all(immigrant_immigration_tweets$text, "@\\w+", "")
immigrant_wordCorpus <- Corpus(VectorSource(immigrant_tweets_text))
immigrant_wordCorpus <- tm_map(immigrant_wordCorpus, removePunctuation)
immigrant_wordCorpus <- tm_map(immigrant_wordCorpus, content_transformer(tolower))
immigrant_wordCorpus <- tm_map(immigrant_wordCorpus, removeWords, stopwords("english"))
immigrant_wordCorpus <- tm_map(immigrant_wordCorpus, removeWords, c("amp", "2yo", "3yo", "4yo"))
immigrant_wordCorpus <- tm_map(immigrant_wordCorpus, stripWhitespace)

#construct term document matrix
immigrant_tdm <- TermDocumentMatrix(immigrant_wordCorpus,control = list(wordLengths = c(1, Inf)))
immigrant_tdm

#find frequent terms
freq.terms <- findFreqTerms(tdm, lowfreq = 20)
term.freq <- rowSums(as.matrix(immigrant_tdm))
term.freq <- subset(term.freq, term.freq >= 20)
immigrant_df <- data.frame(term = names(term.freq), freq = term.freq)

#graph frequent terms
library(ggplot2)
ggplot(immigrant_df, aes(x=term, y=freq)) + geom_bar(stat="identity") +
  xlab("Terms") + ylab("Count") + coord_flip() +
  theme(axis.text=element_text(size=7))


m <- as.matrix(tdm)

# calculate the frequency of words and sort it by frequency
word.freq <- sort(rowSums(m), decreasing = T)
# colors
pal <- brewer.pal(9, "BuGn")[-(1:4)]

# plot word cloud
library(wordcloud)
wordcloud(words = names(word.freq), freq = word.freq, min.freq = 3,
          random.order = F, colors = pal)