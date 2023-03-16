# Some of my answers that didn't work out

clean_data <- data %>% 
  rename(country_name = CountryName, continent = Continent, region = Region) %>% 
  pivot_longer(-country_name,
               names_to = "year",
               values_to = "u5mr",
               values_transform = list(u5mr = as.character)) %>% 
  mutate(year = str_remove_all(year, "[U5MR.]"), 
         year = .Primitive("as.integer")(year)) %>% 
  mutate_at(.vars = vars(year),
            .funs = as.integer)

cleanish_data[16, 4] = 1965
cleanish_data[26, 4] = 1975
cleanish_data[36, 4] = 1985
cleanish_data[46, 4] = 1995
cleanish_data[56, 4] = 2005

cleaner_data <- cleanish_data %>% drop_na()

cleaner_data[55, 4] = 2015

cleaner_data$year[cleaner_data$year == '198'] <- '1985'
cleaner_data$year[cleaner_data$year == '199'] <- '1995'
cleaner_data$year[cleaner_data$year == '200'] <- '2005'
cleaner_data$year[cleaner_data$year == '201'] <- '2015'