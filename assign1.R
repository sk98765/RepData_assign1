library(data.table)

dt <- fread("activity.csv")

date.sum <- dt[,.(steps.sum = sum(steps)),by=.(date)]

hist(date.sum$steps.sum)

mean.steps.sum <- mean(date.sum$steps.sum,na.rm=T)
median.steps.sum <- median(date.sum$steps.sum, na.rm=T)

