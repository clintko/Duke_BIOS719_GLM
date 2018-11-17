fun_walds_glm = function(fit, contrast){
    # 
    #################################
    ### initialization
    L = contrast
    Lt = t(contrast)
    
    ### number of test parameters
    p = nrow(Lt)
    
    ### estimated coefficients
    b = cbind(coef(fit))
    
    ### covariance matrix of beta
    covb = summary(fit)$cov.unscale 
    
    ### calculate wald statistics
    x = t(Lt %*% b) %*% (Lt %*% covb %*% L) %*% (Lt %*% b)
    
    ### store the results and return
    lst = list()
    lst$df    = p
    lst$walds = x
    lst$pval  = 1 - pchisq(x, df = p)
    return(lst)
    
}

fun_walds_gee = function(fit, contrast){
    #
    ################################
    ### initialization
    L  = contrast
    Lt = t(contrast)
    
    ### number of test parameters
    p = nrow(Lt)
    
    ### estimated coefficients
    b = cbind(coef(fit))
    
    ### empirical covariance matrix of beta
    Ve = fit$robust.variance
    
    ### calculate wald statistics
    x  = t(Lt %*% b) %*% solve(Lt %*% Ve %*% L) %*% (Lt %*% b)
    
    ### store the results and return 
    lst = list()
    lst$df    = p
    lst$walds = x
    lst$pval  = 1 - pchisq(x, df = p)
    return(lst)
}