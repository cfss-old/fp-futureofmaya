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
                                 since= dates12[i]) %>%
    strip_retweets(strip_manual = TRUE, strip_mt = TRUE) %>%
    twListToDF() %>%
    tbl_df
}

# collapse tweets into a single data frame
tweets_joined12 <- bind_rows(tweets12) %>%
  # remove duplicate tweets that were retrieved in multiple searches
  unique()
str(tweets_joined12)

#13
# set the sequence of dates to search over
dates13 <- seq(as.Date("2016-02-01"), as.Date("2016-02-15"), by = "day") %>%
  as.character()

# create a list to store the tweets
tweets13 <- vector("list", length(dates13))

# use a for loop to run the immigration search starting on each date
for(i in seq_along(dates13)) {
  tweets13[[i]] <- searchTwitter('immigrant | immigration & -RT', 
                                 n=1000, lang='en',  
                                 since= dates13[i]) %>%
    strip_retweets(strip_manual = TRUE, strip_mt = TRUE) %>%
    twListToDF() %>%
    tbl_df
}

# collapse tweets into a single data frame
tweets_joined13 <- bind_rows(tweets13) %>%
  # remove duplicate tweets that were retrieved in multiple searches
  unique()
str(tweets_joined13)

#14
# set the sequence of dates to search over
dates14 <- seq(as.Date("2016-02-16"), as.Date("2016-02-29"), by = "day") %>%
  as.character()

# create a list to store the tweets
tweets14 <- vector("list", length(dates14))

# use a for loop to run the immigration search starting on each date
for(i in seq_along(dates14)) {
  tweets14[[i]] <- searchTwitter('immigrant | immigration & -RT', 
                                 n=1000, lang='en',  
                                 since= dates14[i]) %>%
    strip_retweets(strip_manual = TRUE, strip_mt = TRUE) %>%
    twListToDF() %>%
    tbl_df
}

# collapse tweets into a single data frame
tweets_joined14 <- bind_rows(tweets14) %>%
  # remove duplicate tweets that were retrieved in multiple searches
  unique()
str(tweets_joined14)



#15
# set the sequence of dates to search over
dates15 <- seq(as.Date("2016-03-01"), as.Date("2016-03-15"), by = "day") %>%
  as.character()

# create a list to store the tweets
tweets15 <- vector("list", length(dates15))

# use a for loop to run the immigration search starting on each date
for(i in seq_along(dates15)) {
  tweets15[[i]] <- searchTwitter('immigrant | immigration & -RT', 
                                 n=1000, lang='en',  
                                 since= dates15[i]) %>%
    strip_retweets(strip_manual = TRUE, strip_mt = TRUE) %>%
    twListToDF() %>%
    tbl_df
}

# collapse tweets into a single data frame
tweets_joined15 <- bind_rows(tweets15) %>%
  # remove duplicate tweets that were retrieved in multiple searches
  unique()
str(tweets_joined15)


#16
# set the sequence of dates to search over
  dates16 <- seq(as.Date("2016-03-16"), as.Date("2016-03-31"), by = "day") %>%
  as.character()

# create a list to store the tweets
tweets16 <- vector("list", length(dates16))

# use a for loop to run the immigration search starting on each date
for(i in seq_along(dates16)) {
  tweets16[[i]] <- searchTwitter('immigrant | immigration & -RT', 
                                 n=1000, lang='en',  
                                 since= dates16[i]) %>%
    strip_retweets(strip_manual = TRUE, strip_mt = TRUE) %>%
    twListToDF() %>%
    tbl_df
}

# collapse tweets into a single data frame
tweets_joined16 <- bind_rows(tweets16) %>%
  # remove duplicate tweets that were retrieved in multiple searches
  unique()
str(tweets_joined16)

#17
# set the sequence of dates to search over
dates17 <- seq(as.Date("2016-04-01"), as.Date("2016-04-15"), by = "day") %>%
  as.character()

# create a list to store the tweets
tweets17 <- vector("list", length(dates17))

# use a for loop to run the immigration search starting on each date
for(i in seq_along(dates17)) {
  tweets17[[i]] <- searchTwitter('immigrant | immigration & -RT', 
                                 n=1000, lang='en',  
                                 since= dates17[i]) %>%
    strip_retweets(strip_manual = TRUE, strip_mt = TRUE) %>%
    twListToDF() %>%
    tbl_df
}

# collapse tweets into a single data frame
tweets_joined17 <- bind_rows(tweets17) %>%
  # remove duplicate tweets that were retrieved in multiple searches
  unique()
str(tweets_joined17)

tweets_151130_to_160415 <- bind_rows(tweets9, tweets10, tweets11, tweets12, tweets13, tweets14, tweets15, tweets16, tweets17)
write_csv(tweets_151130_to_160415, "tweets_151130_to_160415")

#18
# set the sequence of dates to search over
dates18 <- seq(as.Date("2016-04-16"), as.Date("2016-04-30"), by = "day") %>%
  as.character()

# create a list to store the tweets
tweets18 <- vector("list", length(dates18))

# use a for loop to run the immigration search starting on each date
for(i in seq_along(dates18)) {
  tweets18[[i]] <- searchTwitter('immigrant | immigration & -RT', 
                                 n=1000, lang='en',  
                                 since= dates18[i]) %>%
    strip_retweets(strip_manual = TRUE, strip_mt = TRUE) %>%
    twListToDF() %>%
    tbl_df
}

# collapse tweets into a single data frame
tweets_joined18 <- bind_rows(tweets18) %>%
  # remove duplicate tweets that were retrieved in multiple searches
  unique()
str(tweets_joined18)

#19
# set the sequence of dates to search over
dates19 <- seq(as.Date("2016-05-01"), as.Date("2016-05-15"), by = "day") %>%
  as.character()

# create a list to store the tweets
tweets19 <- vector("list", length(dates19))

# use a for loop to run the immigration search starting on each date
for(i in seq_along(dates19)) {
  tweets19[[i]] <- searchTwitter('immigrant | immigration & -RT', 
                                 n=1000, lang='en',  
                                 since= dates19[i]) %>%
    strip_retweets(strip_manual = TRUE, strip_mt = TRUE) %>%
    twListToDF() %>%
    tbl_df
}

# collapse tweets into a single data frame
tweets_joined19 <- bind_rows(tweets19) %>%
  # remove duplicate tweets that were retrieved in multiple searches
  unique()
str(tweets_joined19)


#20
# set the sequence of dates to search over
dates20 <- seq(as.Date("2016-05-16"), as.Date("2016-05-31"), by = "day") %>%
  as.character()

# create a list to store the tweets
tweets20 <- vector("list", length(dates20))

# use a for loop to run the immigration search starting on each date
for(i in seq_along(dates20)) {
  tweets20[[i]] <- searchTwitter('immigrant | immigration & -RT', 
                                 n=1000, lang='en',  
                                 since= dates20[i]) %>%
    strip_retweets(strip_manual = TRUE, strip_mt = TRUE) %>%
    twListToDF() %>%
    tbl_df
}

# collapse tweets into a single data frame
tweets_joined20 <- bind_rows(tweets20) %>%
  # remove duplicate tweets that were retrieved in multiple searches
  unique()
str(tweets_joined20)

#21
# set the sequence of dates to search over
dates21 <- seq(as.Date("2016-06-01"), as.Date("2016-06-15"), by = "day") %>%
  as.character()

# create a list to store the tweets
tweets21 <- vector("list", length(dates21))

# use a for loop to run the immigration search starting on each date
for(i in seq_along(dates21)) {
  tweets21[[i]] <- searchTwitter('immigrant | immigration & -RT', 
                                 n=1000, lang='en',  
                                 since= dates21[i]) %>%
    strip_retweets(strip_manual = TRUE, strip_mt = TRUE) %>%
    twListToDF() %>%
    tbl_df
}

# collapse tweets into a single data frame
tweets_joined21 <- bind_rows(tweets21) %>%
  # remove duplicate tweets that were retrieved in multiple searches
  unique()
str(tweets_joined21)

#22
# set the sequence of dates to search over
dates22 <- seq(as.Date("2016-06-16"), as.Date("2016-06-30"), by = "day") %>%
  as.character()

# create a list to store the tweets
tweets22 <- vector("list", length(dates22))

# use a for loop to run the immigration search starting on each date
for(i in seq_along(dates22)) {
  tweets22[[i]] <- searchTwitter('immigrant | immigration & -RT', 
                                 n=1000, lang='en',  
                                 since= dates22[i]) %>%
    strip_retweets(strip_manual = TRUE, strip_mt = TRUE) %>%
    twListToDF() %>%
    tbl_df
}

# collapse tweets into a single data frame
tweets_joined22 <- bind_rows(tweets22) %>%
  # remove duplicate tweets that were retrieved in multiple searches
  unique()
str(tweets_joined22)

#23
# set the sequence of dates to search over
dates23 <- seq(as.Date("2016-07-01"), as.Date("2016-07-15"), by = "day") %>%
  as.character()

# create a list to store the tweets
tweets23 <- vector("list", length(dates23))

# use a for loop to run the immigration search starting on each date
for(i in seq_along(dates23)) {
  tweets23[[i]] <- searchTwitter('immigrant | immigration & -RT', 
                                 n=1000, lang='en',  
                                 since= dates23[i]) %>%
    strip_retweets(strip_manual = TRUE, strip_mt = TRUE) %>%
    twListToDF() %>%
    tbl_df
}

# collapse tweets into a single data frame
tweets_joined23 <- bind_rows(tweets23) %>%
  # remove duplicate tweets that were retrieved in multiple searches
  unique()
str(tweets_joined23)

#24
# set the sequence of dates to search over
dates24 <- seq(as.Date("2016-07-16"), as.Date("2016-07-31"), by = "day") %>%
  as.character()

# create a list to store the tweets
tweets24 <- vector("list", length(dates24))

# use a for loop to run the immigration search starting on each date
for(i in seq_along(dates24)) {
  tweets24[[i]] <- searchTwitter('immigrant | immigration & -RT', 
                                 n=1000, lang='en',  
                                 since= dates24[i]) %>%
    strip_retweets(strip_manual = TRUE, strip_mt = TRUE) %>%
    twListToDF() %>%
    tbl_df
}

# collapse tweets into a single data frame
tweets_joined24 <- bind_rows(tweets24) %>%
  # remove duplicate tweets that were retrieved in multiple searches
  unique()
str(tweets_joined24)

#25
# set the sequence of dates to search over
dates25 <- seq(as.Date("2016-08-01"), as.Date("2016-08-15"), by = "day") %>%
  as.character()

# create a list to store the tweets
tweets25 <- vector("list", length(dates25))

# use a for loop to run the immigration search starting on each date
for(i in seq_along(dates25)) {
  tweets25[[i]] <- searchTwitter('immigrant | immigration & -RT', 
                                 n=1000, lang='en',  
                                 since= dates25[i]) %>%
    strip_retweets(strip_manual = TRUE, strip_mt = TRUE) %>%
    twListToDF() %>%
    tbl_df
}

# collapse tweets into a single data frame
tweets_joined25 <- bind_rows(tweets25) %>%
  # remove duplicate tweets that were retrieved in multiple searches
  unique()
str(tweets_joined25)

tweets_160416_to_160815 <- bind_rows(tweets18, tweets19, tweets20, tweets21, tweets22, tweets23, tweets24, tweets25)
write_csv(tweets_160416_to_160815, "tweets_160416_to_160815")






#26
# set the sequence of dates to search over
dates26 <- seq(as.Date("2016-08-15"), as.Date("2016-08-31"), by = "day") %>%
  as.character()

# create a list to store the tweets
tweets26 <- vector("list", length(dates26))

# use a for loop to run the immigration search starting on each date
for(i in seq_along(dates26)) {
  tweets26[[i]] <- searchTwitter('immigrant | immigration & -RT', 
                                 n=1000, lang='en',  
                                 since= dates26[i]) %>%
    strip_retweets(strip_manual = TRUE, strip_mt = TRUE) %>%
    twListToDF() %>%
    tbl_df
}

# collapse tweets into a single data frame
tweets_joined26 <- bind_rows(tweets26) %>%
  # remove duplicate tweets that were retrieved in multiple searches
  unique()
str(tweets_joined26)
