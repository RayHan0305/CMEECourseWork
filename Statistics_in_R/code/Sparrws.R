d <- read.table("../data/SparrowSize.txt", header = TRUE)
table(d$BirdID)
table(table(d$BirdID))
BirdIDCount <- d %>% count(BirdID, sort = TRUE)
BirdIDCount %>% count(n)

# How many repeats are there per bird per year
library(dplyr)
bird_repeat <- d %>% count(BirdID, Year, sort = FALSE)
table(bird_repeat)

# How many individuals did we capture per year for each sex? Compute the numbers,
# devise a useful table format, and fill it in.
bird_sex_year <- d %>%
  group_by(Year, Sex.1) %>%
  summarise(individuals_num = n_distinct(BirdID), .groups = "drop")
  
  
bird_sex_year


# Think about how you can communicate (1) and (2) best in tables, and how you can
# visualise (1) and (2) using plots. Produce several solutions, and discuss with GTA
# and your peers which the pros and cons for each solution to communicate and
# visualize the data structure for (1) and (2).

# Write two results sections for (1) and (2), and ask your GTA for feedback. Each
# result section should use different means of communicating the results, visually and
# in a table.