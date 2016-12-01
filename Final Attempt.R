library(tidyverse)
library(twitteR)

#twitter authentication
setup_twitter_oauth(consumer_key = getOption("twitter_api_key"),
                    consumer_secret = getOption("twitter_api_token"))
#1
# set the sequence of dates to search over
dates <- seq(as.Date("2015-08-06"), as.Date("2015-8-20"), by = "day") %>%
  as.character()

# create a list to store the tweets
tweets <- vector("list", length(dates))

# use a for loop to run the immigration search starting on each date
for(i in seq_along(dates)) {
  tweets[[i]] <- searchTwitter('immigrant | immigration & -RT', 
                               n=1000, lang='en',  
                               since= dates[i]) %>%
    strip_retweets(strip_manual = TRUE, strip_mt = TRUE) %>%
    twListToDF() %>%
    tbl_df
}

# collapse tweets into a single data frame
tweets_joined <- bind_rows(tweets) %>%
  # remove duplicate tweets that were retrieved in multiple searches
  unique()
str(tweets_joined)


#2
# set the sequence of dates to search over
dates2 <- seq(as.Date("2015-08-21"), as.Date("2015-8-31"), by = "day") %>%
  as.character()

# create a list to store the tweets
tweets2 <- vector("list", length(dates2))

# use a for loop to run the immigration search starting on each date
for(i in seq_along(dates2)) {
  tweets2[[i]] <- searchTwitter('immigrant | immigration & -RT', 
                               n=1000, lang='en',  
                               since= dates2[i]) %>%
    strip_retweets(strip_manual = TRUE, strip_mt = TRUE) %>%
    twListToDF() %>%
    tbl_df
}

# collapse tweets into a single data frame
tweets_joined2 <- bind_rows(tweets2) %>%
  # remove duplicate tweets that were retrieved in multiple searches
  unique()
str(tweets_joined2)


#3
# set the sequence of dates to search over
dates3 <- seq(as.Date("2015-09-01"), as.Date("2015-9-15"), by = "day") %>%
  as.character()

# create a list to store the tweets
tweets3 <- vector("list", length(dates3))

# use a for loop to run the immigration search starting on each date
for(i in seq_along(dates3)) {
  tweets3[[i]] <- searchTwitter('immigrant | immigration & -RT', 
                               n=1000, lang='en',  
                               since= dates3[i]) %>%
    strip_retweets(strip_manual = TRUE, strip_mt = TRUE) %>%
    twListToDF() %>%
    tbl_df
}

# collapse tweets into a single data frame
tweets_joined3 <- bind_rows(tweets3) %>%
  # remove duplicate tweets that were retrieved in multiple searches
  unique()
str(tweets_joined3)


#4
# set the sequence of dates to search over
dates4 <- seq(as.Date("2015-09-16"), as.Date("2015-9-30"), by = "day") %>%
  as.character()

# create a list to store the tweets
tweets4 <- vector("list", length(dates4))

# use a for loop to run the immigration search starting on each date
for(i in seq_along(dates4)) {
  tweets4[[i]] <- searchTwitter('immigrant | immigration & -RT', 
                                n=1000, lang='en',  
                                since= dates4[i]) %>%
    strip_retweets(strip_manual = TRUE, strip_mt = TRUE) %>%
    twListToDF() %>%
    tbl_df
}

# collapse tweets into a single data frame
tweets_joined4 <- bind_rows(tweets4) %>%
  # remove duplicate tweets that were retrieved in multiple searches
  unique()
str(tweets_joined4)

#5
# set the sequence of dates to search over
dates5 <- seq(as.Date("2015-10-01"), as.Date("2015-10-15"), by = "day") %>%
  as.character()

# create a list to store the tweets
tweets5 <- vector("list", length(dates5))

# use a for loop to run the immigration search starting on each date
for(i in seq_along(dates5)) {
  tweets5[[i]] <- searchTwitter('immigrant | immigration & -RT', 
                                n=1000, lang='en',  
                                since= dates5[i]) %>%
    strip_retweets(strip_manual = TRUE, strip_mt = TRUE) %>%
    twListToDF() %>%
    tbl_df
}

# collapse tweets into a single data frame
tweets_joined5 <- bind_rows(tweets5) %>%
  # remove duplicate tweets that were retrieved in multiple searches
  unique()
str(tweets_joined5)

#6
# set the sequence of dates to search over
dates6 <- seq(as.Date("2015-10-16"), as.Date("2015-10-31"), by = "day") %>%
  as.character()

# create a list to store the tweets
tweets6 <- vector("list", length(dates6))

# use a for loop to run the immigration search starting on each date
for(i in seq_along(dates6)) {
  tweets6[[i]] <- searchTwitter('immigrant | immigration & -RT', 
                                n=1000, lang='en',  
                                since= dates6[i]) %>%
    strip_retweets(strip_manual = TRUE, strip_mt = TRUE) %>%
    twListToDF() %>%
    tbl_df
}

# collapse tweets into a single data frame
tweets_joined6 <- bind_rows(tweets6) %>%
  # remove duplicate tweets that were retrieved in multiple searches
  unique()
str(tweets_joined6)




#7
# set the sequence of dates to search over
dates7 <- seq(as.Date("2015-11-01"), as.Date("2015-11-15"), by = "day") %>%
  as.character()

# create a list to store the tweets
tweets7 <- vector("list", length(dates7))

# use a for loop to run the immigration search starting on each date
for(i in seq_along(dates7)) {
  tweets7[[i]] <- searchTwitter('immigrant | immigration & -RT', 
                                n=1000, lang='en',  
                                since= dates7[i]) %>%
    strip_retweets(strip_manual = TRUE, strip_mt = TRUE) %>%
    twListToDF() %>%
    tbl_df
}

# collapse tweets into a single data frame
tweets_joined7 <- bind_rows(tweets7) %>%
  # remove duplicate tweets that were retrieved in multiple searches
  unique()
str(tweets_joined7)


#8
# set the sequence of dates to search over
dates8 <- seq(as.Date("2015-11-16"), as.Date("2015-11-30"), by = "day") %>%
  as.character()

# create a list to store the tweets
tweets8 <- vector("list", length(dates8))

# use a for loop to run the immigration search starting on each date
for(i in seq_along(dates8)) {
  tweets8[[i]] <- searchTwitter('immigrant | immigration & -RT', 
                                n=1000, lang='en',  
                                since= dates8[i]) %>%
    strip_retweets(strip_manual = TRUE, strip_mt = TRUE) %>%
    twListToDF() %>%
    tbl_df
}

# collapse tweets into a single data frame
tweets_joined8 <- bind_rows(tweets8) %>%
  # remove duplicate tweets that were retrieved in multiple searches
  unique()
str(tweets_joined8)


tweets_til_151130 <- bind_rows(tweets, tweets2, tweets3, tweets4, tweets5, tweets6, tweets7, tweets8)
write_csv(tweets_til_151130, "tweets_til_151130.csv")


#9
# set the sequence of dates to search over
dates9 <- seq(as.Date("2015-12-01"), as.Date("2015-12-15"), by = "day") %>%
  as.character()

# create a list to store the tweets
tweets9 <- vector("list", length(dates9))

# use a for loop to run the immigration search starting on each date
for(i in seq_along(dates9)) {
  tweets9[[i]] <- searchTwitter('immigrant | immigration & -RT', 
                                n=1000, lang='en',  
                                since= dates9[i]) %>%
    strip_retweets(strip_manual = TRUE, strip_mt = TRUE) %>%
    twListToDF() %>%
    tbl_df
}

# collapse tweets into a single data frame
tweets_joined9 <- bind_rows(tweets9) %>%
  # remove duplicate tweets that were retrieved in multiple searches
  unique()
str(tweets_joined9)




#10
# set the sequence of dates to search over
dates10 <- seq(as.Date("2015-12-16"), as.Date("2015-12-31"), by = "day") %>%
  as.character()

# create a list to store the tweets
tweets10 <- vector("list", length(dates10))

# use a for loop to run the immigration search starting on each date
for(i in seq_along(dates10)) {
  tweets10[[i]] <- searchTwitter('immigrant | immigration & -RT', 
                                n=1000, lang='en',  
                                since= dates10[i]) %>%
    strip_retweets(strip_manual = TRUE, strip_mt = TRUE) %>%
    twListToDF() %>%
    tbl_df
}

# collapse tweets into a single data frame
tweets_joined10 <- bind_rows(tweets10) %>%
  # remove duplicate tweets that were retrieved in multiple searches
  unique()
str(tweets_joined10)





#11
# set the sequence of dates to search over
dates11 <- seq(as.Date("2016-01-01"), as.Date("2016-01-15"), by = "day") %>%
  as.character()

# create a list to store the tweets
tweets11 <- vector("list", length(dates11))

# use a for loop to run the immigration search starting on each date
for(i in seq_along(dates11)) {
  tweets11[[i]] <- searchTwitter('immigrant | immigration & -RT', 
                                 n=1000, lang='en',  
                                 since= dates11[i]) %>%
    strip_retweets(strip_manual = TRUE, strip_mt = TRUE) %>%
    twListToDF() %>%
    tbl_df
}

# collapse tweets into a single data frame
tweets_joined11 <- bind_rows(tweets11) %>%
  # remove duplicate tweets that were retrieved in multiple searches
  unique()
str(tweets_joined11)




#12
# set the sequence of dates to search over
dates12 <- seq(as.Date("2016-01-16"), as.Date("2016-01-31"), by = "day") %>%
  as.character()

# create a list to store the tweets
tweets12 <- vector("list", length(dates12))

# use a for loop to run the immigration search starting on each date
for(i in seq_along(dates12)) {
  tweets12[[i]] <- searchTwitter('immigrant | immigration & -RT', 
                                 n=1000, lang='en',  
                                 since= dates11[i]) %>%
    strip_retweets(strip_manual = TRUE, strip_mt = TRUE) %>%
    twListToDF() %>%
    tbl_df
}

# collapse tweets into a single data frame
tweets_joined12 <- bind_rows(tweets12) %>%
  # remove duplicate tweets that were retrieved in multiple searches
  unique()
str(tweets_joined12)
