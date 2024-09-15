# Signal Detection Theory Calculator

This repository contains an R script to calculate signal detection theory (SDT) measures from a a dataset, such as d', criterion, beta, and more.

Also available as a [web app](https://jdmart.shinyapps.io/sdt_calculator/)!

The script was created for my own research purposes, but I hope it can be useful to others as well. If you have any suggestions or improvements, please feel free to contribute.


## Introduction

Signal detection theory (SDT) is a framework for analyzing the ability to differentiate between signal and noise. It is widely used in psychology, neuroscience, and other fields to study perception, memory, and decision-making. You can read more about it, and its applicability, [in this paper](https://journals.sagepub.com/doi/10.1177/0956797614541991). 


## Installation

To use this script, you need to have R installed on your computer. You
can download R from the [Comprehensive R Archive Network
(CRAN)](https://cran.r-project.org/). You can run it directly or through
an IDE, such as RStudio (which you can get at [RStudio's
website](https://posit.co/downloads/)). All needed packages are
installed and loaded at the beginning of the script.


## Usage

<<<<<<< HEAD
The script expects the dataset to be called "data.csv" and to be in the
=======
The script defines a function. sdt(), that expects the dataset to be called "data.csv" and to be in the
>>>>>>> 76a7fd4a18ae7ba490ff9e072c9f7760b8972dc5
project's working directory. Change the name of your data file and move
it, or change the script accordingly.

Furthermore:
- Your first column should be your participant/respondent ID or key.
- Columns 2 through 5 should be your 'hits', 'misses', 'false_alarms' and 'correct_rejections' - in this order, with these names.

<<<<<<< HEAD

=======
Import your csv data (e.g., ```data <- read.csv("data.csv")```, change or rename your file accordingly) and then run sdt(data).
You can save the calculated parameteres to a new object, ```such as data_sdt <- sdt(data)``` and merge it with your data afterwards, ```cbind(data, data_sdt)```.
>>>>>>> 76a7fd4a18ae7ba490ff9e072c9f7760b8972dc5
## Shiny App

I have also created a Shiny app that allows you to upload your 
data and calculate everything without having to run the script in R. You can find
<<<<<<< HEAD
the app [here](https://jdmart.shinyapps.io/sdt_calculator/)
=======
the app [here](https://jdmart.shinyapps.io/sdt_calculator/)
>>>>>>> 76a7fd4a18ae7ba490ff9e072c9f7760b8972dc5
