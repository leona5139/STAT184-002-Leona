# Goal Tidy the Hypoxia Data ----

## Needs ----
### We will need to load the data
### We are going to need the following verbs
### rename, select, mutate, pivot (longer & wider),
### separate (wider, delimated)

## Process/Instructions ----
### Step 0: Read the data in twice:
### Once to get headers for matching and then to get the data
headersHypoxia <- read.table(
  file = "hypoxia.csv",
  header = FALSE,
  sep = ",",
  nrows = 2 # The nrows argument stops the reading process after a set number of rows
)

hypoxiaRaw <- read.table(
  file = "hypoxia.csv",
  header = FALSE, # Turn off the header
  sep = ",",
  skip = 2 # Skip the first two rows when reading the data
)

### Step 1-N: We'll use tidyverse and piping to chain our steps together
library(tidyverse)
### Step 1: Fix Variables (column names)
### Step 2: Drop extra column ('junk')
### Step 3: Change "sea level" to 0k/0k to match other entries
### Step 4: Separate altitude into two columns
### Step 5: Convert both altitude columns to numeric data type
### Step 6: Reshape the repeatedly measured attributes to a pair of columns
### Step 7: Extract the O2 percentage from the measurement columns
### Step 8: Reshape measurement columns into separate columns by attribute
### Step 9: Change the O2 percentage to a number

cleanedHypoxia <- hypoxiaRaw %>%
  rename( # Step 1
    junk = V1,
    Altitude = V2,
    Air_Pressure_mmHg = V3,
    ppO2_mmHg = V4,
    O2_LungPressure_mmHg.21 = V5,
    bloodO2.21 = V6,
    CO2_LungPressure_mmHg.21 = V7,
    O2_LungPressure_mmHg.100 = V8,
    bloodO2.100 = V9,
    CO2_LungPressure_mmHg.100 = V10
  ) %>%
  dplyr::select(-junk) %>% # Step 2
  mutate( # Step 3
    Altitude = case_match( 
      Altitude,
      "Sea level" ~ "0k/0k",
      .default = Altitude
    )
  ) %>%
  separate_wider_delim( # Step 4
    cols = Altitude, 
    delim = "/",
    names = c("Altitude_ft", "Altitude_m")
  ) %>%
  mutate( # Step 5
    Altitude_ft = readr::parse_number(Altitude_ft) * 1000,
    Altitude_m = readr::parse_number(Altitude_m) * 1000
  ) %>%
  pivot_longer( # Step 6
    cols = O2_LungPressure_mmHg.21:CO2_LungPressure_mmHg.100,
    names_to = "key",
    values_to = "pressureReading"
  ) %>%
  separate_wider_delim( # Step 7
    cols = key,
    delim = ".",
    names = c("reading", "O2_Percent")
  ) %>%
  pivot_wider( # Step 8
    names_from = reading,
    values_from = pressureReading
  ) %>%
  mutate( # Step 9
    O2_Percent = readr::parse_number(O2_Percent)