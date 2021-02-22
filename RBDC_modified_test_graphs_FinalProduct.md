---
title: "RBDC Presentation"
author: "Matthew Goodsell"
date: "6/10/2020"
output:
  html_document:
   keep_md: TRUE 
---





# Graphs {.tabset .tabset-fade .tabset-pills}

- NOTE THE CHANGE IN SCALE BETWEEN THE GRAPHS - SCALES MAY BE INDEPENDENT. 

## Line Graphs 

Insights: 

- Method 1 seems to always to more accurate, and it appears to be radius independent

- Method 1 seems to favor radius of .099 

- Method 2 also prefers a search radius of 0.099

### Data from test circle of radius 0.099

![](RBDC_modified_test_graphs_FinalProduct_files/figure-html/testRadius-0.099-1.png)<!-- -->


### Data from test circle of radius 0.01

![](RBDC_modified_test_graphs_FinalProduct_files/figure-html/testRadius-0.01-1.png)<!-- -->


### Data from test circle of radius 0.011

![](RBDC_modified_test_graphs_FinalProduct_files/figure-html/testRadius-0.011-1.png)<!-- -->


## Distribution graphs

### Distribution of method 1

![](RBDC_modified_test_graphs_FinalProduct_files/figure-html/Distance 1 distribution-1.png)<!-- -->

### Overal Distribution of method 1

![](RBDC_modified_test_graphs_FinalProduct_files/figure-html/overall distribution-1.png)<!-- -->

### Distribution of Method 2

![](RBDC_modified_test_graphs_FinalProduct_files/figure-html/Distance 2 Distribution-1.png)<!-- -->

### Overall Distribution of Method 2

![](RBDC_modified_test_graphs_FinalProduct_files/figure-html/overal distribution of method 2-1.png)<!-- -->

## Bar plots of Average Votes

Insights:

- Expected behavior on the bar graphs

### Overall Average Highest Votes


```
## `summarise()` regrouping output by 'Search Radius' (override with `.groups` argument)
## `summarise()` regrouping output by 'Search Radius' (override with `.groups` argument)
```

![](RBDC_modified_test_graphs_FinalProduct_files/figure-html/overall-1.png)<!-- -->

### Average highest vote for test circle of 0.09


```
## `summarise()` regrouping output by 'Search Radius' (override with `.groups` argument)
## `summarise()` regrouping output by 'Search Radius' (override with `.groups` argument)
```

![](RBDC_modified_test_graphs_FinalProduct_files/figure-html/avg high vote 0.09-1.png)<!-- -->


### Average highest vote for test circle of 0.01


```
## `summarise()` regrouping output by 'Search Radius' (override with `.groups` argument)
## `summarise()` regrouping output by 'Search Radius' (override with `.groups` argument)
```

![](RBDC_modified_test_graphs_FinalProduct_files/figure-html/avg high vote 0.01-1.png)<!-- -->


### Average highest vote for test circle of 0.011


```
## `summarise()` regrouping output by 'Search Radius' (override with `.groups` argument)
## `summarise()` regrouping output by 'Search Radius' (override with `.groups` argument)
```

![](RBDC_modified_test_graphs_FinalProduct_files/figure-html/avg high vote 0.011-1.png)<!-- -->


## Average Layer mean 

Insights:

- Note the high confidence spikes of search radius of 0.099.


```
## `summarise()` regrouping output by 'Search Radius', 'Resolution', 'test_circle' (override with `.groups` argument)
```

![](RBDC_modified_test_graphs_FinalProduct_files/figure-html/avg layer mean-1.png)<!-- -->


