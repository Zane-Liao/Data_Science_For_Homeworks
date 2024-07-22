library(dslabs)
library(lubridate)
options(digits = 3)    # 3 significant digits
data(brexit_polls)
head(brexit_polls)

set.seed(2)
dates <- sample(brexit_polls$startdate) %>% sort
dates

# extract month, day, year from date strings
l <- data.frame(date = dates, 
           month = month(dates),
           day = day(dates),
           year = year(dates))
head(l)
x <- l %>% filter(month == "4")

brexit_polls <- brexit_polls %>%
  mutate(end_week = round_date(enddate, unit = "week"))

week_ending_polls <- brexit_polls %>%
  filter(end_week == as.Date("2016-06-12"))

#
n_week_ending_polls <- nrow(week_ending_polls)
n_week_ending_polls

table(weekdays(brexit_polls$enddate))


data(movielens)

m <- as_datetime(movielens$timestamp)
head(m)
head(movielens)

b <- movielens %>% filter(!is.na(rating))


reviews_per_year <- movielens %>%
  count(year) %>%
  arrange(desc(n))


print(reviews_per_year)


movielens <- movielens %>%
  mutate(hour = hour(timestamp))


reviews_per_hour <- movielens %>%
  count(hour) %>%
  arrange(desc(n))

print(reviews_per_hour)


# -------------------------------------------------


library(tidyverse)
library(stringr)
library(gutenbergr)
library(tidytext)
library(dslabs)
library(stringr)
library(dplyr)
library(textdata)
options(digits = 3)
head(gutenberg_metadata)
v <- gutenberg_metadata %>%
  filter(str_detect(title, "Pride and Prejudice"))
nrow(v)

book_id <- gutenberg_works(title == "Pride and Prejudice")$gutenberg_id

book <- gutenberg_download(1342)
words <- book %>%
  unnest_tokens(word, text)
nrow(words)

afinn <- get_sentiments("afinn")


t("afinn_sentiments 有多少个元素的值为 4？", value_four_count, "\n")

library(gutenberg)
library(tidytext)
library(dplyr)

# Download Pride and Prejudice
pride_and_prejudice <- gutenberg_download(1342, mirror = "http://mirror.csclub.uwaterloo.ca/gutenberg/")

# Create a tidy table of words
words <- pride_and_prejudice %>%
  unnest_tokens(word, text, token = "regex", pattern = "\\s+|(?=[[:punct:]])|(?<=[[:punct:]])(?=[[:alpha:]])", to_lower = TRUE) %>%
  filter(!grepl("^[[:punct:]]+$", word))

# Count the number of words
word_count <- nrow(words)

print(paste("The number of words in Pride and Prejudice is:", word_count))

library(dplyr)

# Count word frequencies
word_frequencies <- words_no_digits %>%
  count(word, sort = TRUE)

# Count words appearing more than 100 times
words_over_100 <- word_frequencies %>%
  filter(n > 100)

num_words_over_100 <- nrow(words_over_100)

# Find the most common word
most_common_word <- word_frequencies$word[1]
most_common_word_count <- word_frequencies$n[1]

print(paste("Number of words appearing more than 100 times:", num_words_over_100))
print(paste("The most common word is:", most_common_word))
print(paste("It appears", most_common_word_count, "times"))
