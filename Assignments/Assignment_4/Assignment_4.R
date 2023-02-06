
install.packages("ggplot2")
library(ggplot2)

install.packages("phytools")
install.packages("ape")
install.packages("caper")
install.packages("geiger")

library(phytools)
library(ape)
library(caper)
library(geiger)
library(tidyverse)

data1 <- read.csv("~/Downloads/Edited_GS_range_aves.csv")

tree1 <- read.tree("~/Downloads/play4_noOG_recent.tree")

gs <- data1$GS_ave
names(gs) <- data1$Species

name.check(tree1, gs)

tree1$tip.label

tree1$node.label <- NULL

bio_pgls_comp_data <- comparative.data(tree1, leucaena_data, Species, vcv = TRUE)

#BIO 1: Annual Mean Temperature

bio1 <- data1$Mean_Temp_Annual
names(bio1) <- data1$Species

ggplot(data=bio_pgls_comp_data$data, aes(x=log(bio1), y=log(gs)))+geom_point(size=2)+
  geom_smooth(method=lm, color="red", se=T)+xlab("log(Annual Mean Temperature)")+
  ylab("log(Genome Size (pg))")+
  theme_minimal()+theme(axis.title = element_text(size=13), axis.text=element_text(size=13))
