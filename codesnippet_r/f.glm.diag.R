f.glm.diag <- function(fit)
{
h <- hat(diag(sqrt(fit$weights))%*%fit$x,int=F)
spres <- residuals(fit,"pearson")/sqrt(1-h)
sdres <- residuals(fit,"deviance")/sqrt(1-h)
lres <- sign(fit$y-fit$fit) * sqrt(h*spres^2 + (1-h)*sdres^2)
ares <- gamma(2/3)*gamma(2/3)/gamma(2/3+2/3) 
ares <- ares * (pbeta(fit$y,2/3,2/3) - pbeta(fit$fit,2/3,2/3))
ares.se <- ((fit$fit*(1-fit$fit))^(1/6))*sqrt((1-h)/fit$prior.weights)
ares <- ares/ares.se
return(cbind(spres=spres,sdres=sdres,lres=lres,ares=ares,h=h))
}
