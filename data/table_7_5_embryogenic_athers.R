# Table 7.5 Embryogenic anthers.csv

library(tidyverse)

embryogenic_anthers = data.frame(
    y          = c( 55,  52,  57, 55,  50,  50),
    n          = c(102,  99, 108, 76,  81,  90),
    storage    = c(  1,   1,   1,  2,   2,   2),
    centrifuge = c( 40, 150, 350, 40, 150, 350))

embryogenic_anthers = embryogenic_anthers %>%
    mutate(
        
        ### newstor:
        ###     1 = treatment
        ###     0 = control
        newstor = storage - 1,
    
        ### force = log(centrifuge)
        force   = log(centrifuge))
        #c(3.688879, 
        #  5.010635,
        #  5.857933,
        #  3.688879,
        #  5.010635,
        #  5.857933))