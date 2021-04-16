#Heart Disease Prediction Project-----------------

#AIM : Predict whether a person is having a heart disease or not. Data set is from Kaggle

#LINK FOR DATASET : https://raw.githubusercontent.com/Aishwarya-2501/Heart-Disease-Prediction/main/Heart_data.csv


library(tidyverse)

#Importing data

data <- read.csv("https://raw.githubusercontent.com/Aishwarya-2501/Heart-Disease-Prediction/main/Heart_data.csv")
glimpse(data)

#Showing dimension and checking for null and na values

dim(data)
cat('completely filled rows -> ', sum(complete.cases(data)))
list_na <- colnames(data)[ apply(data, 2, anyNA)]
cat('Columns with null values -> ', list_na)
cat('null values -> ', sum(is.na(data)))
cat('No Na Values')

#Correcting the name of the first column in the data set

names(data)[1] <- paste("age")



#Using mutate function to convert data into more readable format , mutate is the part of dplyr

data2 <- data %>% 
  mutate(sex = if_else(sex == 1, "MALE", "FEMALE"),
         fbs = if_else(fbs == 1, ">120", "<=120"),
         exang = if_else(exang == 1, "YES" ,"NO"),
         cp = if_else(cp == 1, "ATYPICAL ANGINA",
                      if_else(cp == 2, "NON-ANGINAL PAIN", "ASYMPTOMATIC")),
         restecg = if_else(restecg == 0, "NORMAL",
                           if_else(restecg == 1, "ABNORMALITY", "PROBABLE OR DEFINITE")),
         slope = as.factor(slope),
         ca = as.factor(ca),
         thal = as.factor(thal),
         target = if_else(target == 1, "YES", "NO")
  ) %>% 
  mutate_if(is.character, as.factor) %>% 
  dplyr::select(target, sex, fbs, exang, cp, restecg, slope, ca, thal, everything())

#Using GGPLOT for analysis

#Analysis and correlational study
#========================================================

# Bar plot for target (Heart disease) 
ggplot(data2, aes(x=data2$target, fill=data2$target)) + 
  geom_bar() +
  xlab("Heart Disease") +
  ylab("Count") +
  ggtitle("Analysis of Presence and Absence of Heart Disease") +
  scale_fill_discrete(name = "Heart Disease", labels = c("Absence", "Presence"))



# Counting the frequency of the values of the age


data2 %>% 
  group_by(age) %>% 
  count() %>% 
  filter(n > 10) %>% 
  ggplot()+
  geom_col(aes(age, n), fill = "navyblue")+
  ggtitle("Age Analysis") +
  xlab("Age")  +
  ylab("AgeCount")




#Segmenting Chest Pain type

ggplot(data2, aes(cp, fill = target))+
  geom_bar(position = "fill")+
  ggtitle("cp")


#Distribution of Male and Female population across Age parameter
data2 %>%
  ggplot(aes(x=age,fill=sex))+
  geom_histogram()+
  xlab("Age") + 
  ylab("Number")+
  guides(fill = guide_legend(title = "Gender"))


# Representation of Cholesterol level 

data2 %>%
  ggplot(aes(x=age,y=chol,color=sex, size=chol))+
  geom_point(alpha=0.7)+xlab("Age") +
  ylab("Cholestoral")+
  guides(fill = guide_legend(title = "Gender"))



# Comparison of Blood pressure across pain type 
data2 %>%
  ggplot(aes(x=sex,y=trestbps))+
  geom_boxplot(fill="darkorange")+
  xlab("Sex")+
  ylab("BP")+
  facet_grid(~cp)



# Comparison of Cholesterol across pain type 
data2 %>%
  ggplot(aes(x=sex,y=chol))+
  geom_boxplot(fill="#D55E00")+
  xlab("Sex")+
  ylab("Chol")+
  facet_grid(~cp)


# Comparison of Cholesterol across pain type 
data2 %>%
  ggplot(aes(x=sex,y=chol))+
  geom_boxplot(fill="#D55E00")+
  xlab("Sex")+
  ylab("Chol")+
  facet_grid(~cp)

#Preparing Data for Logistic Regression
#Separating the data into a train set and a test set for LR

head(data,10)
library(caTools)
set.seed(123)
sample=sample.split(data$target,SplitRatio=0.80)
train_set=subset(data,sample==TRUE)
test_set=subset(data,sample==FALSE)





#Applying Logistic Regression Model

#glm() is the function that tells R to run a generalized linear model. Inside the parentheses we give R important information about the model.

model=glm(target~.,train_set,family=binomial())
summary(model)


#Prediction
#Predict is a generic function with, at present, a single method for "lm" objects, Predict. lm , which is a modification of the standard predict.

pred=predict(model,test_set,type="response")

predNew=as.data.frame(pred)

categorise=function(x){
  return(ifelse(x>0.5,1,0))
}

predNew=apply(predNew,2,categorise)
head(predNew,10)


#Summary
#Binding the prediction in the final dataset.

final_data=cbind(test_set,predNew)
head(final_data,10)
