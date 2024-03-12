###########
###########
# Oscar Jaroker 3/10/2024
# Input to this file is the r and theta values
# Will write a .csv file called out.csv with the thrown r and theta
# getDifficulty() and simulateThrow() written by Professor Cipolli at Colgate University
###########
###########


input = commandArgs(TRUE) #Read input from command line as character vector
print(input)
in1 = as.numeric(input[1]) # input r
in2 = as.numeric(input[2]) # input theta

# Create function getDifficulty(cpuLevel)
getDifficulty <- function(cpuLevel){
  probability.goal <- sqrt((cpuLevel/100) * (1/2))  # 50% is very high for treble accuracy
  # sqrt() splits the error between radius and angle
  difficulty <- c(NA,NA)
  
  # Find sigma so that the probability of hitting a triple 20 wrt r is probability.goal*(1/sqrt(1.6)) (more likely to miss than angle)
  # center of treble bed is 103 mm from center of double bull and 8mm wide
  difficulty[1] <- uniroot(f = function(x){((pnorm(q = 4, mean = 0, sd = x) - pnorm(q = -4, mean = 0, sd = x))-probability.goal*(1/sqrt(1.6)))},
                           interval=c(0,10000))$root
  
  
  
  # Find sigma so that the probability of hitting a triple 20 wrt theta is probability.goal*(1.6/sqrt(1.6)) (lower weight than radius)
  difficulty[2] <- uniroot(f = function(x){((pnorm(q = 9, mean = 0, sd = x) - pnorm(q = -9, mean = 0, sd = x))-probability.goal*(1.6/sqrt(1.6)))},
                           interval=c(0,10000))$root
  
  difficulty
}

# Create a function simulateThrow() that will return the thrown r and theta
simulateThrow <- function(r, theta, difficulty){
  # simulate r.error from the normal with mean0 and difficulty[1] as sd
  thrown.r <- r + rnorm(n = 1, mean = 0, sd = difficulty[1])
  # simulate theta.error from the normal with mean0 and difficulty[2] as sd
  thrown.theta <- theta + rnorm(n=1, mean = 0, sd = difficulty[2])
  
  # NOTE: if r is negative we need to adjust (-180) and theta should be between 0 and 360
  # if r<0 I'm on the other side of the board, so add 180
  if(thrown.r<0){
    thrown.r <- abs(thrown.r)
    thrown.theta <- thrown.theta + 180
  }
  # fix if theta > 360 return the remainder (modulus) when divided by 360
  thrown.theta <- thrown.theta %% 360
  
  # return resulting throw
  c(thrown.r, thrown.theta)
}


# Create function polToCart to convert polar coordinates of throw to cartesian
polToCart = function(throwPolar){
  
  r = throwPolar[1]
  theta = throwPolar[2]
  #convert theta to radians
  thetaRad = theta * pi / 180
  
  # convert to cartesian
  z = r*cos(thetaRad)
  y = r*sin(thetaRad)
  
  # round to 6th decimal place to avoid floating point mistakes
  z = round(x,digits=6)
  y = round(y,digits=6)
  
  # return cartesian coordinates, middle of bullseye is (0,0)
  # left is positive z, right is negative z
  c(z*-1,y)
  
}

diff = 35
# difficulty contains standard deviations in r and theta
difficulty = getDifficulty(diff)

# Simulate throw given difficulty
throw = simulateThrow(in1,in2,difficulty)

#Convert to cartesian
throwCoords = polToCart(throw)

# Write a .csv file with the results
write.csv(throwCoords, "out.csv")