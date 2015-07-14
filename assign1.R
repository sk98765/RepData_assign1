library(data.table)

setwd("d:/R/Reproducible/Assign1")
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
plot(inter.step.avg ~ interval, avg.step, type="l")
