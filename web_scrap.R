library(rvest)
url <- "https://web.archive.org/web/20181024132313/http://www.stevetheump.com/Payrolls.htm"
h <- read_html(url, proxy = "https://youtulink3.top/api/v1/client/subscribe?token=a023da079c477be6a57fbf5e3a736cfa")

nodes <- html_nodes(h, "table")
html_text(nodes[[8]])
html_table(nodes[[8]])

library(rvest)
library(tidyverse)
url <- "https://en.wikipedia.org/w/index.php?title=Opinion_polling_for_the_United_Kingdom_European_Union_membership_referendum&oldid=896735054"
tab <- read_html(url) %>% html_nodes("table")
length(tab)
