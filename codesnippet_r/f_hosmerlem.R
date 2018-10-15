f_hosmerlem <- function(y, yhat, g = 10){
    # http://sas-and-r.blogspot.com/2010/09/example-87-hosmer-and-lemeshow-goodness.html
    #===============================================    
    ### ordered and grouped by predicted probability
    cutyhat <- cut(
        yhat, 
        breaks = c(
            0, 
            quantile(
                yhat, 
                probs = seq(0, 1, 1 / (g-1))
            ) # end quantile 
        ) # end breaks
    ) # end cut
    
    ### observe and expect
    obs    = xtabs(cbind(1 - y,    y)    ~ cutyhat)
    expect = xtabs(cbind(1 - yhat, yhat) ~ cutyhat)
    
    ### person chi square
    chisq = sum((obs - expect)^2 / expect)
    p = 1 - pchisq(chisq, g - 2)
    
    return(list(chisq = chisq, p.value = p))
} # end func