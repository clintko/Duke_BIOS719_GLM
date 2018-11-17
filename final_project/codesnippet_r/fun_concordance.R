suppressWarnings(suppressMessages(library(pROC)))
concordance <- function(model){
    
    # Get all actual observations and their fitted values into a frame
    fitted <- data.frame(cbind(model$y, model$fitted.values))
    colnames(fitted)<-c('respvar','score')
    
    # Subset only ones
    ones  <- fitted[fitted[,1] == 1,]
    # Subset only zeros
    zeros <- fitted[fitted[,1] == 0,]
    
    #print(ones)
    #print(zeros)
    # Initialise all the values
    pairs_tested <- 0
    conc         <- 0
    disc         <- 0
    ties         <- 0
      
    # Get the values in a for-loop
    for(i in 1:nrow(ones)) {
          
        for(j in 1:nrow(zeros)) {
            pairs_tested<-pairs_tested + 1
            
            if        (ones[i, 2] >  zeros[j, 2]) { 
                conc <- conc + 1 
            } else if (ones[i, 2] == zeros[j, 2]){ 
                ties <- ties + 1 
            } else { 
                disc <- disc + 1 
            } # end if-else
        } # end inner for
    } # end outer for
    
    # Calculate concordance, discordance and ties
    concordance <- conc / pairs_tested
    discordance <- disc / pairs_tested
    ties_perc   <- ties / pairs_tested
    n           <- nrow(fitted)
    
    # index
    # http://support.sas.com/kb/45/767.html
    # http://support.sas.com/documentation/cdl/en/statug/66103/HTML/default/viewer.htm#statug_surveylogistic_details64.htm
    return(
        list(
            "Concordance" = concordance,
            "Discordance" = discordance,
            "Tied"        = ties_perc,
            "Pairs"       = pairs_tested,
            
            ### Somers' D
            "Somers D"    = (concordance - discordance),
            
            ### Goodman-Kruskal Gamma
            "gamma"       = (concordance - discordance) / (concordance + discordance),
            
            ### Kendall's Tau-a
            "tau-a"       = (conc - disc) / (0.5 * n * (n - 1)),
            
            ### c-statistics
            "c"           = auc(model$y, model$fitted.values)
        ) # end list
    ) # end return
} # end func