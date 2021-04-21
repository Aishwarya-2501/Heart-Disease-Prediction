# Heart-Disease-Prediction
Data Science Project using R

The data set used in this project contains information related to factor responsible for Heart Attack. We need to analyse the trends in heart data to predict certain cardiovascular events or find any clear indications of heart health. A Logistic Regression Machine Learning Model was created to predict future event. With more data, the predictions can be made more accurate and the patients could be warned for special care.

# Overview of the data set
age < -  age in years								
sex < - ( 0 = male; 1 = female)
cp <- chest pain type
trestbps <- resting blood pressure (in mm Hg on admission to the hospital)
chol <- serum cholesterol in mg/dl
fbs <- (fasting blood sugar > 120 mg/dl) (1 = true; 0 = false)
restecg <- resting electrocardiographic results
thalach <- maximum heart rate achieved
exang <- exercise induced angina (1 = yes; 0 = no)
oldpeak <- ST depression induced by exercise relative to rest
slope <- the slope of the peak exercise ST segment
ca <- number of major vessels (0-3) colored by fluoroscopy
thal <- 1= normal; 2= fixed defect; 3= reversible defect
target <- 1 or 0 (1 stands for presence of heart disease, 0 absence of heart disease)

# Data pre-processing

Package tidyverse is used. From which dplyr and ggplot2 are only used. Package ggplot2, for data visualisation. dplyr, for data manipulation.
Package dplyr: is a package for data manipulation, easy-to-use functions that are very handy when performing exploratory data analysis and manipulation.
Package ggplot2: s a system for declaratively creating graphics, based on The Grammar of Graphics. You provide the data, tell ggplot2 how to map variables to aesthetics, what graphical primitives to use, and it takes care of the details.
library(tidyverse)


Logistic regression machine learning model is used.





