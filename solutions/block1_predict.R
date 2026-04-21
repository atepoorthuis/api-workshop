library(tidyverse)
library(palmerpenguins)
library(tidymodels)

# ---- Plot ----------------------------------------------------------------

ggplot(penguins, aes(x = flipper_length_mm, y = body_mass_g)) +
  geom_point(aes(colour = species)) +
  geom_smooth(method = "lm")

# ---- Fit the model -------------------------------------------------------

penguin_fit <- workflow() |>
  add_formula(body_mass_g ~ flipper_length_mm) |>
  add_model(linear_reg()) |>
  fit(data = penguins)

tidy(penguin_fit)

# ---- Predict for a new observation ---------------------------------------

new_penguin <- tibble(flipper_length_mm = 200)

predict(penguin_fit, new_penguin)

# ---- Save ----------------------------------------------------------------

saveRDS(penguin_fit, here::here("model.rds"))

# ---- Refactor into a function --------------------------------------------

#' Predict penguin body mass from flipper length
#'
#' @param model A fitted tidymodels workflow
#' @param flipper_length Flipper length in mm (numeric)
#' @return Predicted body mass in grams (numeric)
predict_body_mass <- function(model, flipper_length) {
  new_data    <- tibble(flipper_length_mm = flipper_length)
  predictions <- predict(model, new_data)
  predictions$.pred
}

predict_body_mass(penguin_fit, flipper_length = 200)
predict_body_mass(penguin_fit, flipper_length = 215)
predict_body_mass(penguin_fit, flipper_length = 185)
