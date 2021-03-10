# -----------------------------------------------------------------------------
# (c) Observatorio del Mercado de Trabajo. Junta de Comunidades de Castilla-La Mancha
# (c) Isidro Hidalgo Arellano (ihidalgo@jccm.es)
# -----------------------------------------------------------------------------

# Borramos los objetos en memoria
rm(list = ls(all.names = TRUE))

# Cargamos las librerías necesarias
library(sp)
library(raster)

# Cargamos las tablas necesarias
load("Z:\\Mapas\\ParaHacerMapas\\Tablas\\shpINE.Rdata")

ccaa <- readRDS("Capas/ESP_adm1.rds")
ccaaCLM <- subset(ccaa, ccaa@data$NAME_1 %in% c("Castilla-La Mancha"))

provincias <- readRDS("Capas/ESP_adm2.rds")
provCLM <- subset(provincias, provincias@data$NAME_1 %in% c("Castilla-La Mancha"))

municipios <- readRDS("Capas/ESP_adm4.rds")
muniCLM <- subset(municipios, municipios@data$NAME_1 %in% c("Castilla-La Mancha"))
data.frame.muniCLM <- merge(muniCLM@data, shpINE, by.x = "OBJECTID", by.y = "id")
muniCLM@data <- data.frame.muniCLM
ofiCLM <- aggregate(muniCLM, by = list(muniCLM@data$grupoficina), FUN = mean)
ofiCLM@data[,2:28] = NULL
ofiCLM@data$grupoficina = ofiCLM@data$Group.1
ofiCLM@data$Group.1 = NULL

provAB <- subset(provincias, provincias@data$NAME_2 %in% c("Albacete"))
muniAB <- subset(muniCLM, muniCLM@data$NAME_2 %in% c("Albacete"))

provCR <- subset(provincias, provincias@data$NAME_2 %in% c("Ciudad Real"))
muniCR <- subset(muniCLM, muniCLM@data$NAME_2 %in% c("Ciudad Real"))

provCU <- subset(provincias, provincias@data$NAME_2 %in% c("Cuenca"))
muniCU <- subset(muniCLM, muniCLM@data$NAME_2 %in% c("Cuenca"))

provGU <- subset(provincias, provincias@data$NAME_2 %in% c("Guadalajara"))
muniGU <- subset(muniCLM, muniCLM@data$NAME_2 %in% c("Guadalajara"))

provTO <- subset(provincias, provincias@data$NAME_2 %in% c("Toledo"))
muniTO <- subset(muniCLM, muniCLM@data$NAME_2 %in% c("Toledo"))

rm(provincias, ccaa, municipios, data.frame.muniCLM, shpINE)
save(list = ls(), file = "mapas.Rdata")
