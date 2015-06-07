# Reproducible Research: Peer Assessment 1

## Introduction

It is now possible to collect a large amount of data about personal movement using activity monitoring devices such as a [Fitbit](http://www.fitbit.com), [Nike Fuelband](http://www.nike.com/us/en_us/c/nikeplus-fuelband), or [Jawbone Up](https://jawbone.com/up). These type of devices are part of the "quantified self" movement -- a group of enthusiasts who take measurements about themselves regularly to improve their health, to find patterns in their behavior, or because they are tech geeks. But these data remain under-utilized both because the raw data are hard to obtain and there is a lack of statistical methods and software for processing and interpreting the data.

This assignment makes use of data from a personal activity monitoring device. This device collects data at 5 minute intervals through out the day. The data consists of two months of data from an anonymous individual collected during the months of October and November, 2012 and include the number of steps taken in 5 minute intervals each day.

## Data

The data for this assignment can be downloaded from the course web site:

* Dataset: [Activity monitoring data](https://d396qusza40orc.cloudfront.net/repdata%2Fdata%2Factivity.zip) [52K]

The variables included in this dataset are:

* **steps**: Number of steps taking in a 5-minute interval (missing values are coded as `NA`)
* **date**: The date on which the measurement was taken in YYYY-MM-DD format
* **interval**: Identifier for the 5-minute interval in which measurement was taken

The dataset is stored in a comma-separated-value (CSV) file and there are a total of 17,568 observations in this dataset.

## Loading and preprocessing the data

Show any code that is needed to

1. Load the data (i.e. `read.csv()`)

A custom function checks if the file has exists in the working directory. If it is not, it downloads the file from the source. Then, it unzips the file into the working directory.


```r
if (!file.exists("activity.zip")) {
  download.file(url = "https://d396qusza40orc.cloudfront.net/repdata%2Fdata%2Factivity.zip",
                destfile = "activity.zip")
}

if (!file.exists("activity.csv")) {
  unzip(zipfile = "activity.zip", files = "activity.csv")
}

activity <- read.csv(file = "activity.csv", 
                     head= T, sep = ",", stringsAsFactors = F)
activity$date <- as.Date(activity$date, format = "%Y-%m-%d")
```

2. Process/transform the data (if necessary) into a format suitable for your analysis

Only **date** is transformed into date format.

## What is mean total number of steps taken per day?

For this part of the assignment, you can ignore the missing values in the dataset.

1. Calculate the total number of steps taken per day


```r
steps.sum <- aggregate(steps ~ date, data = activity, FUN = sum)
```

2. If you do not understand the difference between a histogram and a barplot, research the difference between them. Make a histogram of the total number of steps taken each day


```r
hist(x = steps.sum$steps, 
     main = "Histogram of the total number of steps\ntaken each day", 
     ylab = "Frequency", xlab = "Total Steps per Day")
```

![](PA1_template_files/figure-html/Mean Steps-1.png) 

3. Calculate and report the mean and median of the total number of steps taken per day

`kable` from `knitr` is used to tabulate the mean and median steps.


```r
require(knitr)
steps.mean <- mean(steps.sum$steps); steps.median <- median(steps.sum$steps)
steps.summary <- cbind(Mean = steps.mean, Median = steps.median)
kable(steps.summary, align = "c")
```



   Mean      Median 
----------  --------
 10766.19    10765  

## What is the average daily activity pattern?

1. Make a time series plot (i.e. `type = “l”`) of the 5-minute interval (x-axis) and the average number of steps taken, averaged across all days (y-axis)


```r
steps.interval <- aggregate(steps ~ interval, data = activity, FUN = mean)
with(data = steps.interval, plot(x = interval, y = steps, 
                                 type = "l", 
                                 main = NULL,
                                 xlab = "Interval",
                                 ylab = "Average number of steps taken"))
```

<img src="PA1_template_files/figure-html/Interval-1.png" title="" alt="" style="display: block; margin: auto;" />

2. Which 5-minute interval, on average across all the days in the dataset, contains the maximum number of steps?


```r
kable(steps.interval[which.max(steps.interval$steps), ], align = "c", digits = 2)
```

       interval    steps  
----  ----------  --------
104      835       206.17 

## Imputing missing values



## Are there differences in activity patterns between weekdays and weekends?
