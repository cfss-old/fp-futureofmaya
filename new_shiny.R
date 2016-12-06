input- term

tweet_word %>%
  filter(Term == input$word) %>%
  select(id)

this creates tweets_term

tweets_Term %>%
  inner_join(tweet_words)
this will filter tweet words in order to only keep tweets that have that term in it

then you'll have a data frame that only uses that term, then want to join this result back to counts
then you'll have a new count, with every row as a different term
store this as a reactive object, use this df to draw the wordcloud or whatever you're presenting as results
then can add a table, so they can look at the raw tweets'
