##################################################################################################################################
##################################################################################################################################
##                                                                                                                              ##
##                                                  ANSWER TO QUESTION 1                                                        ##
##                                                                                                                              ##
##################################################################################################################################
##################################################################################################################################

# install.packages("foreign")
file <- "C:\\Users\\Lefteris\\Dropbox\\My Dropbox Move\\Business Analytics\\1. Fall Semester\\Statistics for BA I\\Assignments\\Lab_Assignments\\usdata"
library(foreign)
usdata <- read.csv(file, header = TRUE, sep = " ", quote = "\"")
str(usdata)

##################################################################################################################################
##################################################################################################################################
##                                                                                                                              ##
##                                                  ANSWER TO QUESTION 2                                                        ##
##                                                                                                                              ##
##################################################################################################################################
##################################################################################################################################

for (i in 1:4){
  usdata[,i] <- as.numeric(as.character(usdata[,i]))
}
for (i in 5:6){
  usdata[,i] <- as.factor(usdata[,i])
}
str(usdata)


##################################################################################################################################
##################################################################################################################################
##                                                                                                                              ##
##                                                  ANSWER TO QUESTION 3                                                        ##
##                                                                                                                              ##
##################################################################################################################################
##################################################################################################################################

# convert hundreds of dollars to dollars
usdata$PRICE <- usdata$PRICE*100
# convert square feet of living space to square meters
usdata$SQFT <- usdata$SQFT/10.764
colnames(usdata)[2] <- "SQMT"
summary(usdata)
library(psych)
round(t(describe(usdata[,1:4])),2)
n <- nrow(usdata)
par(mfrow = c(2,2))
hist(usdata$PRICE, main = names(usdata)[1], xaxt="n")
axis(1, at = seq(0,max(usdata$PRICE)+sd(usdata$PRICE),by=10000))
hist(usdata$SQMT, main = names(usdata)[2], xaxt="n")
axis(1, at = seq(0,max(usdata$SQMT)+sd(usdata$SQMT),by=10))
hist(usdata$AGE, main = names(usdata)[3])
plot(table(usdata[,4])/n, type='h', xlim=range(usdata[,4])+c(-1,1), main=names(usdata)[4], ylab='Relative frequency')
levels(usdata$NE) = c("NO", "YES")
levels(usdata$COR) = c("NO", "YES")
par(mfrow = c(2,1))
barplot(table(usdata$NE)/n, horiz=T, las=1, col=2:3, xlim=c(0,1), ylim=c(0,2), sub = "Located NE", 
        names.arg = levels(usdata$NE))
barplot(table(usdata$COR)/n, horiz=T, las=1, col=2:3, xlim=c(0,1), ylim=c(0,2), sub = "Corner Location", 
        names.arg = levels(usdata$COR))


##################################################################################################################################
##################################################################################################################################
##                                                                                                                              ##
##                                                  ANSWER TO QUESTION 4                                                        ##
##                                                                                                                              ##
##################################################################################################################################
##################################################################################################################################

# install.packages("corrplot")
# install.packages("sjPlot")
pairs(usdata[,1:4])
par(mfrow = c(1,1))
library(corrplot)
corrplot(cor(usdata[,1:4]), method = 'ellipse')
library(sjPlot)
sjp.corr(usdata[,1:4], corr.method = "pearson", sort.corr = T)
# Correlation of price and feats (number of 11 features a house has)
plot(usdata[,4], usdata[,1], xlab=names(usdata)[4], ylab='Price',cex.lab=1.5)
abline(lm(usdata[,1]~usdata[,4]),col=2)
boxplot(usdata[,1]~usdata[,4], xlab=names(usdata)[4], ylab='Price',cex.lab=1.5)
abline(lm(usdata[,1]~usdata[,4]),col=2)
# Correlation of price (our response variable) and factor variables 
par(mfrow=c(1,2))
for(j in 5:6){
  boxplot(usdata[,1]~usdata[,j], xlab=names(usdata)[j], ylab='Price',cex.lab=2.0)
}
# Correlations valid on the numerical variables
round(cor(usdata[,1:4]),2)
cor(usdata$PRICE, usdata$SQMT, method = "pearson")
# It seems to exist a linear relationship between price and sqmt (size of house in square meters)

##################################################################################################################################
##################################################################################################################################
##                                                                                                                              ##
##                                                  ANSWER TO QUESTION 5                                                        ##
##                                                                                                                              ##
##################################################################################################################################
##################################################################################################################################

model <- lm(PRICE ~., data = usdata)
summary(model)
# R^2 is above 0.7, so current linear model is a good fit model, but not a very good (below 0.9)


##################################################################################################################################
##################################################################################################################################
##                                                                                                                              ##
##                                                  ANSWER TO QUESTION 6                                                        ##
##                                                                                                                              ##
##################################################################################################################################
##################################################################################################################################

mfull <- lm(PRICE~.,data=usdata)
step(mfull, direction='both')
step(mfull, direction='both', k=log(100))
# SQMT and FEATS are the best variables for predicting PRICE
# PRICE = -17592.8 + 732.5*SQMT + 3983.7*FEATS


##################################################################################################################################
##################################################################################################################################
##                                                                                                                              ##
##                                                  ANSWER TO QUESTION 7                                                        ##
##                                                                                                                              ##
##################################################################################################################################
##################################################################################################################################

round(sapply(usdata[,c(2,4)], mean),2)
round(sapply(usdata[,c(2,4)], sd),2)
model2 <- lm(PRICE ~ 1 + SQMT + FEATS, data = usdata)
# model2 <- lm(PRICE ~ . - AGE - NE - COR, data = usdata)
summary(model2)
# PRICE = -17592.8 + 732.5*SQMT + 3983.7*FEATS + ε, where ε ~ N(0,14370^2)
# model with centered covariates
usdata2 <- as.data.frame(scale(usdata[,1:4], center = TRUE, scale = F))
usdata2$NE <- usdata$NE
usdata2$COR <- usdata$COR
usdata2$PRICE <- usdata$PRICE
round(sapply(usdata2[,c(2,4)], mean),2)
round(sapply(usdata2[,c(2,4)], sd),2)
mfull2 <- lm(PRICE~.,data=usdata2)
step(mfull2, direction='both')
model3 <- lm(PRICE ~ 1 + SQMT + FEATS, data = usdata2)
summary(model3)
# PRICE = 115841.3 + 732.5*SQMT + 3983.7*FEATS + ε, where ε ~ N(0,14370^2)
anova(model2, model3)

##################################################################################################################################
##################################################################################################################################
##                                                                                                                              ##
##                                                  ANSWER TO QUESTION 8                                                        ##
##                                                                                                                              ##
##################################################################################################################################
##################################################################################################################################

# install.packages("car")
# install.packages("randtests")
# install.packages("lmtest")
par(mfrow=c(1,1))
# Normality of errors (Q-Q Plot)
plot(model3, which = 2)
# Constant Variance
plot(model3, which = 3)
Stud.residuals <- rstudent(model3)
yhat <- fitted(model3)
par(mfrow=c(1,2))
plot(yhat, Stud.residuals)
abline(h=c(-2,2), col=2, lty=2)
plot(yhat, Stud.residuals^2)
abline(h=4, col=2, lty=2)
library(car)
ncvTest(model3)
yhat.quantiles<-cut(yhat, breaks=quantile(yhat, probs=seq(0,1,0.25)), dig.lab=6)
table(yhat.quantiles)
leveneTest(rstudent(model3)~yhat.quantiles)
par(mfrow=c(1,1))
boxplot(rstudent(model3)~yhat.quantiles)
# Non Linearity
residualPlot(model3, type='rstudent')
residualPlots(model3, plot=F, type = "rstudent")
# Independence of Errors
plot(rstudent(model3), type='l')
library(randtests)
randtests::runs.test(model3$res)
library(lmtest)
dwtest(model3)
library(car)
durbinWatsonTest(model3)


##################################################################################################################################
##################################################################################################################################
##                                                                                                                              ##
##                                                  ANSWER TO QUESTION 9                                                        ##
##                                                                                                                              ##
##################################################################################################################################
##################################################################################################################################

# install.packages("glmnet")
library(glmnet)
X <- model.matrix(mfull2)[,-1]
lasso <- glmnet(X, usdata2$PRICE)
plot(lasso, xvar = "lambda", label = T)
#Use cross validation to find a reasonable value for lambda 
lasso1 <- cv.glmnet(X, usdata2$PRICE, alpha = 1)
lasso1$lambda
lasso1$lambda.min
lasso1$lambda.1se
plot(lasso1)
coef(lasso1, s = "lambda.min")
coef(lasso1, s = "lambda.1se")
plot(lasso1$glmnet.fit, xvar = "lambda", label = T)
abline(v=log(c(lasso1$lambda.min, lasso1$lambda.1se)), lty =2)
