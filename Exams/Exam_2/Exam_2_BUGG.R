#EXAM 2...let's see if I can do this one right and restore my self worth.

install.packages("tidyverse")
install.packages("janitor")
install.packages("dplyr")
install.packages("ggplot")
install.packages("easystats")


library(tidyverse)
library(janitor)
library(dplyr)
library(ggplot2)
library(easystats)


#TASKS

#1. Read in the unicef data (10 pts)

data <- read.csv("~/Desktop/Data_Course_BUGG/Exams/Exam_2/unicef-u5mr.csv") %>% 
  clean_names()

#2. Get it into tidy format (10 pts)

#converting the data frame from wider to longer format
cleanish_data <-
  pivot_longer(data, -c(country_name, continent, region), 
               values_to = "u5mr", 
               names_to = "year")

#eliminating the "u5mr." in the year column
cleanish_data$year <- gsub("u5mr.","",as.character(cleanish_data$year))

#ensuring that the "year" column is in the class numeric
cleanish_data$year <- as.numeric(as.character(cleanish_data$year))

class(cleanish_data$year)

#omitting the redundant column of "region" (continent AND region are not 
#necessary in my mind), #cleanish_data includes NA values.
cleanish_data = select(cleanish_data, -region,)

#3. Plot each country’s U5MR (mortality_rate) over time (20 points)
#- Create a line plot (not a smooth trend line) for each country
#- Facet by continent

#dropping the na's, new dataframe with na's absent

cleaner_data <- cleanish_data %>% drop_na()

#line plot, facet by continent

BUGG_Plot_1 <-
  ggplot(cleaner_data, aes(x = year, y = u5mr)) +
  geom_line(size = 0.08) +
  facet_wrap(~ continent)

BUGG_Plot_1

#4. Save this plot as LASTNAME_Plot_1.png (5 pts) 

#see above and in exam 2 folder

BUGG_Plot_1

#5. Create another plot that shows the mean U5MR for all the countries within a 
#given continent at each year (20 pts).

#- Another line plot (not smooth trend line)
#- Colored by continent

# data set with mean U5mr for each country

clean_data_w_means <- cleaner_data %>% 
  group_by(country_name) %>% 
  mutate(mean_u5mr = mean(u5mr))

head(cleaner_data)

#This looks nothing like the one from your instructions, I got 
# through the first 4 questions over spring break and thought I could handle it,
# then it was too late to ask for help when I hit this one. So much time spent
# trying to figure this out and got nowhere, so I'm sorry :(.

BUGG_Plot_2 <- clean_data_w_means %>%
  group_by(country_name) %>%
  ggplot(aes(x=year, y=mean_u5mr, color=continent)) +
  geom_line() 

#6. Save that plot as LASTNAME_Plot_2.png (5 pts)

BUGG_Plot_2

#7. Create three models of U5MR (20 pts)

#- mod1 should account for only Year

mod1 <-
  glm(data = cleanish_data,
      formula = u5mr ~ year)
summary(mod1)
plot(mod1)

#- mod2 should account for Year and Continent

mod2 <-
  glm(data = cleanish_data,
      formula = u5mr ~ year + continent)
summary(mod2)
plot(mod2)

#- mod3 should account for Year, Continent, and their interaction term

mod3 <-
  glm(data = cleanish_data,
      formula = u5mr ~ year + continent + year * continent)
summary(mod3)
plot(mod3)

#8. Compare the three models with respect to their performance.

#- Your code should do the comparing

compare_performance(mod1, mod2, mod3)
compare_performance(mod1, mod2, mod3) %>% plot()

#- Include a comment line explaining which of these three models you think 
# is best

# I am basing my choice as the best model by referring to the r^2 given, and in
# most cases, the bigger the number the better fit in the model. Given this, I
# would say that model 3 is the best of the three models given since it has a
# r^2 value of 0.64, while mod2 is 0.6 and mod 1 is 0.22.

#9. Plot the 3 models’ predictions

predict(mod1) %>% plot()
predict(mod2) %>% plot()
predict(mod3) %>% plot()

#10. BONUS - Using your preferred model, predict what the U5MR would be for 
#Ecuador in the year 2020. The real value for Ecuador for 2020 was 13 under-5 
#deaths per 1000 live births. How far off was your model prediction???

ecuador_data <- dplyr::filter(cleanish_data, country_name %in% c("Ecuador"))
predict(mod3, newdata = ecuador_data)

# Either I am not reading the prediction model right, or I did it incorrectly,
# but what I am seeing is that in 2015, it would be 131.35? Which is 10 times 
# more than reality. It seems under #60, that matches with 2020, but I can't 
# understand how it would be that far in the future, making me lean towards the
# conclusion that I did something wrong somewhere.


