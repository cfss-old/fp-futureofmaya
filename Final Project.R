library(twitteR)
library(httpuv)

setup_twitter_oauth(consumer_key = getOption("twitter_api_key"),
                    consumer_secret = getOption("twitter_api_token"))

tweets <- searchTwitter('immigrant', n= 1000)
tweetsdf <- twListToDF(tweets)
tweetsdf$timestamp <- ymd_hms(tweets$timestamp)
tweetsdf$timestamp <- with_tz(tweets$timestamp, "America/Chicago")


#Writing to a file so the same tweets are used
write_csv(tweetsdf, "tweetsdf.csv")

#And now creating another df of the same tweets I'm using
tweetsdfcsv <- read_csv("tweetsdf.csv")