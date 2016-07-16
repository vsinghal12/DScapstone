Data Science Capstone
========================================================
author: Vivek Singhal
date: 7/13/16
autosize: true

Introduction
========================================================

The purpose of this capstone is to be able to use natural language algorithms to predict the next word based on an input of a sequence of words using english twitter, blog, and news data

The subtasks of this objective were the following:

- Perform data cleansing of twitter, blog and news data through elimination of extraneous characters
- Filter profanity and then peform exploratory analysis of corpus
- Tokenize data into n-grams and test prediction algorithms
- Create Shiny App for word prediction

The latter two steps in particular will be expound upon in the next slides


Stupid Backoff Implementation
========================================================

A brief description of the algorithm is: When trying to find the probability of word appearing in a sentence it will first look for context for the word at the n-gram level and if there is no n-gram of that size it will recurse to the (n-1)-gram and multiply its score with 0.4. The recursion stops at unigrams.

Using the Rweka package the data is tokenized and then passed through a predict function utilizing the above method. 

A more elaborate description of the Stupid Backoff Implementation Method can be found here:

http://www.aclweb.org/anthology/D07-1090.pdf

Prediction Examples
========================================================

Below you can see examples of predictions based on a phrased input. Notice that the 3 word outputs generally have at least one word with some reasonable relation to input phrase.


```r
source('predictStBackoff.R')
predict0("He likes cooking")
```

```
[1] "spray" "class" "time" 
```

```r
predict0("He plays football")
```

```
[1] "team"   "game"   "season"
```

```r
predict0("She likes to read")
```

```
[1] "book"    "books"   "article"
```

This algorithm seems to predict reasonably well with simple inputs, but has difficulty with more complex, ambigous inputs. There is significant room for improvment.

App and other resources
========================================================
A shiny app which attempts to replicate the action of the code in the previous slide is here (Note: this app times out on occasion due to size of Rdata it is referencing):

https://vsinghal12.shinyapps.io/predictCapstone/


Github link with various intermediate artifacts is located here. This will be updated periodically with any new improvments. 

insert github link here:
