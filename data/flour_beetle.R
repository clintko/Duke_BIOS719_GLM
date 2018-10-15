library(tidyverse)

flour = tribble(
  ~cs, ~batch, ~y, ~n,
  49.06, 0,  2, 29,
  49.06, 1,  4, 30,
  52.99, 0,  7, 30,
  52.99, 1,  6, 30,
  56.91, 0,  9, 28,
  56.91, 1,  9, 34,
  60.84, 0, 14, 27,
  60.84, 1, 14, 29,
  64.76, 0, 23, 30,
  64.76, 1, 29, 33,
  68.69, 0, 29, 31,
  68.69, 1, 24, 28,
  72.61, 0, 29, 30,
  72.61, 1, 32, 32,
  76.54, 0, 29, 29,
  76.54, 1, 31, 31,
)

### n = 1 situation
flour_n1 = as.data.frame(
    rbind(
        cbind(cs = rep(flour$cs, flour$y),           n = 1, y = 1),
        cbind(cs = rep(flour$cs, flour$n - flour$y), n = 1, y = 0)
    ) # end rbind
) # end as.data.frame