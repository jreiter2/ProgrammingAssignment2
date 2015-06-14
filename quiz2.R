# question 1
# 1. Find OAuth settings for github:
#    http://developer.github.com/v3/oauth/
library(httr)
oauth_endpoints("github")

client_id = '<the id you get from github>'
client_secret = 'b65a47755811eb1b2208f337108bee6c63793785'


# question 2
acs <- read.csv("/Users/joe/Desktop/Rfiles/coursera/R_Programming/ss06pid.csv")
head(acs)

library(sqldf)
sqldf("select * from acs where AGEP < 50")
sqldf("select pwgtp1 from acs where AGEP < 50")


# question 3
sqldf("select distinct AGEP from acs")
sqldf("select unique AGEP from acs")
sqldf("select distinct pwgtp1 from acs")
sqldf("select distinct AGEP from acs")
sqldf("select unique AGEP from acs")
sqldf("select distinct pwgtp1 from acs")
sqldf("select unique * from acs")


# question 4
library(XML)
q4 <- url("http://biostat.jhsph.edu/~jleek/contact.html")
q4
htmlCode <- readLines(q4)
nchar(htmlCode[10])
nchar(htmlCode[20])
nchar(htmlCode[30])
nchar(htmlCode[100])


# question 5
q5 <- read.fwf(file=url("http://www.cpc.ncep.noaa.gov/data/indices/wksst8110.for"), skip=4, width=c(12,7,4,9,4,9,4,9,4))
head(q5)
q5$V4
sum(q5$V4)
