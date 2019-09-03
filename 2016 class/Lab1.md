---
title: "Introduction to R and RStudio using baseball stats"
author: Michael Lopez
---

The movie [Moneyball](http://en.wikipedia.org/wiki/Moneyball_(film)) focuses on
the "quest for the secret of success in baseball". It follows a low-budget team, 
the Oakland Athletics, who believed that underused statistics, such as a player's 
ability to get on base, betterpredict the ability to score runs than typical 
statistics like home runs, RBIs (runs batted in), and batting average. Obtaining 
players who excelled in these underused statistics turned out to be much more 
affordable for the team.

In this lab we'll be looking at data from all 30 Major League Baseball teams and
examining the relationships between in-game statistics. Our primary aim, for today, is a familiarity with R and RStudio, which you'll be using throughout the course both to learn the statistical concepts discussed in class and also to analyze real data and come to informed conclusions.  

To straighten out which is which: R is the name of the programming language itself and RStudio is a convenient interface.

As the labs progress, you are encouraged to explore beyond what the labs dictate;
a willingness to experiment will make you a much better programmer.  Before we 
get to that stage, however, you need to build some basic fluency in R.  Today we
begin with the fundamental building blocks of R and RStudio: the interface, 
reading in data, and basic commands.

The panel in the upper right contains your *workspace* as well as a history of 
the commands that you've previously entered.  Any plots that you generate will 
show up in the panel in the lower right corner.

The panel on the left is where the action happens.  It's called the *console*. 
Everytime you launch RStudio, it will have the same text at the top of the 
console telling you the version of R that you're running.  Below that information
is the *prompt*.  As its name suggests, this prompt is really a request, a 
request for a command.  Initially, interacting with R is all about typing commands
and interpreting the output. These commands and their syntax have evolved over
decades (literally) and now provide what many users feel is a fairly natural way
to access data and organize, describe, and invoke statistical computations.

To get you started, enter the following command at the R prompt (i.e. right after
`>` on the console).  You can either type it in manually or copy and paste it
from this document. This command instructs R to access the OpenIntro website and fetch some data: the `mlb11` data set.

```{r load-abrbuthnot-data, eval=TRUE}
download.file("http://www.openintro.org/stat/data/mlb11.RData", destfile = "mlb11.RData")
load("mlb11.RData")
```

Let's load up the data for the 2011 season. In addition to runs scored, there are seven traditionally used variables in the data set: at-bats, hits, home runs, batting average, strikeouts, stolen bases, and wins. There are also three newer variables: on-base percentage, slugging percentage, and on-base plus slugging. For the first portion of the analysis we'll consider the seven traditional variables. At the end of the lab, you'll work with the newer variables on your own.

You should see that the workspace area in the upper righthand corner of the RStudio window now lists a data set called `mlb11` that has 30 observations on 12 variables. As you interact with R, you will create a series of objects. Sometimes you load them as we have done here, and sometimes you create them yourself as the byproduct of a computation or some analysis you have performed. Note that because you are accessing data from the web, this command (and the entire assignment) will work in a computer lab, in the library, or in your dorm room; anywhere you have access to the Internet.



## The Data: 2011 baseball statistics



```{r, eval=FALSE}
mlb11
```


What you should see are four columns of numbers, each row representing a 
different team: the first entry in each row is simply the row number (an index 
we can use to access the data from individual years if we want), the second is 
the team, and the remaining columns are team-specific metrics. Use the scrollbar on the right side of the console window to examine the complete data set.

Note that the row numbers in the first column are not part of the MLB data. 
R adds them as part of its printout to help you make visual comparisons. You can
think of them as the index that you see on the left side of a spreadsheet. In 
fact, the comparison to a spreadsheet will generally be helpful. R has stored 
MLB data in a kind of spreadsheet or table called a *data frame*.

You can see the dimensions of this data frame by typing:

```{r, eval=TRUE}
dim(mlb11)
```

This command should output `[1] 30 12`, indicating that there are 30 rows and 12 
columns (we'll get to what the `[1]` means in a bit), just as it says next to 
the object in your workspace. You can see the names of these columns (or 
variables) by typing:

```{r, eval=TRUE}
names(mlb11)
```

You should see that the data frame contains the columns `team`,  `runs`, and 
`at_bats`, etc. At this point, you might notice that many of the commands in R look a 
lot like functions from math class; that is, invoking R commands means supplying
a function with some number of arguments. The `dim` and `names` commands, for 
example, each took a single argument, the name of a data frame. 

One advantage of RStudio is that it comes with a built-in data viewer. Click on
the name `mlb11` in the *Environment* pane (upper right window) that lists 
the objects in your workspace. This will bring up an alternative display of the 
data set in the *Data Viewer* (upper left window). You can close the data viewer
by clicking on the *x* in the upper lefthand corner.

## Some Exploration

Let's start to examine the data a little more closely. We can access the data in
a single column of a data frame separately using a command like

```{r, eval=FALSE}
mlb11$runs
```

This command will only show the number of runs scored each year by each team.

1.  What command would you use to extract just the number of hits for each team? Try it!

Notice that the way R has printed these data is different. When we looked at the
complete data frame, we saw 30 rows, one on each line of the display. These data
are no longer structured in a table with other variables, so they are displayed 
one right after another. Objects that print out in this way are called *vectors*;
they represent a set of numbers. R has added numbers in [brackets] along the 
left side of the printout to indicate locations within the vector. For example,
`1599` follows `[1]`, indicating that `1599` is the first entry in the vector. 
And if `[20]` starts a line, then that would mean the first number on that line
would represent the 20<sup>th</sup> entry in the vector.

One more super-useful command, `head()`, which shows the first six rows of any data frame.

```{r}
head(mlb11)
```

Related: `tail()'

```{r}
tail(mlb11)
```

### mosaic

There is an additional package for R called `mosaic` that streamlines all of the commands that you will need in this course. This package is specifically designed by a team of NSF-funded educators to make R more accessible to statistics students like you. The `mosaic` package doesn't provide new functionality so much as it makes existing functionality more logical, consistent, all the while emphasizing importants concepts in statistics. 

To use the package, you will first need to install it.

```{r, eval=FALSE}
install.packages("mosaic")
```

Note that you will only have to do this *once*. However, once the package is installed, you will have to load it into the current workspace before it can be used. 

```{r, message=FALSE}
require(mosaic)
```

Note that you will have to do this *every* time you start a new R session. 

R has some powerful functions for making graphics. 

The centerpiece of the `mosaic` syntax is the use of the *modeling language*. This involves the use of a tilde (~), which can be read as "is a function of". For example, we can create a simple plot of the number of runs each team scored versus its hits

```{r, eval=FALSE, message=FALSE}
xyplot(runs ~ hits, data=mlb11)
```

By default, R creates a scatterplot with each x,y pair indicated by an open circle. The plot itself should appear under the *Plots* tab of the lower right panel of RStudio. Notice that the command above again looks like a function, this time with two arguments separated by a comma.  The first argument in the plot function specifies the variable for the x-axis and the second for the y-axis. 

You might wonder how you are supposed to know that it was possible to add that 
third argument.  Thankfully, R documents all of its functions extensively. To 
read what a function does and learn the arguments that are available to you, 
just type in a question mark followed by the name of the function that you're 
interested in. Try the following.

```{r, eval=FALSE, tidy = FALSE}
?xyplot
```

Notice that the help file replaces the plot in the lower right panel. You can 
toggle between plots and help files using the tabs at the top of that panel.

2.  Is there an association between runs scored and hits? How would you describe it?

Now, suppose we want to plot only the total number of runs.

```{r, eval=FALSE}
histogram( ~ runs, data=mlb11)
bwplot( ~ runs, data=mlb11)
```

3.  Describe the distribution of runs scored among MLB teams in 2011.  What is the median?



### Additional R functionalities



R can do lots of things besides graphs. In fact, R is really just a big calculator. We can type in mathematical expressions like

```{r, eval=FALSE}
210 + 930
```

to see the total number of homeruns and strikeouts by the Texas Rangers, the first row in our data. We could do this for every row, but there is a faster way. If we add the vectors together, R will compute all sums simultaneously.

```{r, eval=FALSE}
mlb11$homeruns + mlb11$strikeouts
```

What you will see are 30 numbers (in that packed display, because we aren't looking at a data frame here), each one representing the sum we're after. Take a look at a few of them and verify that they are right. 

4.  Which team had the highest cumulative number of strikeouts and homeruns in 2011?

Note that with R as with your calculator, you need to be conscious of the order 
of operations. For example, not the following example.

```{r}
4*6+2
4*(6+2)
```

Finally, in addition to simple mathematical operators like subtraction and 
division, you can ask R to make comparisons like greater than, `>`, less than,
`<`, and equality, `==`. For example, we can ask which home run observations were greater than 200.

```{r, eval=FALSE}
mlb11$homeruns > 200
```

This output shows a different kind of data than we have considered so far. In the 
`mlb11` data frame, most of our values are numerical. Here, we've asked R to create *logical* data, data where the values are either `TRUE` or `FALSE`. In general, data analysis will involve many different kinds of data types, and one reason for using R is that it is able torepresent and compute with many of them.

5.  Which MLB teams had more than 200 home runs in 2011?



## Summaries and tables

A good first step in any analysis is to distill all of that information into a few summary statistics and graphics.  As a simple example, the function `summary` returns a numerical 
summary: minimum, first quartile, median, mean, second quartile, and maximum. 
For `runs` this is

```{r, eval=FALSE}
summary(mlb11$runs)
```

If you wanted to compute the interquartile range for team runs, you could look at the output from the summary command above and then enter

```{r, eval=FALSE}
734 - 629
```

R also has built-in functions to compute summary statistics one by one.  For 
instance, to calculate the mean, median, and variance of `runs`, type 

```{r, eval=FALSE, message=FALSE}
var(~runs, data=mlb11)
median(~runs, data=mlb11)
```

The `mosaic` command `favstats`, allows us to compute all of this information (and more) at once. 

```{r, eval=FALSE}
favstats(~runs, data=mlb11)
```

While it makes sense to describe a quantitative variable like `runs` in terms of these statistics, what about categorical data?  We would instead consider the sample frequency or relative frequency distribution.  The function `tally` does this for you by counting the number of times each kind of response was given. For example, to see the number of teams who hit at least 200 homeruns, type

```{r, eval=FALSE}
mlb11$HighHR <- mlb11$homeruns >= 200
mlb11$HighHR
tally(~ HighHR, data=mlb11)
```

or instead look at the relative frequency distribution by typing

```{r, eval=FALSE}
tally(~ HighHR, data=mlb11, format="proportion")
```

In each of the above steps, we make use of a new variable, `HighHR` (the contents of which 
we can see by typing `HighHR` into the console) and then used it in as the input for `tally`. The special symbol `<-` performs an *assignment*, taking the output of one line of code and saving it into an object in your workspace.  This is another important idea that we'll return to later.


Notice how R automatically divides all entries in the table by 30 in the second command. This is similar to something we observed earlier; when we multiplied or divided a vector with a number, R applied that action across entries in the vectors. As we see above, this also works for tables. Next, we make a bar chart of the entries in the table by putting the table inside the`barchart` command.

```{r, eval=FALSE}
barchart(tally(~HighHR, data=mlb11, margins=FALSE), horizontal=FALSE)
```

Notice what we've done here! We've computed the table of and 
then immediately applied the graphical function, `barchart`. This is an 
important idea: R commands can be nested. You could also break this into two 
steps by typing the following:

```{r, eval=FALSE}
HR <- tally(~ HighHR, data=mlb11, margins=FALSE)
barchart(HR, horizontal=FALSE)
```


6.  Create a numerical summary for `stolen_bases` and `wins`, and compute the interquartile range for each. 


7.  Compute the relative frequency distribution for teams with at least 90 `wins`. How many teams reached 90 wins?  


The `tally` command can be used to tabulate any number of variables that you 
provide.  

8.  What is shown in the following table?  How many teams won 90 or more games and hit at least 200 home runs? 


```{r table-smoke-gender, eval=FALSE}
mlb11$HighWins <- mlb11$wins >=90
tally(HighWins ~ HighHR, data=mlb11, format="count")
```


## How R thinks about data

We mentioned that R stores data in data frames, which you might think of as a 
type of spreadsheet. If we want to access a 
subset of the full data frame, we can use row-and-column notation. For example,
to see the sixth variable of the 7<sup>th</sup> respondent, use the format

```{r, eval=FALSE}
mlb11[7,6]
```

which means we want the element of our data set that is in the 7<sup>th</sup> 
row (meaning the 7<sup>th</sup> team) and the 6<sup>th</sup> 
column (in this case, batting average). We know that `bat_avg` is the 6<sup>th</sup> variable because it is the 6<sup>th</sup> entry in the list of variable names

```{r, eval=FALSE}
names(mlb11)
```

To see the `bat_avg` for the first 10 respondents we can type

```{r, eval=FALSE}
mlb11[1:10,6]
```

In this expression, we have asked just for rows in the range 1 through 10.  R 
uses the `:` to create a range of values, so 1:10 expands to 1, 2, 3, 4, 5, 6, 
7, 8, 9, 10. You can see this by entering

```{r, eval=FALSE}
1:10
```

Finally, if we want all of the data for the first 10 respondents, type

```{r, eval=FALSE}
mlb11[1:10,]
```

By leaving out an index or a range (we didn't type anything between the comma 
and the square bracket), we get all the columns. When starting out in R, this is
a bit counterintuitive. As a rule, we omit the column number to see all columns 
in a data frame. Similarly, if we leave out an index or range for the rows, we 
would access all the observations, not just the 7<sup>th</sup>, or rows 1 
through 10. Try the following to see the batting averages for all 30 teams.

```{r, eval=FALSE}
mlb11[,6]
```

There's an easier way, which you will recall from earlier

```{r, eval=FALSE}
mlb11$bat_avg
```

The dollar-sign tells R to look in data frame `mlb11` for the column called 
`bat_avg`.  Since that's a single vector, we can subset it with just a single 
index inside square brackets.  We see the batting average for the 7<sup>th</sup> 
respondent by typing

```{r, eval=FALSE}
mlb11$bat_avg[7]
```


## Exercises. 


9.  Describe the center, shape, and spread of the `stolen_bases` variable, using an appropriate plot and the appropriate metrics.


```{r}  
### Enter code here.
### Note that any comments in code after the `#` do not get read by R


```


10.  A coach is interested in the link between `stolen_bases` and `runs`. Show the coach a scatter plot, and describe the association. As you make the plot, think carefully about which of these two variables is the explanatory variable (and which is the response).


```{r}
### Enter code here.


```

11.   How can you change the x and y labels on your plots? How can you add a title? Use [google](www.google.com) to guide you, and update your plot in Question 10.


```{r}
### Enter code here.


```


12.   Using visual evidence, find the variable that you think seems to boast the strongest association to `runs`. Consider any continuous variables between columns 3 (`at_bats`) and 12 (`new_obs`).


```{r}
### Enter code here. 


```

13.   What is the variance in the number of strikeouts for each team during the 2011 season? 

```{r}
### Enter code here.

```


14.   Make a new variable, `high_BA`, to represent teams that hit for a batting average of 0.270 or more. How many teams fit into this group?

```{r}
### Enter code here

```

15.   You can use favstats to get the summary statistics within each `high_BA` group, and `bwplot()` to make boxplots. For example, what appears to be the link between `homeruns` and `high_BA`? Do teams with higher batting averages tend to hit more home runs?

```{r, eval = FALSE}
favstats(homeruns ~ high_BA, data = mlb11)
densityplot(~ homeruns, groups = high_BA, data = mlb11, auto.key = TRUE)
```

16.   Repeat the code above, only using `stolen bases` instead of `homeruns`. Does there appear to be a link between `stolen bases` and `high_BA`? 

```{r, eval = FALSE}
### Enter code here. 


```



That was a short introduction to R and RStudio, but we will provide you with more functions and a more complete sense of the language as the course progresses. Feel free to browse around the websites for [R](http://www.r-project.org) and [RStudio](http://rstudio.org) if you're interested in learning more.

<div id="license">
Portions of this lab were adapted for OpenIntro by Andrew Bray and Mine &Ccedil;etinkaya-Rundel from a lab written by Mark Hansen of UCLA Statistics, a product of OpenIntro that is released under a 
[Creative Commons License](http://creativecommons.org/licenses/by-sa/3.0)
</div>


