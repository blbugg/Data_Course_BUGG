# EXAM 4 (That is actually my attempt at Exam 1)

#TASKS:

library(tidyverse)
library(janitor)
library(dplyr)
library(ggplot2)
library(lubridate)

#I. Read the cleaned_covid_data.csv file into an R data frame. (20 pts)

df <- read.csv("./cleaned_covid_data.csv") #read in the new data frame as "df"

#II. Subset the data set to just show states that begin with "A" and save this as an object called A_states. (20 pts)

df_A <- df[grepl("^A", df$Province_State),] # used grepl to subset only "A" states

  # Use the *tidyverse* suite of packages
  # Selecting rows where the state starts with "A" is tricky (you can use the grepl() function or just a vector of those states if you prefer)

# III. Create a plot of that subset showing Deaths over time, with a separate facet for each state. (20 pts)
  
# + Create a scatterplot
# + Add loess curves WITHOUT standard error shading
# + Keep scales "free" in each facet

df_A %>% 
  ggplot(aes(x = Last_Update, y = Deaths)) +
  geom_point() + # chose geom_point because it is a scatter plot
  geom_smooth(se = FALSE) + # made sure to indicate no standard error shading, "se" indicates confidence interval, put FALSE since it is TRUE by default. 
  facet_wrap(~ Province_State, scales = "free_x") # facet_wrap used for showing each state's deaths over time. 

# IV. (Back to the full data set)
# Find the "peak" of Case_Fatality_Ratio for each state and save this as a new data frame object called state_max_fatality_rate. (20 pts)
  
  # I'm looking for a new data frame with 2 columns:

 # + "Province_State"
 # + "Maximum_Fatality_Ratio"
 # + Arrange the new data frame in descending order by Maximum_Fatality_Ratio
 
# This might take a few steps. Be careful about how you deal with missing values!

state_max_fatality_rate <- df %>% 
  group_by(Province_State) %>% # grouped each state.
  summarise(Maximum_Fatality_Ratio = max(Case_Fatality_Ratio, na.rm = TRUE)) %>% #summarized max fatality ratio by getting the max from case_fatality ratio.
  arrange(desc(Maximum_Fatality_Ratio)) #arranged in descending order of max fatality ratio.

# V.
# Use that new data frame from task IV to create another plot. (20 pts)

 # + X-axis is Province_State
 # + Y-axis is Maximum_Fatality_Ratio
 # + bar plot
 # + x-axis arranged in descending order, just like the data frame (make it a factor to accomplish this)
 # + X-axis labels turned to 90 deg to be readable
 
# Even with this partial data set (not current), you should be able to see that (within these dates), different states had very different fatality ratios.

state_max_fatality_rate$Province_State <-
  factor(state_max_fatality_rate$Province_State, 
         levels = state_max_fatality_rate$Province_State[order(state_max_fatality_rate$Maximum_Fatality_Ratio)]) #made the factor of descending order max fatality ratio with corresponding state

#without color
state_max_fatality_rate %>% 
  ggplot(aes(x = Province_State, y = Maximum_Fatality_Ratio)) +
  geom_col() + # geo_col for bar graph
  theme(axis.text.x = element_text(angle = 90)) # x axis turned to 90 degrees

# with color (I prefer color)
state_max_fatality_rate %>% 
  ggplot(aes(x = Province_State, y = Maximum_Fatality_Ratio, color = Province_State, fill = Province_State)) +
  geom_col() +
  theme(axis.text.x = element_text(angle = 90))


# VI. (BONUS 10 pts)
# Using the FULL data set, plot cumulative deaths for the entire US over time.
# + You'll need to read ahead a bit and use the dplyr package functions group_by() and summarize() to accomplish this.

bonus <- df %>% 
  rename(Date = Last_Update) %>% # renamed it for me own sake, I kept putting in date and couldn't figure out why it wouldn't work haha.
  group_by(Date) %>% #grouped together by date
  summarise(Deaths = sum(Deaths)) %>% #summarized by getting the sum of deaths by the grouped dates.
  ungroup() 

bonus$Date <- ymd(bonus$Date) #converted "Date" class from character to date class using package "lubridate"

bonus %>%
  ggplot(aes(x = Date, y = Deaths, color = "red")) +
  geom_line() + 
  scale_x_date(date_breaks = "3 months", date_labels = "%b %Y") + # a little less overwhelming to see the dates chunked together.
  labs(x = "Date", y = "Deaths", title = "COVID-19 Deaths over Time in the United States") + # labeled for a little more practice.
  theme_minimal() + theme(legend.position = "none") # minimal theme is cleaner, and with the addition of the red color, it came with an unnecessary legend. 
