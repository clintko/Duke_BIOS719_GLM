library(tidyverse)


beetle = data.frame(
    dose = c(1.6907, 1.7242, 1.7552, 1.7842, 1.8113, 1.8369, 1.8610, 1.8839),
    n = c(59, 60, 62, 56, 63, 59, 62, 60),
    y = c( 6, 13, 18, 28, 52, 53, 61, 60)
)

beetle = beetle %>% mutate(n_y = n - y)

### n = 1 situation
beetle_n1 = as.data.frame(
    rbind(
        cbind(dose = rep(beetle$dose, beetle$y),            n = 1, y = 1),
        cbind(dose = rep(beetle$dose, beetle$n - beetle$y), n = 1, y = 0)
    ) # end rbind
) # end as.data.frame