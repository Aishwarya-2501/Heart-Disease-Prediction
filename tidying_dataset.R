data <- read.csv("https://raw.githubusercontent.com/Aishwarya-2501/HeartDisease_DataSet/main/Heart_data.csv")
glimpse(data)
```

Data Preprocessing
========================================================
Showing dimension and checking for null and na values.
```{r}
dim(data)
cat('completely filled rows -> ', sum(complete.cases(data)))
list_na <- colnames(data)[ apply(data, 2, anyNA)]
cat('Columns with null values -> ', list_na)
cat('null values -> ', sum(is.na(data)))
cat('No Na Values')
```

Correcting the formating style of 1st column thats why renaming it.
```{r}
names(data)[1] <- paste("age")
```

========================================================
The mutate function is used to create a new variable from a data set. In order to use the function, we need to install the dplyr package.
To make the data more readable. I am renaming them into more understandable values.
Factors represent a very efficient way to store character values, because each unique character value is stored only once, and the data itself is stored as a vector of integers.
The function factor is used to encode a vector as a factor.
```{r}
data2 <- data %>% 
  mutate(sex = if_else(sex == 0, "MALE", "FEMALE"),
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

View(data2)