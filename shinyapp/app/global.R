library(shiny)
library(modules)
library(config)
library(sass)
library(leaflet)
library(anytime)
library(dplyr)
library(shinyjs)
library(httr)
library(glue)
library(lubridate)
library(DT)
library(reactable)
library(plotly)

source("utils.R")

#consts <- config::get(file = "constants.yml")

data <- load_thrash_data("data/data_with_cluster_uuids.csv")

data_cluster <- load_thrash_data("data/cluster_data.csv")
data_cluster$latlon <- paste(round(data_cluster$center_lat*10000)/10000,
                             round(data_cluster$center_lon*10000)/10000, sep="_")


mock_data_people <- data.frame(
  Imie = c("Janusz", "Dorota", "Paweł", "Magda", "Ariel", "Ala", "Zosia"),
  Nazwisko = c("Ikniśnki", "Ekologiczna", "Porządny", "Sprzątalska", "Czyścielski", "Świadoma", "Pomocna"),
  Punkty = c(52, 44, 20, 10, 8, 8, 5),
  `Sprzątany region` = c("Gdańsk", "Warszawa", "Różne", "Polska", "Gdańsk", "Sopot", "USA"),
  Foto = c('images/faceicon1.png',
           'images/faceicon3.png',
           'images/faceicon2.png',
           'images/faceicon4.png',
           'images/faceicon1.png',
           'images/faceicon4.png',
           'images/faceicon3.png')
)

mock_data_companies <- read.csv("data/companies.csv")
