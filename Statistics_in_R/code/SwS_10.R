rm(list = ls())

# create three data sets y with different variances (1, 10, 100)
# rnorm() requires sample size (20), mean and ad
y1 <- rnorm(10, mean = 0, sd = sqrt(1))
var(y1)

y2 <- rnorm(10, mean = 0, sd = sqrt(10))
var(y2)

y3 <- rnorm(10, mean = 0, sd = sqrt(100))
var(y3)

# create x variable for plotting
x <- rep(0, 10)
#making a 1*3 plot using ,mfrow() (look it up if you don't know what that does)
par(mfrow = c(1, 3))
plot(x, y1, xlim = c(-0.1, 0.1), ylim = c(-12, 12), pch = 19, cex = 0.8, col = "red")
abline(v = 0)
abline(h = 0)

plot(x, y2, xlim = c(-0.1, 0.1), ylim = c(-12, 12), pch = 19, cex = 0.8, col = "blue")
abline(v = 0)
abline(h = 0)

plot(x, y3, xlim = c(-0.1, 0.1), ylim = c(-12, 12), pch = 19, cex = 0.8, col = "darkgreen")
abline(v = 0)
abline(h = 0)

# Lets plot this again, this time wih the squares.
par(mfrow = c(1, 3))
plot(x, y1, xlim = c(-12, 12), ylim = c(-12, 12), pch = 19, cex = 0.8, col = "red")
abline(v=0)
abline(h=0)
polygon(x = c(0,0,y1[1],y1[1]),y = c(0,y1[1],y1[1],0), col = rgb(1, 0, 0, 0.2))
polygon(x = c(0,0,y1[2],y1[2]),y = c(0,y1[2],y1[2],0), col = rgb(1, 0, 0, 0.2))

