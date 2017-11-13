library(twitteR)
#library("xlsx")
library("httr")
setwd("/Users/studentuser/Desktop")

# consumer_key <- "sugZt9Il80hOe4E5SKJpNNASO"
# consumer_secret <- "2gNKYOvHmWXrrPWY7ajX8vmB8bYbA93fgJS16CdXtsMEBMjF3E"
# acess_token <-  "921918903051104257-8ykaL1pxhdymlJHjSM7KVvidhNIQ1CO"
# access_secret <-  "921918903051104257-8ykaL1pxhdymlJHjSM7KVvidhNIQ1CO"

req_data <- read.csv('a.csv')
setup <- c("sugZt9Il80hOe4E5SKJpNNASO", 
           "2gNKYOvHmWXrrPWY7ajX8vmB8bYbA93fgJS16CdXtsMEBMjF3E", 
           "921918903051104257-8ykaL1pxhdymlJHjSM7KVvidhNIQ1CO", 
           "BPZ2V4lqq0cfsg3j7dbGRQF4O8kf4VCN2KY4EsYS2y8vz")
           
setup_twitter_oauth(setup[1], setup[2], setup[3], setup[4])

final_frame <- twListToDF(searchTwitter(toString(req_data[1,2]), since = "2006-01-01", n = 2000))

for(i in 2:250) {
   tryCatch({
     add_frame <- searchTwitteR(toString(req_data[i,2]), since = "2006-01-01", n = 2000)
     my_df <- twListToDF(add_frame)
     final_frame <- rbind(final_frame,my_df)
   }, error = function(e){
     print(paste("no data found for", req_data[i,2]))
   }
   ) 
}
