# -----------------------------------------------------------------------------
# (c) Observatorio del Mercado de Trabajo. Junta de Comunidades de Castilla-La Mancha
# (c) Isidro Hidalgo Arellano (ihidalgo@jccm.es)
# -----------------------------------------------------------------------------

# Borramos los objetos en memoria
rm(list = ls(all.names = TRUE))

# Cargamos librerías
library(openxlsx)
library(cartography)
library(sp)

# Variables:
lineaCCAA <- 5
lineaProvincia <- 3
colorProvincia <- "grey"
alto <- 2000
ancho <- 2340

# Cargamos los mapas guardados con el proceso "1.Preparación del espacio de trabajo"
load("mapas.Rdata")

# Cargamos los datos del mes
excelfile <- read.xlsx("PARO.xlsx", sheet = "parámetros")
parametros <- excelfile[1:8303, 1:4]

muniCLM@data$colores = parametros$colores[1625:2548]
muniCLM@data$pob1664 = parametros$pob1664[1625:2548] ^.5

# Quitamos los recintos repetidos, dejando el que tiene el núcleo de población:
muniCLM@data$pob1664[74] = 0 # Villaverde de Guadalimar (1698 - 1711): 74 - 87
muniCLM@data$pob1664[235] = 0 # Cuenca (1859 - 1889): 235 - 265
muniCLM@data$pob1664[206] = 0 # Huete (1830 - 1969): 206 - 345
muniCLM@data$pob1664[576] = 0 # Albalate de Zorita (2200 - 2215): 576 - 591
muniCLM@data$pob1664[630] = 0 # Torrejón del Rey (2254 - 2344): 630 - 720

# Preparamos los datos de los shp provinciales
muniAB@data$colores = parametros$colores[1625:1712]
muniAB@data$pob1664 = parametros$pob1664[1625:1712] ^.55

muniCR@data$colores = parametros$colores[1713:1814]
muniCR@data$pob1664 = parametros$pob1664[1713:1814] ^.55

muniCU@data$colores = parametros$colores[1815:2054]
muniCU@data$pob1664 = parametros$pob1664[1815:2054] ^.55

muniGU@data$colores = parametros$colores[2055:2344]
muniGU@data$pob1664 = parametros$pob1664[2055:2344] ^.55

muniTO@data$colores = parametros$colores[2345:2548]
muniTO@data$pob1664 = parametros$pob1664[2345:2548] ^.52

# Quitamos los recintos repetidos de las provincias, dejando el que tiene el núcleo de población:
muniAB@data$pob1664[74] = 0
muniCU@data$pob1664[16] = 0
muniCU@data$pob1664[45] = 0
muniGU@data$pob1664[146] = 0
muniGU@data$pob1664[200] = 0

# Fijamos la paleta de colores de los porcentajes de paro
paleta =c(rgb(.7,.9,1,1),
          rgb(.6,.8,1,1),
          rgb(.4,.6,1,1),
          rgb(0,.2,1,1),
          rgb(0,0,0,1),
          rgb(1,1,1,1))

png(filename = "Imágenes del mes/CLM.png", width = 2290, height = 2000,
    bg = "transparent", units = "px", type = "cairo")
plot(muniCLM, col = rgb(.95,.95,.95,1), border = rgb(.95,.95,.95,1),
     mar = c(0, 0, 0, 0),
     oma = c(0, 0, 0, 0),
     xaxs = 'i', yaxs = 'i')
plot(provCLM, lwd = lineaProvincia, border = colorProvincia, add = TRUE)
plot(ccaaCLM, lwd = lineaCCAA, border = colorProvincia, add = TRUE)
propSymbolsChoroLayer(spdf = muniCLM,
                      df = muniCLM@data,
                      var = "pob1664",
                      symbols = "circle",
                      var2 = "colores",
                      col = paleta,
                      border = "white",
                      fixmax = 100,
                      legend.var.pos = "n",
                      legend.var2.pos = "n")
dev.off()

png(filename = "Imágenes del mes/Albacete.png", width = ancho, height = alto,
    bg = "transparent", units = "px", type = "cairo")
plot(muniAB, col = rgb(.95,.95,.95,1), border = rgb(.95,.95,.95,1),
     mar = c(0, 0, 0, 0),
     oma = c(0, 0, 0, 0),
     xaxs = 'i', yaxs = 'i')
plot(provAB, lwd = lineaProvincia, border = colorProvincia, add = TRUE)
propSymbolsChoroLayer(spdf = muniAB,
                      df = muniAB@data,
                      var = "pob1664",
                      symbols = "circle",
                      var2 = "colores",
                      col = paleta,
                      border = "white",
                      fixmax = 30,
                      legend.var.pos = "n",
                      legend.var2.pos = "n")
dev.off()

png(filename = "Imágenes del mes/Ciudad Real.png", width = ancho, height = alto,
    bg = "transparent", units = "px", type = "cairo")
plot(muniCR, col = rgb(.95,.95,.95,1), border = rgb(.95,.95,.95,1),
     mar = c(0, 0, 0, 0),
     oma = c(0, 0, 0, 0),
     xaxs = 'i', yaxs = 'i')
plot(provCR, lwd = lineaProvincia, border = colorProvincia, add = TRUE)
propSymbolsChoroLayer(spdf = muniCR,
                      df = muniCR@data,
                      var = "pob1664",
                      symbols = "circle",
                      var2 = "colores",
                      col = paleta,
                      border = "white",
                      fixmax = 30,
                      legend.var.pos = "n",
                      legend.var2.pos = "n")
dev.off()

png(filename = "Imágenes del mes/Cuenca.png", width = ancho, height = alto,
    bg = "transparent", units = "px", type = "cairo")
plot(muniCU, col = rgb(.95,.95,.95,1), border = rgb(.95,.95,.95,1),
     mar = c(0, 0, 0, 0),
     oma = c(0, 0, 0, 0),
     xaxs = 'i', yaxs = 'i')
plot(provCU, lwd = lineaProvincia, border = colorProvincia, add = TRUE)
propSymbolsChoroLayer(spdf = muniCU,
                      df = muniCU@data,
                      var = "pob1664",
                      symbols = "circle",
                      var2 = "colores",
                      col = paleta,
                      border = "white",
                      fixmax = 30,
                      legend.var.pos = "n",
                      legend.var2.pos = "n")
dev.off()

png(filename = "Imágenes del mes/Guadalajara.png", width = ancho, height = alto,
    bg = "transparent", units = "px", type = "cairo")
plot(muniGU, col = rgb(.95,.95,.95,1), border = rgb(.95,.95,.95,1),
     mar = c(0, 0, 0, 0),
     oma = c(0, 0, 0, 0),
     xaxs = 'i', yaxs = 'i')
plot(provGU, lwd = lineaProvincia, border = colorProvincia, add = TRUE)
propSymbolsChoroLayer(spdf = muniGU,
                      df = muniGU@data,
                      var = "pob1664",
                      symbols = "circle",
                      var2 = "colores",
                      col = paleta,
                      border = "white",
                      fixmax = 30,
                      legend.var.pos = "n",
                      legend.var2.pos = "n")
dev.off()

png(filename = "Imágenes del mes/Toledo.png", width = ancho, height = alto,
    bg = "transparent", units = "px", type = "cairo")
plot(muniTO, col = rgb(.95,.95,.95,1), border = rgb(.95,.95,.95,1),
     mar = c(0, 0, 0, 0),
     oma = c(0, 0, 0, 0),
     xaxs = 'i', yaxs = 'i')
plot(provTO, lwd = lineaProvincia, border = colorProvincia, add = TRUE)
propSymbolsChoroLayer(spdf = muniTO,
                      df = muniTO@data,
                      var = "pob1664",
                      symbols = "circle",
                      var2 = "colores",
                      col = paleta,
                      border = "white",
                      fixmax = 30,
                      legend.var.pos = "n",
                      legend.var2.pos = "n")
dev.off()