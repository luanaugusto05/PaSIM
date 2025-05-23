#$______________________________________________________________________________
#Importing the libraries

library(curl)
library(rvest)
library(stringr)
library(foreign)
library(dplyr)
library(zip)

#$______________________________________________________________________________

dic <- c("CADMUN","CID10","TABUF","TABPAIS")

for (i in dic) {
  temp <- tempfile(fileext = ".DBF")
  download.file(paste0("ftp://ftp.datasus.gov.br/dissemin/publicos/SIM/CID10/TABELAS/",i,".DBF"),
                destfile = temp, mode = "wb", method = "libcurl")
  data <- read.dbf(temp)
  assign(i,data)
}

temp <- tempfile(fileext = ".zip")
download.file("https://www.gov.br/trabalho-e-emprego/pt-br/assuntos/cbo/servicos/downloads/estrutura-cbo.zip",destfile = temp)
temp_dir <- tempdir()
unzip(temp,files = c("CBO2002 - Ocupacao.csv"),exdir = temp_dir)
ocup <- read.csv2(paste0(temp_dir,"\\CBO2002 - Ocupacao.csv"))
ocup$TITULO <- iconv(ocup$TITULO, from = "latin1", to = "UTF-8")

CADMUN <- data.frame(lapply(CADMUN, function(x) if (is.factor(x)) as.character(x) else x))

TABUF <- data.frame(lapply(TABUF, function(x) if (is.factor(x)) as.character(x) else x))

CADMUN$MUNCOD <- as.integer(CADMUN$MUNCOD)

TABUF$CODIGO <- as.integer(TABUF$CODIGO)

usethis::use_data(CID10,ocup, overwrite = T)

usethis::use_data(CADMUN,TABUF, TABPAIS, overwrite = T)

usethis::use_data(CID, overwrite = T)
