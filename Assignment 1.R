## Loading and preprocessing the data
dataset <- read.csv(unzip("repdata-data-activity.zip"), head=T, sep=",", stringsAsFactors = F)
dataset$date <- as.Date(dataset$date, format = "%Y-%m-%d")

Only 'date' is transformed into date format.


## What is mean total number of steps taken per day?



## What is the average daily activity pattern?



## Imputing missing values



## Are there differences in activity patterns between weekdays and weekends?