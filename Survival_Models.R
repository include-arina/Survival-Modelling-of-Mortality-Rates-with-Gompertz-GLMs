#
#     R-code to generate data for Assignment 2.  This code MUST be
#     placed at the start of your own R-script.  You must edit
#     the argument to the set.seed( ) function to fit your own
#     HW student ID number
#
#
RNGkind(sample.kind = "Rejection")
set.seed(4912)  #### Replace with the last 4 digits of your HW student ID
#
#      Read HMD data
#
source("CMI_read.r")
#
#  Age range
#
start.age = 25; end.age = 80;
AGE <- start.age:end.age
#
#  MyYear
#
MyYear <- 1950 + round(runif(1,0,55),0)
#
# Data for Gompertz GLM for MyYear 
#
DTH <- Dth[ (start.age <= Age) & (Age <= end.age), Year==MyYear]
EXP <- Exp[ (start.age <= Age) & (Age <= end.age), Year==MyYear]

Logit <- function(x) log(x/(1-x)) # Define logit function
E.init <- EXP + 0.5*DTH # Initial exposed to risk
Q.x <- DTH/E.init
OBS <- Logit(Q.x)
#
#
####################################################
# Please insert your R code after this line
####################################################
setwd("//Users//arinai.//Desktop//uni//year 3//survival_data")

#question 1a
plot(AGE, OBS, xlab ="Age", ylab = "logit(mortality)", 
     main = "Gompertz law: CMI data, ages 25 to 80")

#question 1b
Gomp.bin <- glm(Q.x ~ AGE, weights = E.init, family = binomial); Gomp.bin

#question 1d
lines(AGE, Gomp.bin$lin, lwd = 2, col = "red")
text(25,-3, "Binomial model", cex = 1, adj = 0)
text(25, -3.5, "logit(q) = -10.607 + 0.106 * Age", cex = 1, adj = 0)

#question 1f
#calculating pearson residuals
pear_resid <- resid(Gomp.bin, type="pear")
#plotting pearson residuals
plot(AGE, pear_resid, ylab = "residuals", xlab = "Age", main = "Residuals in Gompertz model")

#question 2a
Gomp.quadratic <- glm(Q.x ~ I(AGE - mean(AGE)) + I((AGE - mean(AGE))^2), 
                 weights = E.init, family = binomial); Gomp.quadratic
#-5.0224 + 0.1079(x-mean(x)) - 0.00017(x-mean(x))^2

plot(AGE, OBS, xlab ="Age", ylab = "logit(mortality)", 
     main = "Observed vs Fitted Gompertz model")

#question 2b
lines(AGE, Gomp.bin$lin, lwd = 2, col = "blue") #original 
lines(AGE, Gomp.quadratic$lin,lwd =2,lty = 2, col = "red") #fitted curve
legend("topleft", c("Gompertz fitted line", "Gompertz quadratic model"), lty = c(1,2), lwd = 2, col=c("blue", "red"))

#question 2d
#function that calculates AIC depending on the model 
AIC_calculation <- function(model){
  k <- length(coef(model)) #calculates the number of parameters through the number of coef.
  log_Likelihood = as.numeric(logLik(model)) #calculates the log-likelihood

  AIC_output <- 2*k - 2*log_Likelihood #AIC = 2k - 2ln(MLE)
  
  return(AIC_output)
}
#alternative way:
#AIC(Gomp.bin)
#AIC(Gomp.quadratic)

linear_model_AIC <- AIC_calculation(Gomp.bin);linear_model_AIC #2 parameters
quad_model_AIC <- AIC_calculation(Gomp.quadratic); quad_model_AIC #3 parameters






