rm(list = ls())

## Loading required package: ggplot2
library(ggplot2)
require(ggplot2)
## Loading required package: MASS
require(MASS)
## Loading required package: ggpubr
require(ggpubr)
#The initial scatterplot taht investigate whether total abundance changes with mean depth of the water column
fish <- read.csv("../data/fisheries.csv", stringsAsFactors = T)
str(fish)
ggplot(fish, aes(x=MeanDepth, y=TotAbund)) +
  geom_point() + 
  labs(x="Mean Depth (km)", y="Total Abundance")
  theme_classic()
  
# Fitting the model
M1 <- glm(TotAbund~MeanDepth, data=fish, family="poisson")
summary(M1)

# Plot the model diagnostics
# Basic diagnostic plots
par(mfrow=c(2,2))
plot(M1)

# See how many outliers we have
sum(cooks.distance(M1)>1)

# The reason for the model be overdispersed might be:
# Transformation of covariates not needed because we only have one continuous explanatory variable
# Missing covariates/interactions this may be a plausible avenue as we have collected other covariates and/or fixed factors
# Zero-inflation nope, because we have no zeros
# Inherent dependency potentially, we could explore the random effect of year

scatterplot <- ggplot(fish, aes(x=MeanDepth, y=TotAbund, color=factor(Period))) +
  geom_point() +
  labs(x="Mean Depth(km)", y="Total Abundance") +
  theme_classic() +
  scale_color_discrete(name="Period", labels=c("1979-1989", "1997-2002"))
boxplot <- ggplot(fish, aes(x=factor(Period, labels = c("1979-1989", "1997-2002")), y=TotAbund)) +
  geom_boxplot()+
  theme_classic()+
  labs(x="Period", y="Total Abundance")
ggarrange(scatterplot, boxplot, labels=c("A", "B"), ncol=1, nrow=2)

# Adding period as a fixed factor
fish$Period <- factor(fish$Period)
M2 <- glm(TotAbund~MeanDepth*Period, data = fish, family = "poisson")
summary(M2)

# Anova
anova(M2, test="Chisq")

# Fitting a Negative Binomial
M3 <- glm.nb(TotAbund~MeanDepth*Period, data = fish)
summary(M3)

anova(M3, test = "Chisq")

# M4
M4 <- glm.nb(TotAbund~MeanDepth+Period, data = fish)
summary(M4)

anova(M4, test = "Chisq")

# The model diagnostics for M4 and the dispersion parameter
par(mfrow=c(2,2)) # partitioning the plot window into a 2x2
plot(M4)

# Plotting the Negative Binomial Model
range(fish$MeanDepth) #Finding the range of MeanDepth

period1 <- data.frame(MeanDepth=seq(from=0.804, to=4.865, length=100), Period="1")
period2 <- data.frame(MeanDepth=seq(from=0.804, to=4.865, length=100), Period="2")
period1_predictions<- predict(M4, newdata = period1, type = "link", se.fit = TRUE) # the type="link" here predicted the fit and se on the log-linear scale. 
period2_predictions<- predict(M4, newdata = period2, type = "link", se.fit = TRUE)
period1$pred<- period1_predictions$fit
period1$se<- period1_predictions$se.fit
period1$upperCI<- period1$pred+(period1$se*1.96)
period1$lowerCI<- period1$pred-(period1$se*1.96)
period2$pred<- period2_predictions$fit
period2$se<- period2_predictions$se.fit
period2$upperCI<- period2$pred+(period2$se*1.96)
period2$lowerCI<- period2$pred-(period2$se*1.96)
complete<- rbind(period1, period2)

# Making the Plot 
ggplot(complete, aes(x=MeanDepth, y=exp(pred)))+ 
  geom_line(aes(color=factor(Period)))+
  geom_ribbon(aes(ymin=exp(lowerCI), ymax=exp(upperCI), fill=factor(Period), alpha=0.3), show.legend = FALSE)+ 
  geom_point(fish, mapping = aes(x=MeanDepth, y=TotAbund, color=factor(Period)))+
  labs(y="Total Abundance", x="Mean Depth (km)")+
  theme_classic()+
  scale_color_discrete(name="Period", labels=c("1979-1989", "1997-2002"))

# Loading required package: ggeffects
require(ggeffects)
# A simpler way of plotting
plot(ggpredict(M4, terms=c("MeanDepth", "Period")), show_data=T)

# Fitting the poisson model
mites <- read.csv("../data/bee_mites.csv")
str(mites)
mites_m1 <- glm(Dead_mites~Concentration, data=mites, family = "poisson")
summary(mites_m1)

anova(mites_m1, test="Chisq")

# The model diagnostics
par(mfrow=c(2,2))
plot(mites_m1)

# Plotting the model
range(mites$Concentration) # Finding the range of concentration
new_data <- data.frame(Concentration=seq(from=0, to=2.16, length=100))
predictions<- predict(mites_m1, newdata = new_data, type = "link", se.fit = TRUE) # the type="link" here predicted the fit and se on the log-linear scale. 
new_data$pred<- predictions$fit
new_data$se<- predictions$se.fit
new_data$upperCI<- new_data$pred+(new_data$se*1.96)
new_data$lowerCI<- new_data$pred-(new_data$se*1.96)

# Making the Plot 
ggplot(new_data, aes(x=Concentration, y=exp(pred)))+ 
  geom_line(col="black")+
  geom_ribbon(aes(ymin=exp(lowerCI), ymax=exp(upperCI), alpha=0.1), show.legend = FALSE, fill="grey")+ 
  geom_point(mites, mapping = aes(x=Concentration, y=Dead_mites), col="blue")+
  labs(y="Number of Dead Mites", x="Concentration (g/l)")+
  theme_classic()

# EXTRA TASKS

#I know this handout has been particularly long and thorough, but here are some data sets and research questions for you to practise with.
#1.Species richness on the Galapagos islands (“gala.txt”):
#  •How does area of the island affect the number of plant species?
#  •The data set includes the “Species” (the number of species), “Endemics” (the number of endemic species), “Area” (area of the island in km^2), “Elevation” (highest elevation of the island metres), “Nearest” (distance from nearest island in km), “Scruz” (distance from Santa Cruz in km) and “Adjacent” (area of the adjacent island in square kilometres).
#  •HINT: you will need to log transform the variable “Area” as there is a lot of bunching - plot the relationship between Species~Area and Species~log(Area) to see what I mean.
#  2.Amphibian roadkills in Portugal (“RoadKills.txt”):
#  •How does the distance to the nearby park affect the number of road kills?
#  •The data set includes a whole lot of variable but I want you to focus on. “TOT.N” (the total number of roadkills) and “D.PARK” (the distance to nearest park in metres).

# 1. Load the gala.txt
gala <- read.table("../data/gala.txt", header = TRUE)
head(gala)
str(gala)
summary(gala)

# Relation between Species and Area
require(ggplot2)
# Original area
ggplot(gala, aes(x = Area, y = Species)) +
  geom_point() +
  labs(x="Island Area (km²)", y="Number of Species") +
  theme_classic()

# Log
ggplot(gala, aes(x = log(Area), y = Species)) +
  geom_point() +
  labs(x="Log(Island Area)", y="Number of Species") +
  theme_classic()
# Fit the model
# Poisson GLM
model1 <- glm(Species ~ log(Area), family = poisson, data = gala)
summary(model1)

# Overdispersion, so use quasi-likelihood method
model1q <- glm(Species ~ log(Area), family = quasipoisson, data = gala)
summary(model1q)

gala$pred <- predict(model1, type="response")

# Plot
ggplot(gala, aes(x=log(Area), y=Species)) +
  geom_point() +
  geom_line(aes(y=pred), color="red") +
  labs(x="Log(Island Area)", y="Number of Species") +
  theme_classic()

# 2. Load the RoadKills.txt
road <- read.table("../data/RoadKills.txt", header = TRUE)
head(road)
str(road)

ggplot(road, aes(x = D.PARK, y = TOT.N)) +
  geom_point() +
  labs(x="Distance to Nearest Park (m)", y="Total Roadkills") +
  theme_classic()
road_model <- glm(TOT.N ~ D.PARK, family = poisson, data = road)
summary(road_model)

# Check overdispersion
dispersion <- sum(residuals(road_model, type="pearson")^2) / df.residual(road_model)
dispersion  # If > 1, use quasi-likelihood method
road_model_q <- glm(TOT.N ~ D.PARK, family = quasipoisson, data = road)
summary(road_model_q)

road$pred <- predict(road_model, type="response")

ggplot(road, aes(x=D.PARK, y=TOT.N)) +
  geom_point() +
  geom_line(aes(y=pred), color="red") +
  labs(x="Distance to Nearest Park (m)", y="Total Roadkills") +
  theme_classic()


