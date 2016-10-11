---
title       : MLB Team History from 1973 to 2014
subtitle    : Developing Data Products Course Project
author      : Douglas Wirtz
job         : Chemist
framework   : io2012        # {io2012, html5slides, shower, dzslides, ...}
highlighter : highlight.js  # {highlight.js, prettify, highlight}
hitheme     : tomorrow      # 
widgets     : []            # {mathjax, quiz, bootstrap}
mode        : selfcontained # {standalone, draft}
knit        : slidify::knit2slides
---

## MLB Application

The MLB application was built with intention to explore the MLB team history from 1973 to 2014.

The application can be found at [https://dswirtz.shinyapps.io/MLB_App/](https://dswirtz.shinyapps.io/MLB_App/).

The features of the application are as follows:
* A slider that allows the user to filter which years are shown in the dataset
* A series of checkboxes that allows the user to filter which teams are shown in the dataset
* A legend that has the extended names for the variables in the dataset
* An interactive datatable that allows the user to search, ascend, and descend variables
* An interactive chart that allows the user to visualize a comparison between two variables
* Information tab that includes details of the application

---

## Data

The data used for this application was found on [statcrunch.com](http://www.statcrunch.com).
The dataset, [MLB Team Histories (1973-2014)](http://www.statcrunch.com/5.0/index.php?dataid=1819295) was modified to remove redundancies and fix inaccuracies in some stats. The modified version of the dataset can be found on [github](https://github.com/dswirtz/DevelopingDataProducts). Dimensions and features of the data frame are below.


```r
data <- read.csv("MLB Team History (1973-2014).csv", check.names = FALSE)
dim(data); colnames(data)
```

```
## [1] 1162   27
```

```
##  [1] "Year"      "Team"      "Franchise" "G"         "W"        
##  [6] "L"         "R"         "R/G"       "AB"        "H"        
## [11] "1B"        "2B"        "3B"        "HR"        "BB"       
## [16] "SO"        "SB"        "CS"        "HBP"       "SF"       
## [21] "Outs"      "RA"        "RA/G"      "BA"        "OBP"      
## [26] "SLG"       "OPS"
```

---  

## Data Table Example

In this example, the data table was filtered to see which team from 2004 to 2014 had the most wins. You can see that the 2004 St. Louis Cardinals had the most wins with 105.

![](./assets/img/DataTable.png)

---

## Chart Example

In this example, the chart is displaying the trend of strike outs (SO) for every team from 1973 to 2014. 

![](./assets/img/Chart.png)




