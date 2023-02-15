#the ugliest plot my OCD can handle

install.packages("ggplot2")
install.packages("gganimate")
install.packages("jpeg")
install.packages("ggpubr")

library(ggpubr)
library(jpeg)
library(gganimate)
library(ggplot2)
library(ggimage)

data("USArrests")
head(USArrests)
names(USArrests)

url <- "https://unherd.com/wp-content/uploads/2022/02/2GettyImages-1186593831-scaled-1.jpg"
img <- jpeg::readJPEG("~/Downloads/deep_fried_meme.jpeg")


ugliest_plot <- ggplot(USArrests, aes(x = UrbanPop,
                         y = Murder), ) +
  background_image(img) +
  theme(plot.background = element_rect(fill = "#7ef6fc")) +
  geom_image(aes(image=url), 
             size=0.12) +
  geom_line(col="#FF5F1F", 
            linewidth=1.3) +
  labs(x="градско_население",
       y="убийство_на_100,000",
       title="Путь_Путина")+
  theme(axis.title.x = element_text(size = 25, 
                                    color = "#03fc28", 
                                    angle = 180, 
                                    face = 'bold', 
                                    hjust = 0.9), 
        axis.title.y = element_text(size = 30, 
                                    color = "#FF10F0", 
                                    face = 'bold', 
                                    hjust = 0.8), 
        axis.text = element_text(size = 30, 
                               color = "#8c592d", 
                               angle = 180, 
                               face = 'bold', 
                               hjust = 0.15)) +
  ggtitle("Путь_Путина") +
  theme(plot.title = element_text(hjust = 0.35, 
                                  size = 56, 
                                  color = "#FFFF00", 
                                  angle = 180, 
                                  face = 'bold')) 

