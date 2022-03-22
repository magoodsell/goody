# My personal Cheat Sheet
### To pandas and Altair 

---------------------------------
### What to add
- how to pivot tables 
- more options for the mark option 
- how to drop nas in a row
- difference between unique and nunique
- definitions of precesion and recall and accuracy for machine learning models. 
---------------------------------


## loading the data
```python
url = "https://raw.githubusercontent.com/byuidatascience/data4names/master/data-raw/names_year/names_year.csv"
names_data = pd.read_csv(url)
```
## Understanding the data or quick descriptions
```python
names_data.info()
<dataset>.dtypes
<dataset>.shape # gives the dimensions of the data. 
<dataset>.columns
<dataset>.unique() # gets the unique values
<dataset>.nunique() # returns the number of unique values there are
```

## summary statistics 
```python
<dataset>.describe()
<dataset>.agg( {'column': [<list of statistics>]} ) 
   https://pandas.pydata.org/docs/user_guide/basics.html#basics-stats

```

## Getting na counts 

```python 
<dataset>.isnull().sum()
```

## Lambda functions
```python
   lamba x: x.<somecolumn or agg value>
```
- The x references the dataset or the takes into account all the changes made up to the lamba function. 


## Disabling row count
```python
alt.data_transformers.disable_max_rows()
```
## Wrangling data
```python
<dataset>.query("<variable_name> in []")
``` 
- for multiple people or multiple values use the in statement. 

## Dealing with numbers
```python
<data>.pandas.round(<#ofdecimals>)
```

### R's dplyr to python

|       dplyr       |      python       |
|-------------------|:------------------|
|  filter()         | query()           |
|  arrange()        | sort_value()      |
|  select()         | filter() or loc[] or iloc[] |
|  rename()         | rename()          |
|  mutate()         | assign()          |
|  group_by()       | groupby()         |
|  summarise()      | agg()             |


### Different ways to filter the dataset
```python
my_list_of_names = ['Katie', 'Kyle', 'Bob']
names_data[names_data['name'].isin(my_list_of_names)]
names_data.query('name == "Katie"')
names.query('name == "Katie" | name == "Kyle"')
names.query('name in @my_list_of_names')
names.query('name == @my_list_of_names')
# selecting columns
names.filter(['<column>',...])
```

### What to do with missing values 
```python
replace(<value>, <new value>)

# will drop any row with a na value in it. 
dat.dropna(how = 'all') 
```

## Validing data
- know the descriptive statistics
- know if there are missing or na values 
   - know how many there are. 
- know the distribution of the data

---------------------------------------------------
## ALTAIR 

### Altair's grammer of Graphics
- Data - ed. tabular data
- Mark - geometric objects we draw on the chart
- Encoding - mapping between the visual properties to the data or variables
- Transform - ex. calculations, filters, aggregate (wrangling data in Altair)
- Scale - is a function. The outputs is the pixels on the screen 
- Guide - ex. legends

###### Data types Altair can handle
- quantitative (numerical)
- ordinal (categorical)
- nomial (categorical)
- temporal
- geopraphic data


## Template for charts
- Altair Documentation - https://altair-viz.github.io/index.html

- shorthand documentation - https://altair-viz.github.io/user_guide/encoding.html#shorthand-description 

```python
(alt.Chart(<DATA>)  
   .encode(x = alt.X('<column>', axis = [alt.Axis(format = '<>', title = '<Title>') | <'None'>], sort = ['y' | '-y'])
         , y = "<column>"
         , text = "<column>")
   <.mark_*()> (area, bar, circle, line, point, text, ...)
         , color = alt.value('<color>')
   .properties(
               height = 150
               , width = 500
               , title = {'text': "Title", 'subtitle': "Subtitle"}
               )
   # This will align the title differently. 
   .configure_title(
         anchor='start' # align the title to the far left. 
      )
)
```

### Encoding Data types 
| Datatype | Shorthand Code | Description |
|-----------:|:------------------:|:-------------------|
|Quantitative|  Q  | a continuous real-valued quantity |
|Ordinal     |  O  | discrete order quanitity          |
|Numeric     |  N  | discrete unordered category       |
|Temporal    |  T  | time or data value                |  
|geojson     |  G  | a geographic shape                |


### Arguments for the different markings
```python
.mark_text(
   align=['left',  'center', 'right']
   , baseline='middle' # ? 
   , dy=-20 # ? 
)

```

### Arguments for the format
```python

.encode(x = alt.X('<column>', alt.Axis(format = '<>')))
['average', 'count', 'distinct', 'max', 'mean', 'median', 'min', 'missing', 'product', 'q1', 'q3', 'ci0', 'ci1', 'stderr', 'stdev', 'stdevp', 'sum', 'valid', 'values', 'variance', 'variancep']
```

### Themes for charts 
```python
alt.themes.enable('fivethirtyeight')
```

### Saving Charts in Altair
```python
<chartname>.save(<file path.png>)
```

-------------------------------------------
# Machine Learning 

## packages to load 
```python 
from sklearn.model_selection import train_test_split
from sklearn import metrics
from sklearn import tree
from sklearn.tree import DecisionTreeClassifier
from sklearn.naive_bayes import GaussianNB

from sklearn.ensemble import RandomForestClassifier
from sklearn.ensemble import GradientBoostingClassifier


import numpy as np
import altair as alt
import pandas as pd
```

## Steps in creating a model 

1. Import packages 
2. Load data
   a. Wrangle if neccessary 
3. Create feature and target dataframes 
   a. Either use kitchen sink approach or use specific features of the dataset

##### features are the inputs
features = <dataset>.<filter>(
    [<'column'>, <'column'>, ...])

##### Targets are the outputs
targets = <dataset>.<column>

4. Use the train_test_split function 

x_train, x_test, y_train, y_test = train_test_split(features, targets, test_size=.3, random_state=76)

5. Use a classifier
6. Train the model 
7. Make predicitions with the model
8. test the accuracy of the predictions 

Process to the above:

##### create a classification model
classifier_<abbreviations_of_classifer> = <classifier>()
##### train the model
classifier_<abbreviations_of_classifer>.fit(x_train, y_train)
##### use your model to make predictions!
y_predicted = classifier_DT.predict(x_test)
##### test how accurate those predictions are
metrics.accuracy_score(y_test, y_predicted)



```python
print(confusion_matrix(y_test, y_predicted))

confusion_metric = metrics.plot_confusion_matrix(classifier_DT, x_test, y_test)

print("Accuracy:", metrics.accuracy_score(y_test, y_predicted))
print("Balanced Accuracy:", metrics.balanced_accuracy_score(y_test, y_predicted))

print(metrics.classification_report(y_test, y_predicted))

classifier_<abbreviations_of_classifer> = sklearn.tree.plot_tree
```


## Different classifiers 

- GaussianNB
- DecisionTreeClassifier
- RandomForestClassifier - A random forest is a meta estimator that fits a number of decision tree classifiers on various sub-samples of the dataset and uses averaging to improve the predictive accuracy and control over-fitting.
- GradientBoostingClassifier - generalization of boosting to arbitrary differentiable loss functions


## python functions

pd.get_dummies()
   - converts column values to 1 and 0's. So takes all the values and then creates new columnsn with 1 or 0. 
pd.factorize 
   - similar to a factor in R, where it maps different categories to a value. 
   - useful if there is a licard scale 



# metrics for measure a model

**Accuracy** - measure of the overall performance of the model. 
   - Formula:
      $$\frac{TP + TN}{(TP + FP + TN + FN)}$$

**Recall** - captures how many of the actual positives the model captures. Good to use when there is a *high cost for false negatives (which are actually positives)*
   - Formula:
      $$\frac{TP}{(TP + FN)}$$
      * denominator is the total actual positives


**Precision** - how good the model was at testing a positive results. Good to use when there is a *high cost for false positive*
   - Formula:
      $$\frac{TP}{TP + FP}$$

**F1 Score** - function of precision and recall. Use to seek a a balance between the two AND there is an uneven class distribution. (large number of Actual Negatives).
   - Formula:
      $$ 2 * \frac{Precision * Recall}{precision + Recall} $$



