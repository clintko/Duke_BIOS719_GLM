###################################################

cars_tab = data.frame(
    women = c(40, 47, 63),
    men   = c(65, 47, 38)
)

rownames(cars_tab) = c("1:no/little", "2:important", "3:very-important")

###################################################

cars = data.frame(
    count    = c(40, 47, 63, 65, 47, 38),
    gender   = c("women", "women", "women", "men", "men", "men"),
    response = c("1:no/little", "2:important", "3:very-important", "1:no/little", "2:important", "3:very-important"))
    
cars$response <- relevel(cars$response, ref = "1:no/little")
cars$gender   <- relevel(cars$gender,   ref = "women")

###################################################

cars_n1 = rbind(
    cbind(rep("1:no/little",      40), gender = "women"),
    cbind(rep("2:important",      47), gender = "women"),
    cbind(rep("3:very-important", 63), gender = "women"),
    cbind(rep("1:no/little",      65), gender = "men"),
    cbind(rep("2:important",      47), gender = "men"),
    cbind(rep("3:very-important", 38), gender = "men")
) # end rbind

cars_n1 = as.data.frame(cars_n1)
colnames(cars_n1) = c("response", "gender")

cars_n1$response <- relevel(cars_n1$response, ref = "1:no/little")
cars_n1$gender   <- relevel(cars_n1$gender,   ref = "women")
