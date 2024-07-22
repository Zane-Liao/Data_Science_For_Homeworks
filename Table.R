# import US murders data
library(tidyverse)
library(ggrepel)
library(dslabs)
ds_theme_set()
data(murders)
head(murders)

# make two smaller tables to demonstrate joins
tab1 <- slice(murders, 1:5) %>% select(state, population)
tab1
tab2 <- slice(results_us_election_2016, c(1:3, 5, 7:8)) %>% select(state, electoral_votes)
tab2

dat <- left_join(tab1, tab2, by = "state")
dat

library(Lahman)
top <- Batting %>% 
  filter(yearID == 2016) %>%
  arrange(desc(HR)) %>%    # arrange by descending HR count
  slice(1:10)    # take entries 1-10
top %>% as_tibble()
People %>% as_tibble()

head(People)
top_names <- top %>% left_join(People) %>%
  select(playerID, nameFirst, nameLast, HR)
top_names

top_salary <- Salaries %>% filter(yearID == 2016) %>%
  anti_join(top_names) %>%
  select(nameFirst, nameLast, teamID, HR, salary)
top_salary


top <- AwardsPlayers %>% 
  filter(yearID == 2016) %>%
  slice(1:10)    # take entries 1-10
top

# solution 1
Awards_2016 <- AwardsPlayers %>% filter(yearID == 2016)
length(intersect(Awards_2016$playerID, top_names$playerID))

length(setdiff(Awards_2016$playerID, top_names$playerID))
