#==================== import libraries ====================

# import libraries --- basic toolbox
suppressWarnings(suppressMessages(library(tidyverse)))
suppressWarnings(suppressMessages(library(tableone)))
suppressWarnings(suppressMessages(library(labelled)))
suppressWarnings(suppressMessages(library(scales)))

# import libraries --- statistical analysis
suppressWarnings(suppressMessages(library(gee)))

# import libraries --- plot & display
suppressWarnings(suppressMessages(library(gridExtra)))

# source the required function for analysis
source("./codesnippet_r/f.glm.diag.R")

#==================== import raw data ====================
dat_raw = read_csv("./data/project-2018.csv")
colnames(dat_raw)[2] = "trt"

#==================== create labeled data for descriptive analysis ====================
# initialization
df = dat_raw

# specify the variables that will be converted to factors
catvars = c("trt", "gender", "visit1", "visit2", "visit3", "visit4")
df[catvars] = lapply(df[catvars], factor)

# set levels
df$gender = plyr::mapvalues(df$gender, from = c('0', '1'), to = c("Male",    "Female"))
df$trt    = plyr::mapvalues(df$trt,    from = c('0', '1'), to = c("Placebo", "Active"))
df$visit1 = plyr::mapvalues(df$visit1, from = c('0', '1'), to = c("good",    "bad"))
df$visit2 = plyr::mapvalues(df$visit2, from = c('0', '1'), to = c("good",    "bad"))
df$visit3 = plyr::mapvalues(df$visit3, from = c('0', '1'), to = c("good",    "bad")) 
df$visit4 = plyr::mapvalues(df$visit4, from = c('0', '1'), to = c("good",    "bad")) 

# set labels
var_label(df$age)    <- "Age"
var_label(df$gender) <- "Gender"
var_label(df$trt)    <- "Treatment"

# store the results
dat_lab = df

#==================== grouping raw observations based on visit one and visit four ====================
# initialization
df = dat_raw

# group for visit one
df = df %>% 
    group_by(trt, age, gender) %>% 
    summarize(y = sum(visit1), n = n()) %>% 
    as.data.frame 

# map values and set levels
df$gender = plyr::mapvalues(df$gender, from = c('0', '1'), to = c("Male",    "Female"))
df$trt    = plyr::mapvalues(df$trt,    from = c('0', '1'), to = c("Placebo", "Active"))

df$gender = as.factor(df$gender)
df$trt    = as.factor(df$trt)
df$gender = relevel(df$gender, ref = "Male")
df$trt    = relevel(df$trt,    ref = "Placebo")

# store the results
dat_v1 = df

# group for visit four
df = dat_raw %>% 
    group_by(trt, age, gender) %>% 
    summarize(y = sum(visit4), n = n()) %>% 
    as.data.frame 

# map values and set levels
df$gender = plyr::mapvalues(df$gender, from = c('0', '1'), to = c("Male",    "Female"))
df$trt    = plyr::mapvalues(df$trt,    from = c('0', '1'), to = c("Placebo", "Active"))

df$gender = as.factor(df$gender)
df$trt    = as.factor(df$trt)
df$gender = relevel(df$gender, ref = "Male")
df$trt    = relevel(df$trt,    ref = "Placebo")

# store the results
dat_v4 = df

#==================== create long data format for analysis 03 ====================
dat_clust = dat_raw %>% gather(visit, value, -patient, -trt, -gender, -age)
dat_clust$patient = as.character(dat_clust$patient)
dat_clust$visit   = str_replace(string = dat_clust$visit, pattern = "visit", replacement = "")

# for plotting convenience, create long data format for labeled data
dat_clust_lab = dat_lab %>% gather(visit, value, -patient, -trt, -gender, -age)
