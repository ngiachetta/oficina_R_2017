#Manipulando o banco de dados do MoMA para que a oficina fique mais didática
#O Dataset a seguir foi extraido da seguinte fonte: https://github.com/MuseumofModernArt/collection

library(dplyr)
#Abrindo o banco 
MoMA <- read.csv("https://media.githubusercontent.com/media/MuseumofModernArt/collection/master/Artworks.csv", 
                 header = T, 
                 sep = ",",
                 stringsAsFactors = F)

#Excluindo variáveis que não serão usadas

MoMA$ArtistBio <- NULL
MoMA$Medium <- NULL
MoMA$Department <- NULL
MoMA$Dimensions <- NULL
MoMA$AccessionNumber <- NULL
MoMA$Cataloged <- NULL
MoMA$URL <- NULL
MoMA$ThumbnailURL <- NULL
MoMA$Depth..cm. <- NULL
MoMA$Length..cm. <- NULL
MoMA$Weight..kg. <- NULL
MoMA$Width..cm. <- NULL
MoMA$Seat.Height..cm. <- NULL
MoMA$Duration..sec.. <- NULL
MoMA$Circumference..cm. <- NULL
MoMA$Diameter..cm. <- NULL
MoMA$ObjectID <- NULL

#Retirando os parenteses de algumas variáveis
#Nationality, BeginDate, EndDate, Gender

retira_parenteses <- function(variavelMoMa){
  esquerda <- gsub("\\(","",variavelMoMa)
  direita <- gsub("\\)","",esquerda)
  colocandoNA<- gsub("^$|^ $",NA,direita)
  variavelMoMa <- colocandoNA
}

MoMA$Nationality <- retira_parenteses(MoMA$Nationality)
MoMA$BeginDate <- retira_parenteses(MoMA$BeginDate)
MoMA$EndDate <- retira_parenteses(MoMA$EndDate)
MoMA$Gender <- retira_parenteses(MoMA$Gender)


#Criando a variavel artist_age

MoMA <- MoMA %>% 
  mutate(artist_age = as.numeric(EndDate) - as.numeric(BeginDate))

#Removendo NA do data.frame

MoMA <- na.omit(MoMA)

#Formas para diminuir e embaralhar os dados

MoMA <- unique(MoMA)

n <- nrow(MoMA)
MoMA <- MoMA[sample(n),]

#Exportanto data.frame

write.csv2(x = MoMA, "MOMA_Oficina.csv", sep = ";")
