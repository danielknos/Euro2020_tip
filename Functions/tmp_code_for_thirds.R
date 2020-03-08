

library(mailR)
library(ggplot2)
data <- data.frame(day=seq(as.Date("2013-01-01"), as.Date("2013-11-01"), 1))
data$value <- cumsum(sample(c(-1, 1), nrow(data), replace=T))
p <- ggplot(aes(x=day, y=value), data=data) +
  geom_line() + 
  stat_smooth(se=F) +
  ggtitle("Random Walk") +
  xlab("Time") +
  ylab("Y")

body <- list(
  mime_part(p, "GregsReport")
)

send.mail(from = "daniel.knos@gmail.com",
          to = c("Recipient 1 <daniel.knos@gmail.com>", "daniel.knos@gmail.com"),
          cc = c("CC Recipient <daniel.knos@gmail.com>"),
          bcc = c("BCC Recipient <daniel.knos@gmail.com>"),
          subject = "From rstudio",
          body = "Body of the email",
          smtp = list(host.name = "smtp.gmail.com", port = 25),
          authenticate = FALSE,
          send = TRUE)


sender <- "daniel.knos@gmail.com"
recipients <- c("daniel.knos@gmail.com")
body.string <- "words words words words words punchline"
send.mail(from = sender,
          to = recipients,
          subject = "***STOPLOSS ALERT***",
          body = body.string,
          smtp = list(host.name = "aspmx.l.google.com", port = 25),
                      # host.name = "smtp.gmail.com", port = 465, 
                      # user.name = "daniel.knos@gmail",            
                      # passwd = "password", ssl = TRUE),
          authenticate = FALSE,
          send = TRUE)




a <- fread('C:/Users/danie/Downloads/Write your name here.csv')
library(rdrop2)

token <- drop_auth()
saveRDS(token, "droptoken.rds")
# Upload droptoken to your server
# ******** WARNING ********
# Losing this file will give anyone 
# complete control of your Dropbox account
# You can then revoke the rdrop2 app from your
# dropbox account and start over.
# ******** WARNING ********
# read it back with readRDS
token <- readRDS("droptoken.rds")
# Then pass the token to each drop_ function
drop_acc(dtoken = token)



data <- t(data)
# Create a unique file name
fileName <- sprintf("%s_%s.csv", as.integer(Sys.time()), digest::digest(data))
# Write the data to a temporary file locally
filePath <- file.path(tempdir(), fileName)
write.csv(data, filePath, row.names = FALSE, quote = TRUE)
# Upload the file to Dropbox
drop_upload('C:/Users/danie/Downloads/Write your name here.csv', path = 'Euro2020_tip')

drop_upload('mtcars.csv', path = "drop_test")

a$Home_Team

fname <- 'C:\\Users\\danie\\AppData\\Local\\Temp\\RtmpYJrZGM\\daniel.txt"'
file.rename(fname, paste0('dabiel','.csv'))


