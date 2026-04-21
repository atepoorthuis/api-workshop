library(plumber2)
library(tidyverse)
library(tidymodels)

# Load model once at startup — not inside the function
model <- readRDS(here::here("model.rds"))

#* Predict penguin body mass from flipper length
#* @get /predict
#* @query flipper_length:number Flipper length in mm
#* @response 200:{body_mass_g:number}
function(query) {
  new_data    <- tibble(flipper_length_mm = as.numeric(query$flipper_length))
  predictions <- predict(model, new_data)
  list(body_mass_g = predictions$.pred)
}

# Run from the RStudio console:
# api("solutions/block2_plumber.R") |> api_run(port = 8000)
