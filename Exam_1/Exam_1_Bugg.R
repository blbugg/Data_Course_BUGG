# Skills Test 1 (the real thing)


# YOUR TASKS:

# **I.**
# **Read the cleaned_covid_data.csv file into an R data frame. (20 pts)**

library(tidyverse)
df <- read_csv("cleaned_covid_data.csv")
skimr::skim(df)

# **II.**
#**Subset the data set to just show states that begin with "A" and save this as 
#an object called A_states. (20 pts)**

grep("^A", df$Province_State) 

df[grep("^A", df$Province_State), ]

A_states <- subset(df, grepl("^A", df$Province_State))

# + Use the *tidyverse* suite of packages

# + Selecting rows where the state starts with "A" is tricky (you can use the grepl() function or just a vector of those states if you prefer)

# **III.**

# **Create a plot _of that subset_ showing Deaths over time, with a separate facet for each state. (20 pts)**

# ***This is where I got stuck, I just seemed to not get the exact code correct. Even after reading through
# the plethora of stack overflow blogs and "R for Data Science", I was always running into something. 
# Obviously, this is the exam I plan to redo for EXAM 4. It doesn't help that I couldn't start the exam until
# Tuesday, my students research project proposals are due this week and some of them didn't understand
# what that entailed, lots of emailing and Teams calls this last week. I am sorry, I hope you I 
# am better than what you see here. However, I was pretty proud of myself for the use of the grepl
# function. I also was very scared and apprehensive about the git clone process, you know, from 
# being such a schmuck last month.


# + Create a scatterplot
# + Add loess curves WITHOUT standard error shading
# + Keep scales "free" in each facet


# **IV.** (Back to the full dataset)

# **Find the "peak" of Case_Fatality_Ratio for each state and save this as a new data frame object called state_max_fatality_rate. (20 pts)**

# I'm looking for a new data frame with 2 columns:

# + "Province_State"
# + "Maximum_Fatality_Ratio"
# + Arrange the new data frame in descending order by Maximum_Fatality_Ratio

# This might take a few steps. Be careful about how you deal with missing values!


# **V.**
# **Use that new data frame from task IV to create another plot. (20 pts)**

# + X-axis is Province_State
# + Y-axis is Maximum_Fatality_Ratio
# + bar plot
# + x-axis arranged in descending order, just like the data frame (make it a factor to accomplish this)
# + X-axis labels turned to 90 deg to be readable

# Even with this partial data set (not current), you should be able to see that (within these dates), different states had very different fatality ratios.

# **VI.** (BONUS 10 pts)
# **Using the FULL data set, plot cumulative deaths for the entire US over time**

# + You'll need to read ahead a bit and use the dplyr package functions group_by() and summarize() to accomplish this.