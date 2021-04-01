library(nloptr)
install.packages("CRAN")
library(CRAN)
#


#still using seed 100
set.seed(100)

#I guess these vars are just passed into the matrix construction method?
N <- 100000
K <- 10
sigma <- 0.5

#x is a matrix, rnorm generates a vector? Not 100% clear on this code
X <- matrix(rnorm(N*K,mean=0,sd=sigma),N,K)

#And since we did this in class, I guess this makes the first column all ones
X[,1] <- 1 # first column of X should be all ones

#using rnorm for vector, N numbers with mean 0 etc.
eps <- rnorm(N,mean=0,sd=0.5)

#beta. Don't think I've ever actually gone over vectors in R, I'll assume
#they're like arrays or something
#sticking with the demo code as I don't know it myself
beta <-as.vector(runif(K))

#matrix multiplication with X & beta, every value has epsilon added?
#meaning, I suppose, every value will be correlated with x, and off by epsilon?
Y <- X%*%beta + eps
#I think this is what I need for y later on, who can tell really, nobody taking this class
y <- X%*%beta + eps
#get betas from OLS
estimates <- lm(Y~X -1)
#nvm that, fixed
print(summary(estimates))

#I thought these were both matrices? oh well
#print(beta - estimates)

print(beta)
print(estimates)





#attempting OLS through gradient descent
#starting with example code in lecture notes

# set up a stepsize
alpha <- 0.00003

# set up a number of iterations
maxiter <- 500000
#nothing to change here
## Our objective function
objfun <- function(beta,y,X) {
  return ( sum((y-X%*%beta)^2) )
}

# define the gradient of our objective function
gradient <- function(beta,y,X) {
  return ( as.vector(-2*t(X)%*%(y-X%*%beta)) )
}


#its read in

#reassign beta, I think it can change type in R? Guess I'll see
beta <- runif(dim(X)[2]) #start at uniform random numbers equal to number of coefficients

# randomly initialize a value to beta
#been there, done that

# create a vector to contain all beta's for all steps

beta.All <- matrix("numeric",length(beta),maxiter)

# gradient descent method to find the minimum
iter  <- 1
beta0 <- 0*beta
while (norm(as.matrix(beta0)-as.matrix(beta))>1e-8) {
  beta0 <- beta
  beta <- beta0 - alpha*gradient(beta0,y,X)
  beta.All[,iter] <- beta
  if (iter%%10000==0) {
    print(beta)
  }
  iter <- iter+1
}


print(paste("The minimum of f(beta,y,X) is ", beta, sep = ""))

#At this point I can only shrug
## Our objective function
objfun <- function(x) {
  return (sum((y-X%*%beta)^2))
}

## initial values
xstart <- 5

## Algorithm parameters
options <- list("algorithm"="NLOPT_LN_NELDERMEAD","xtol_rel"=1.0e-8)


res <- nloptr( x0=xstart,eval_f=objfun,opts=options)
print(res)

#I think I use the nelder mead bit to optimize OLS?


#And here I'll take a run at the last bit
#given code, function given below
gradient <- function('FIND',Y,X) {
  grad     <- as.vector(rep(0,length(theta)))
  beta     <- theta[1:(length(theta)-1)]
  sig      <- theta[length(theta)]
  grad[1:(length(theta)-1)] <- -t(X)%*%(Y - X%*%beta)/(sig^2)
  grad[length(theta)]       <- dim(X)[1]/sig - crossprod(Y-X%*%beta)/(sig^3)
  return ( grad )
}

#normal lm OLS was done first

#CRAN package won't work for me, not sure whats happening there
#I'll figure it out another time


