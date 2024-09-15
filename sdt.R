# Import data.csv
data <- read.csv("data.csv")

# Fake data for testing
#data <- data.frame(participant = c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10),
#                   hits = c(1, 9, 9, 5, 8, 5, 1, 1, 8, 9),
#                   misses = c(6, 1, 1, 5, 2, 5, 9, 9, 2, 1),
#                   false_alarms = c(1, 0, 9, 5, 5, 0, 1, 5, 6, 1),
#                   correct_rejections = c(4, 10, 1, 5, 5, 10, 9, 5, 4, 9)
#)

# Defining the function
sdt <- function(data, gaussian = TRUE, logistic = FALSE, non_parametric = FALSE, two_high_threshold = FALSE) {
  
  # --- Basics calculations
  
  # proportion of hits
  prop_hits <- ifelse(
    data$misses > 0, 
    data$hits / (data$hits + data$misses), 
    (data$hits - 0.5) / (data$hits + data$misses)
  )
  
  # proportion of false alarms
  prop_false_alarms <- ifelse(
    data$false_alarms > 0, 
    data$false_alarms / (data$false_alarms + data$correct_rejections),
    0.5 / (data$false_alarms + data$correct_rejections)
  )
  
  # z-scores for hits and false alarms
  z_hits <- qnorm(prop_hits)
  z_false_alarms <- qnorm(prop_false_alarms)
  
  # --- Gaussian distribution SDT
  
  # d'
  d_prime <- z_hits - z_false_alarms
  # c
  c <- -0.5 * (z_hits + z_false_alarms)
  # c'
  c_prime <- c/d_prime
  # beta
  beta <- exp(d_prime*c)
  # ln(beta)
  ln_beta <- log(beta)
  
  # --- Logistic distribution SDT
  
  if (logistic == TRUE){
  # d'
  logi_d_prime <- log((prop_hits * (1 - prop_false_alarms)) / ((1 - prop_hits) * prop_false_alarms))
  # ln(beta)
  logi_ln_beta <- log((prop_hits * (1 - prop_hits)) / (prop_false_alarms * (1 - prop_false_alarms)))
  # c
  logi_c <- 0.5 * (log(((1 - prop_false_alarms) * (1 - prop_hits)) / (prop_false_alarms * prop_hits)))
  }
  
  # --- Non parametric SDT
  
  if (non_parametric == TRUE) {
  # A'
  A_prime <- ifelse(
    prop_false_alarms > prop_hits, 
    (0.5 - (prop_false_alarms-prop_hits)*(1 + prop_false_alarms - prop_hits) / (4 * prop_false_alarms * (1 - prop_hits))),
    (0.5 + (prop_hits - prop_false_alarms) * (1+ prop_hits - prop_false_alarms) / (4 * prop_hits * (1 - prop_false_alarms)))
  )
  # B''
  B_double_prime <- ifelse(
    prop_false_alarms > prop_hits, 
    ((prop_hits * (1 - prop_hits)) - (prop_false_alarms * (1 - prop_false_alarms))) / ((prop_hits * (1 - prop_hits)) + (prop_false_alarms * (1 - prop_false_alarms))),
    ((prop_false_alarms * (1 - prop_false_alarms)) - (prop_hits * (1 - prop_hits))) / ((prop_false_alarms * (1 - prop_false_alarms)) + (prop_hits * (1 - prop_hits)))
  )
  # Bh
  Bh <- ifelse(
    prop_hits > 1 - prop_false_alarms, 
    (prop_hits * (1 - prop_hits)) / (prop_false_alarms * (1 - prop_false_alarms)) - 1,
    1 - ((prop_false_alarms * (1 - prop_false_alarms)) / (z_hits * (1 - z_hits)))
  )
  }
  
  # --- 2-High Threshold SDT
  
  if (two_high_threshold == TRUE) {
  # Pr
  Pr <- (prop_hits - prop_false_alarms) / (1 - prop_false_alarms)
  # Br
  Br <- prop_false_alarms / (1 - (prop_hits - prop_false_alarms))
  }
  
  # Putting it all together with cbind() in the order it was calculated
  data_sdt <- cbind(data, prop_hits, prop_false_alarms, z_hits, z_false_alarms, d_prime, c, c_prime, beta, ln_beta)
  if (logistic == TRUE) data_sdt <- cbind(data_sdt, logi_d_prime, logi_ln_beta, logi_c)
  if (non_parametric == TRUE) data_sdt <- cbind(data_sdt, A_prime, B_double_prime, Bh)
  if (two_high_threshold == TRUE) data_sdt <- cbind(data_sdt, Pr, Br)
  
  # print the data
  print(data_sdt)
  
}

# Use sdt(data) to run the function.
# or save it in a variable like sdt_data <- sdt(data)
# Arguments are gaussian = TRUE (default), and optional logistic = TRUE, non_parametric = TRUE, two_high_threshold = TRUE to include calculations for those SDT methods.
# Annex the results to your data with, e.g., data <- cbind(data, sdt(data))


