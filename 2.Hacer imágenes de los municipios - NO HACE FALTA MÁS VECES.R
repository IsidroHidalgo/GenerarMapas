rm(list = ls(all.names = TRUE))

library(openxlsx)
library(sp)

# Cargamos los mapas:
load("mapas.Rdata")
municipios <- readRDS("Capas/ESP_adm4.rds")

# variables:
lineaProvincia <- 3
lineaMunicipio <- 15
colorProvincia <- "grey"
alto <- 2000
ancho <- 2340


excelfile <- read.xlsx("PARO.xlsx", sheet = "parámetros")
parametros <- excelfile[1:8303, 1:4]

mapaprov <- list(provAB, provCR, provCU, provGU, provTO)
names(mapaprov) <- c("Albacete", "Ciudad Real", "Cuenca", "Guadalajara", "Toledo")


for (i in 1625:2548){
  png(filename= paste0("Imágenes de los municipios/", parametros$provincia[i], "/", parametros$munine[i],".png"),
      width = ancho, height = alto,
      bg= "transparent", units= "px", type = "cairo")
  plot(mapaprov[[parametros$provincia[i]]], lwd= lineaProvincia,
       mar=c(0, 0, 0, 0),
       oma=c(0, 0, 0, 0),
       xaxs='i', yaxs='i', border = colorProvincia)
  plot(municipios[i,], border= "red", lwd= lineaMunicipio, add= TRUE)
  dev.off()
}

# Villaverde de Guadalimar (registros 1698 y 1711)
png(filename= "Imágenes de los municipios/Albacete/2084.png",
    width = ancho, height = alto,
    bg= "transparent", units= "px", type = "cairo")
plot(provAB, lwd= lineaProvincia,
     mar=c(0, 0, 0, 0),
     oma=c(0, 0, 0, 0),
     xaxs='i', yaxs='i', border = colorProvincia)
plot(municipios[1698,], border= "red", lwd= lineaMunicipio, add= TRUE)
plot(municipios[1711,], border= "red", lwd= lineaMunicipio, add= TRUE)
dev.off()

# Albalate de Zorita (registros 2200 y 2215)
png(filename= "Imágenes de los municipios/Guadalajara/19006.png",
    width = ancho, height = alto,
    bg= "transparent", units= "px", type = "cairo")
plot(provGU, lwd= lineaProvincia,
     mar=c(0, 0, 0, 0),
     oma=c(0, 0, 0, 0),
     xaxs='i', yaxs='i', border = colorProvincia)
plot(municipios[2200,], border= "red", lwd= lineaMunicipio, add= TRUE)
plot(municipios[2215,], border= "red", lwd= lineaMunicipio, add= TRUE)
dev.off()

