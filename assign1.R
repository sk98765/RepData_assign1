library(data.table)

setwd("d:/R/Rep_data/Assign1")
dt <- fread("activity.csv")

date.sum <- dt[,.(steps.sum = sum(steps)),by=.(date)]

hist(date.sum$steps.sum)

mean.steps.sum <- mean(date.sum$steps.sum,na.rm=T)
median.steps.sum <- median(date.sum$steps.sum, na.rm=T)

# assign 0 to NA
dt[is.na(dt$steps)] <- 0

# group by interval
avg.step <- dt[,.(inter.step.avg = mean(steps)),by=.(interval)]

# 
plot(inter.step.avg ~ interval, avg.step, type="l",
     xlab="5-minute interval",
     ylab="average number of steps taken, average acrooss all days")

rm(dt)
# Get the maximum number of steps taken 
sorted_avg <- avg.step[rev(order(inter.step.avg))]
head(sorted_avg,n=1)
rm(sorted_avg)

orgdt <- fread("activity.csv")

# Imputing missing values
tt <- orgdt[is.na(orgdt$steps)]
length(tt$steps)

rm(tt)
# Devised a strategy 
# Use the mean 5-min interval to fill in the missing data
# Get NAs from steps variable 

NAs <- is.na(orgdt$steps)

# add inter.step.avg from avg.step to orgdt 
orgdt$avgsteps <- avg.step$inter.step.avg
# Replace orgdt$steps with orgdt$avgsteps is orgdt$steps is NA
orgdt$steps <- as.numeric(orgdt$steps)
orgdt$steps[NAs] <- orgdt$avgsteps[NAs]

rm(NAs)
# Remove the avgsteps column 
orgdt$avgsteps <- NULL
# orgdt <- orgdt[,.(steps,date,interval)]

# After removing the avgsteps column, we have a dataset with no NAs
new.date.sum <- orgdt[,.(steps.sum = sum(steps)),by=.(date)]

# Draw a histogram plot 
hist(new.date.sum$steps.sum)

new.mean.steps.sum <- mean(new.date.sum$steps.sum)
new.median.steps.sum <- median(new.date.sum$steps.sum)

orgdt$date <- as.Date(orgdt$date)

orgdt$wday <- weekdays(orgdt$date)

dt$wday[dt$wday %in% c("Monday","Tuesday","Wednesday","Thursday","Friday")] <- "weekday"
dt$wday[dt$wday %in% c("Saturday","Sunday")] <- "weekend"
orgdt$wday <- as.factor(orgdt$wday)






