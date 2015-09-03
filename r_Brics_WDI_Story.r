# PT
# Faz o download dos dados do indicador GDP (PIB) dos países do BRICs,
# contidos no site do banco Mundial e apresenta em um gráfico contando a história da evolução.
#
# EN
# Download data from world bank. This data contain GDP indicators.
# We use this indicators on Motion Chart (GoogleVis)
#

library(WDI)
library(googleVis)

GDP<-WDI(indicator=c("NY.GDP.MKTP.CD" ), country=c("BR","RU","CN", "IN", "ZA"), start=2009, end=2015);

colnames(GDP)[2] <- "pais";
colnames(GDP)[3] <- "gdp";
colnames(GDP)[4] <- "ano";

Motion=gvisMotionChart(GDP, 
                       idvar="pais", 
                       timevar="ano")
plot(Motion)
