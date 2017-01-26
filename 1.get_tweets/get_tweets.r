library("twitteR")

args <- commandArgs(trailingOnly = T)

consumerKey    <- args[1]
consumerSecret <- args[2]
accessToken    <- args[3]
accessSecret   <- args[4]

print(paste("consumer key    = ", consumerKey));
print(paste("consumer secret = ", consumerSecret));
print(paste("access token    = ", accessToken));
print(paste("access secret   = ", accessSecret));

options(httr_oauth_cache = TRUE)

setup_twitter_oauth(consumerKey, consumerSecret,
                    accessToken, accessSecret)

usernames <- c("WSJmarkets", "FXstreetNews",
               "IBDinvestors", "ForexLive",
               "USATODAY", "washingtonpost")

for (user in usernames) {
  print(user)
  print(paste(">> Read TimeLine from by @", user, sep = ""))
  UserTimeLines <- userTimeline(user, n = 3000)
  print("read TimeLine")

  x <- twListToDF(UserTimeLines)
  print(length(x))

  filname <- paste(user,".csv", sep = "")
  write.csv(x, filname, quote = TRUE, row.names = FALSE, append = FALSE)
  print("save csv file")

  Sys.sleep(120)
}
