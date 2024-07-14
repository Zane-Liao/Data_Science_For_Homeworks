options(digits = 3)    # report 3 significant digits
library(tidyverse)
library(titanic)

titanic <- titanic_train %>%
  select(Survived, Pclass, Sex, Age, SibSp, Parch, Fare) %>%
  mutate(Survived = factor(Survived),
         Pclass = factor(Pclass),
         Sex = factor(Sex))

# params <- titanic %>%
#  filter(!is.na(Age)) %>%
#  summarize(mean = mean(Age), sd = sd(Age))

#  ggplot(titanic ,aes(sample = Age)) +
#  geom_qq(dparams =params) +
#  geom_abline()

# ggplot(titanic, aes(x = Survived, fill = Sex)) +
#  geom_bar(position = position_dodge())

# ggplot(titanic, aes(x = Age, fill = Survived)) +
#  geom_density(aes(y = ..count..), alpha = 0.2)

#person <- titanic %>% filter(Fare > 0)

#ggplot(person, aes(x = Survived, y = Fare)) +
#  geom_boxplot(aes(fill = Survived), outlier.shape = NA) +
#  scale_y_continuous(trans = "log2") +
#  geom_jitter(, width = 0.2, alpha = 0.5)

#ggplot(titanic, aes(x = Pclass, fill = Survived)) +
#  geom_bar()

#ggplot(titanic, aes(x = Age, fill = Survived)) +
#  geom_density(alpha = 0.2, position = "stack") +
#  facet_grid(Sex ~ Pclass)

titanic %>%
  ggplot(aes(Age, y = ..count.., fill = Survived)) +
  geom_density(position = "stack") +
  facet_grid(Sex ~ Pclass)