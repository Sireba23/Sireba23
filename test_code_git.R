


install.packages("lubridate")
install.packages("anytime")


library(usethis)
library(lubridate)
library(anytime)
library(readxl)
library(dplyr)


use_git_config(user.name="BA",user.email="sireba25@gmail.com")


#**************Les fichier à ignorer ************
#************************************************


usethis::edit_git_ignore(scope = "project")
.csv
.sas7bdat
.xls
.xlsx

#**** sauvegarder les fichiers sur le dépot local soit par le terminal soit par ***
#**** l'interface de rstudion .******


#********** Exemple de code **************************************


data<-read.table(file.choose(),header = TRUE, sep = ";")
str(data)
datta_es<-data

# cette ligne convertis la colonne Date en date ,le character convertis
# d'abort en character puis en as.Date convertis en date.
# Je définis ma porpre format.
#datta_es$DAY<-as.Date(as.character(datta_es$DAY),format="%Y%m%d")


datta_es$Day1 <- as.Date(sprintf("%08d", datta_es$DAY), format = "%Y%m%d")
datta_es$year <- format(datta_es$Day1, "%Y")
datta_es$year_month<- format(datta_es$Day1, "%Y_%m")
datta_es$month <- format(datta_es$Day1, "%m")

str(datta_es)


data_means <- datta_es %>%
  group_by(year_month) %>%
  summarize(
    RADIATION_mean = mean(RADIATION),
    TEMPERATURE_MIN_mean = mean(TEMPERATURE_MIN),
    TEMPERATURE_MAX_mean = mean(TEMPERATURE_MAX),
    TEMPERATURE_AVG_mean = mean(TEMPERATURE_AVG),
    PRECIPITATION_mean = mean(PRECIPITATION)
  )


data_year <- datta_es %>%
  group_by(year,GRID_NO) %>%
  summarize(
    RADIATION_mean = mean(RADIATION),
    TEMPERATURE_MIN_mean = mean(TEMPERATURE_MIN),
    TEMPERATURE_MAX_mean = mean(TEMPERATURE_MAX),
    TEMPERATURE_AVG_mean = mean(TEMPERATURE_AVG),
    PRECIPITATION_mean = mean(PRECIPITATION)
  )



annees <- 2015:2020

liste_bases_de_donnees <- list()

for (annee in annees) {
  # Filtrer les données pour l'année en cours
  donnees_annee <- filter(data_year, year == annee)
  
  # Ajouter la base de données à la liste
  liste_bases_de_donnees[[as.character(annee)]] <- donnees_annee
}



# Accéder aux bases de données individuelles par année
for (annee in annees) {
  nom_base_de_donnees <- as.character(annee)
  base_de_donnees <- liste_bases_de_donnees[[nom_base_de_donnees]]
  

    print(paste("Année:", nom_base_de_donnees))
  print(head(base_de_donnees))
}

base_de_donnees_2019 <- liste_bases_de_donnees[["2019"]]
head(base_de_donnees_2019)
View(base_de_donnees_2019)













