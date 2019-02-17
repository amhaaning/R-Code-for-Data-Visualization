setwd("~/Dropbox/Muehlbauer_lab/Final_GAPIT_Results_from_MSI/Final_GWAS_Results_Compressed_with_Model_Selection/")

#required libraries
library(ggplot2)
library(RColorBrewer)
library(cowplot)
library(plyr)
library(dplyr)
library(gridExtra)
library(grid)
library(scales)

trait <- read.delim(file="./All_Sig_SNPs_Compressed_with_Model_Selection_for_Figure.txt",sep="\t",header=TRUE,check.names = FALSE)

mycolors <- c("deepskyblue4","darkslateblue","forestgreen")

trait$Category <- factor(trait$Broad_Category, levels=c("Tillering","Heading","Row Type"))

trait$Year <- factor(trait$Year, levels=c("2015","2014"))

names(mycolors) <- levels(trait$Broad_Category)

trait$Year_Lines <- factor(trait$Year_Lines, levels=c("2014 All","2014 2-Row","2014 6-Row","2014 Ppd-H1","2014 ppd-H1","All","2015 All","2015 2-Row","2015 6-Row","2015 Ppd-H1","2015 ppd-H1"))

#facet_grid(Chr + SNP_Set ~.) splits data into separate plots by two variables, chromosome and the genotyping platform. Switching to facet_grid(~. Chr + SNP_Set) would flip the margins of the plot, making the plots vertical instead of horizontal.Data can also be split on one variable. Cowplot package has lots of options for plot formatting and layout.
plot <- ggplot(data=trait,aes(x=Interval_Start,xend=Interval_Stop,y=Broad_Category,yend=Broad_Category,color=Broad_Category)) + 
  theme_bw() +
  geom_segment(size=3) + 
  theme(legend.position="none")  + 
  labs(x="Popseq cM") + 
  theme(axis.title.y=element_blank()) + 
  theme(strip.text.y = element_text(angle = 180,size=5, color="black",face="bold")) + 
  theme(panel.spacing=unit(0.1,"lines")) + 
  theme(axis.text.y=element_text(size=6,color="black",face = "bold",angle=180)) +
  theme(axis.text.x = element_text(angle=90, hjust=1,vjust=0.5, size=7,color="black",face="bold")) + 
  theme(axis.title.x=element_text(size=8)) + 
  theme(plot.margin = unit(c(0,0,0,0), "cm"))  + 
  facet_grid(Year ~ ., scale="free_y",space = "free") +
  panel_border() + 
  background_grid() + 
  ggtitle("All Traits QTL Comparison") + 
  theme(plot.margin=unit(c(1,1,1,1),"cm")) +
  theme(panel.grid.major.y=element_line(color="gray90")) +
  theme(panel.grid.major.x=element_line(color="gray60",size=0.4)) +
  theme(panel.grid.minor.x=element_line(color="gray70",size=0.2)) + scale_x_continuous(limits=c(0,152),breaks = pretty_breaks(n=10)) +
  theme(plot.title=element_text(size=8,hjust=0.5)) + 
  scale_color_manual(values=mycolors,drop=FALSE) + 
  theme(axis.ticks=element_blank()) +
  theme(strip.background = element_rect(fill="gray95",color="gray60")) 

plots = trait %>% 
  group_by(Chromosome) %>%
  do(plots=plot %+% .+ ggtitle(paste("Chromosome",unique(.$Chromosome), sep=" ")))

tiff(file="Tillering_QTL_and_Overlapping_Intervals_Chr01_simple.tif",units="in",width=4,height=1.6,res=600)
plots$plots[1]
dev.off()

tiff(file="Tillering_QTL_and_Overlapping_Intervals_Chr02_simple.tif",units="in", width=4.07,height=1.9,res=600)
plots$plots[2]
dev.off()

tiff(file="Tillering_QTL_and_Overlapping_Intervals_Chr03_simple.tif",units="in", width=4.07,height=1.9,res=600)
plots$plots[3]
dev.off()

tiff(file="Tillering_QTL_and_Overlapping_Intervals_Chr04_simple.tif",units="in", width=4.07,height=1.8,res=600)
plots$plots[4]
dev.off()

tiff(file="Tillering_QTL_and_Overlapping_Intervals_Chr05_simple.tif",units="in", width=4.07,height=1.78,res=600)
plots$plots[5]
dev.off()

tiff(file="Tillering_QTL_and_Overlapping_Intervals_Chr06_simple.tif",units="in", width=4,height=1.475,res=600)
plots$plots[6]
dev.off()

tiff(file="Tillering_QTL_and_Overlapping_Intervals_Chr07_simple.tif",units="in", width=4,height=1.8,res=600)
plots$plots[7]
dev.off()

