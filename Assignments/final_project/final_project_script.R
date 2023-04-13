
# load packages

install.packages("zoo")
install.packages("stringr")
install.packages("geojsonio")
install.packages("broom")
install.packages("rjson")
install.packages("png")
install.packages("pandoc")

library(tidyverse)
library(easystats)
library(dplyr)
library(janitor)
library(leaps)
library(vroom)
library(zoo)
library(skimr)
library(stringr)
library(geojsonio)
library(broom)
library(rjson)
library(png)
library(pandoc)


# read in the data

df <- vroom("~/Downloads/GSAF5_03:2023.csv")
aus_df <- vroom("~/Downloads/australian_shark_incident_database_public.csv")

problems(aus_df)

#cleaning the data

df_1 <- df[, -16:-255] %>% clean_names()


df_2 = select(df_1, -investigator_or_source, -time, -injury,
              -sex, -name, -age, -location)

fifty_years <- dplyr::filter(df_2, year > 1952)
hundred_years <- dplyr::filter(df_2, year > 1922)

df_2 <- arrange(country) %>% 
  pull(country) %>% 
  str_to_lower()

australia <- dplyr::filter(hundred_years, country %in% c("AUSTRALIA")) %>% 
  dplyr::group_by(year) %>% arrange(year, .by_group=TRUE)

##Fishing
df_2 <- df_2 %>%
  mutate(activity = ifelse(grepl("Fishing", activity), "Fishing", activity)) %>% 
  mutate(activity = ifelse(grepl("fishing", activity), "Fishing", activity)) %>% 
  mutate(activity = ifelse(grepl("Fisherman", activity), "Fishing", activity)) %>% 
  mutate(activity = ifelse(grepl("Fish", activity), "Fishing", activity)) %>% 
  mutate(activity = ifelse(grepl("fish", activity), "Fishing", activity)) %>% 
  mutate(activity = ifelse(grepl("Spearfishing", activity), "Fishing", activity)) %>% 
  mutate(activity = ifelse(grepl("spearfishing", activity), "Fishing", activity)) %>% 
  mutate(activity = ifelse(grepl("sardines", activity), "Fishing", activity)) %>% 
  mutate(activity = ifelse(grepl("Clamming", activity), "Fishing", activity)) %>% 
  mutate(activity = ifelse(grepl("Crabbing", activity), "Fishing", activity)) %>% 
  mutate(activity = ifelse(grepl("shrimp", activity), "Fishing", activity)) %>% 
  mutate(activity = ifelse(grepl("lobsters", activity), "Fishing", activity)) %>% 
  mutate(activity = ifelse(grepl("whale", activity), "Fishing", activity)) %>% 
  mutate(activity = ifelse(grepl("Hunting", activity), "Fishing", activity)) %>% 
  mutate(activity = ifelse(grepl("hunting", activity), "Fishing", activity)) %>% 
  mutate(activity = ifelse(grepl("Lobstering", activity), "Fishing", activity)) %>% 
  mutate(activity = ifelse(grepl("Netting", activity), "Fishing", activity)) %>% 
  mutate(activity = ifelse(grepl("netting", activity), "Fishing", activity)) %>% 
  mutate(activity = ifelse(grepl("Net", activity), "Fishing", activity)) %>% 
  mutate(activity = ifelse(grepl("net", activity), "Fishing", activity)) %>% 
  mutate(activity = ifelse(grepl("prawns", activity), "Fishing", activity)) %>% 
  mutate(activity = ifelse(grepl("Shrimping", activity), "Fishing", activity)) %>% 
  mutate(activity = ifelse(grepl("dolphins", activity), "Fishing", activity)) %>% 
  mutate(activity = ifelse(grepl("crocodile", activity), "Fishing", activity)) %>% 
  mutate(activity = ifelse(grepl("turtle", activity), "Fishing", activity)) %>% 
  mutate(activity = ifelse(grepl("crabs", activity), "Fishing", activity)) %>% 
  mutate(activity = ifelse(grepl("stingrays?", activity), "Fishing", activity)) %>% 
  mutate(activity = ifelse(grepl("Oystering", activity), "Fishing", activity))

table(df_2$activity)

#swimming
#air_or_sea_disaster
#surfing
#snorkel and scuba?

south_africa <- dplyr::filter(hundred_years, country %in% c("SOUTH AFRICA"))

reunion <- dplyr::filter(hundred_years, country %in% c("REUNION ISLAND"))

usa <- dplyr::filter(hundred_years, country %in% c("USA"))

# geojson map

temp_shapefile <- tempfile()
download.file("https://github.com/gregoiredavid/france-geojson/blob/master/regions/la-reunion/communes-la-reunion.geojson", temp_shapefile)
unzip(temp_shapefile)

?toJSON

reunion_geojson <- geojson_read("https://github.com/gregoiredavid/france-geojson/blob/master/regions/la-reunion/communes-la-reunion.geojson")



