# artifical kernel example
u <- c(1,2)
v <- c(3,4)
k <- function(u,v){
  u[1]*v[1] + u[2]*v[2] + u[1]*u[1]*v[1]*v[1] + 
    u[2]*u[2]*v[2]*v[2] + u[1]*u[2]*v[1]*v[2]
}

phi <- function(x) {
  x <- as.numeric(x)
  c(x,x*x, combn(x,2,FUN = prod))
}

print(k(u,v))
print(phi(u))
print(phi(v))
print(as.numeric(phi(u) %*% phi(v)))

# apply stepwise linear regression to PUMS data
load("psub.rdata")
dtrain <- subset(psub, ORIGRANDGROUP >= 500)
dtest <- subset(psub, ORIGRANDGROUP < 500)

m1 <-  step(lm(log(PINCP, base=10) ~ AGEP + SEX + COW + SCHL,
               data=dtrain),
            direction='both')

rmse <- function(y, f) {
  sqrt(mean((y-f)^2))
}

print(rmse(log(dtest$PINCP, base = 10), predict(m1,
                                                newdata=dtest)))


# explicit kernel transformation example
phi <- function(x) {
  x <- as.numeric(x)
  c(x,x*x,combn(x,2,FUN=prod))
}
phiNames <- function(n) {
  c(n,paste(n,n,sep=':'),
    combn(n,2,FUN=function(x) {paste(x,collapse=':')}))
}
modelMatrix <- model.matrix(~ 0 + AGEP + SEX + COW + SCHL,psub)
colnames(modelMatrix) <- gsub('[^a-zA-Z0-9]+','_',
                              colnames(modelMatrix))
pM <- t(apply(modelMatrix,1,phi))
vars <- phiNames(colnames(modelMatrix))
vars <- gsub('[^a-zA-Z0-9]+','_',vars)
colnames(pM) <- vars
pM <- as.data.frame(pM)

pM$PINCP <- psub$PINCP
pM$ORIGRANDGROUP <- psub$ORIGRANDGROUP
pMtrain <- subset(pM,ORIGRANDGROUP >= 500)
pMtest <- subset(pM,ORIGRANDGROUP < 500)

# modeling using explicit kernel transfom
formulaStr2 <- paste('log(PINCP,base=10)',
                     paste(vars,collapse = '+'),
                     sep='~')

m2 <- lm(as.formula(formulaStr2), data=pMtrain)

coef2 <- summary(m2)$coefficients

interestingVars <- setdiff(rownames(coef2)[coef2[,'Pr(>|t|)']<0.01],
                           '(Intercept)')
interestingVars <- union(colnames(modelMatrix),interestingVars)

formulaStr3 <- paste('log(PINCP,base=10)',
                     paste(interestingVars,collapse=' + '),
                     sep=' ~ ')
m3 <- step(lm(as.formula(formulaStr3),data=pMtrain),direction='both')
print(rmse(log(pMtest$PINCP,base=10),predict(m3,newdata=pMtest)))

print(summary(m3))
