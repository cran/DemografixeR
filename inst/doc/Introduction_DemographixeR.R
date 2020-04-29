## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----plot_names, echo=FALSE, cache=FALSE--------------------------------------
cust_names <- c("Maria", "Ben", "Claudia", "Adam", "Hannah", "Robert")
cust_names_df <- data.frame(matrix(cust_names,
                                   nrow = 1,
                                   ncol = 6,
                                   byrow = TRUE), stringsAsFactors = FALSE)

row.names(cust_names_df) <- "**Customers:**"
knitr::kable(cust_names_df, col.names = NULL)

## ----package structure, echo=FALSE, cache=FALSE-------------------------------
structure_df <- data.frame(
  API = c("https://genderize.io","https://agify.io","https://nationalize.io"),
  `R function` = c("`genderize(name)`", "`agify(name)`", "`nationalize(name)`"),
  `Estimated variable` = c("Gender", "Age", "Nationality"), stringsAsFactors = FALSE)

colnames(structure_df) <- gsub("\\.", " ", colnames(structure_df))

knitr::kable(structure_df, row.names = FALSE)


## ----result, echo=FALSE, cache=FALSE------------------------------------------
library("DemografixeR")
cust_names<-c("Maria", "Ben", "Claudia", "Adam", "Hannah", "Robert")
r1 <- genderize(cust_names)
r2 <- agify(cust_names)
r3 <- nationalize(cust_names)

res_df <- rbind(
                data.frame(t(matrix(cust_names)), stringsAsFactors = FALSE),
                data.frame(t(matrix(r1)), stringsAsFactors = FALSE),
                data.frame(t(matrix(r2)), stringsAsFactors = FALSE),
                data.frame(t(matrix(r3)), stringsAsFactors = FALSE))

row.names(res_df) <- c("**Customers:**",
                       "**Estimated gender:**",
                       "**Estimated age:**",
                       "**Estimated nationality:**")

knitr::kable(res_df, col.names = NULL)


## ----setup, cache=FALSE-------------------------------------------------------
library("DemografixeR")


## ----save API function, eval=FALSE--------------------------------------------
#  save_api_key(key = "__YOUR_API_KEY__")
#  

## ----genderize, eval=TRUE, echo=TRUE, cache=FALSE-----------------------------
customers_names <- c("Maria", "Ben", "Claudia", 
                     "Adam", "Hannah", "Robert")
customers_predicted_gender <- genderize(name = customers_names)
customers_predicted_gender # Print results


## ----genderize_class, cache=FALSE---------------------------------------------
class(customers_predicted_gender)


## ----genderize_dataframe, cache=FALSE-----------------------------------------
gender_df <- genderize(name = customers_names, simplify = FALSE)
customers_names %>% 
  genderize(simplify = FALSE) %>% 
  knitr::kable(row.names = FALSE)


## ----agify, cache=FALSE-------------------------------------------------------
customers_predicted_age <- agify(name = customers_names)
customers_predicted_age

customers_names %>% 
  agify(simplify = FALSE) %>% 
  knitr::kable(row.names = FALSE)


## ----nationality, cache=FALSE-------------------------------------------------
customers_predicted_nationality <- nationalize(name = customers_names)
customers_predicted_nationality

customers_names %>% 
  nationalize(simplify = FALSE) %>% 
  knitr::kable(row.names = FALSE)


## ----country_id, cache=FALSE--------------------------------------------------
us_customers_predicted_gender<-genderize(name = customers_names, 
                                         country_id = "US")
us_customers_predicted_gender

us_customers_predicted_age<-agify(name = customers_names,
                                  country_id = "US")
us_customers_predicted_age


## ----supported_countries, cache=FALSE-----------------------------------------
supported_countries(type = "genderize") %>% 
  head(5) %>% 
  knitr::kable(row.names = FALSE)


## ----country_id_multi, cache=FALSE--------------------------------------------
agify(name = c("Hannah", "Ben"),
      country_id = c("US", "GB"),
      simplify = FALSE) %>% 
  knitr::kable(row.names = FALSE)


## ----meta_parameter, cache=FALSE----------------------------------------------
genderize(name = "Hannah", 
          simplify = FALSE, 
          meta = TRUE) %>% 
  knitr::kable(row.names = FALSE)


## ----sliced_false, cache=FALSE------------------------------------------------
nationalize(name = "Matthias", 
            simplify = FALSE, 
            sliced=FALSE) %>% 
  knitr::kable(row.names = FALSE)


## ----customers_end, echo=TRUE, cache=FALSE------------------------------------
library(dplyr, quietly = TRUE, warn.conflicts = FALSE)

df<-data.frame("Customers:"=c("Maria", "Ben", "Claudia",
                           "Adam", "Hannah", "Robert"), 
               stringsAsFactors = FALSE,
               check.names = FALSE)

df <- df %>% mutate(`Estimated gender:`= genderize(`Customers:`),
                    `Estimated age:`= agify(`Customers:`),
                    `Estimated nationality:`= nationalize(`Customers:`))

df %>% t() %>% knitr::kable(col.names = NULL)


