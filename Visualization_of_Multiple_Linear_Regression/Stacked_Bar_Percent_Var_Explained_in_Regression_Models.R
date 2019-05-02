#load libraries
library(ggplot2)

#set working directory
setwd("~/Dropbox/Muehlbauer_lab/NSGC GWAS/Final Multiple Linear Regression/")

#read in data from multiple linear regression analyses 
data <- read.table("All_Lines_MLR_Percent_Var_Expl_for_stacked_bar_2014_and_2015- Seeds per Spike.txt",header=TRUE,sep="\t")

data$Response_Variable <- as.character(data$Response_Variable)

data$Response_Variable[data$Response_Variable=="Prod All"] <- "Productive Tiller Number"
data$Response_Variable[data$Response_Variable=="Max All"] <- "Maximum Tiller Number"

data$Response_Variable <- factor(data$Response_Variable,levels=c("Productive Tiller Number","Maximum Tiller Number"))

data$Response_Variable_Year <- paste(data$Response_Variable,data$Year,sep=" ")

Sum <- aggregate(Percent_Var_Exp~Response_Variable_Year,data,sum)

names(Sum) <- c("Response_Variable_Year","Sum_Var_Exp")

data <- merge(data,Sum,by="Response_Variable_Year")

data$Predictor_Variable <- factor(data$Predictor_Variable,levels=c("Seeds Per Spike","Stem Diameter","Leaf Width","Heading","Plant Height"))

tiff("All_Lines_Percent_Var_Exp_Stacked_Bar_2014_and_2015_Seeds_Per_Spike.tiff",width=8,height=2.2,units="in",res=600)
ggplot(data, aes(x=Response_Variable,y=Percent_Var_Exp,fill=Predictor_Variable)) + geom_bar(stat="identity") + facet_grid(Year~.) + ylim(0,50) + coord_flip() + ylab("Percent Variance Explained") + xlab("Response Variable\n") + scale_fill_manual(values=c("darkslateblue","darkorange3","forestgreen","deepskyblue4","gray40"),name="Predictor Variable") + geom_text(aes(label=(Percent_Var_Exp),color=as.factor(Sign)),fontface="bold",position=position_stack(vjust=0.5),size=2.5) + theme_minimal() + geom_text(aes(label=Sum_Var_Exp,y=Sum_Var_Exp+3),size=3.5,fontface="bold") + theme(legend.title=element_text(size=12),legend.text=element_text(size=9),axis.text.x = element_text(color="black"),axis.text.y=element_text(color="black",size=12),axis.title.y = element_text(size=14)) + scale_color_manual(values=c("yellow","white"),guide=FALSE)+ theme(strip.text.x = element_text(color="black",size=10), strip.text.y = element_text(color="black"), strip.background = element_rect(colour="gray40", fill="gray90"))
dev.off()

pdf("All_Lines_Percent_Var_Exp_Stacked_Bar_2015_Seeds_Per_Spike_2.pdf",width=10,height=2)
ggplot(data[data$Year==2015,], aes(x=Response_Variable,y=Percent_Var_Exp,fill=Predictor_Variable)) + geom_bar(stat="identity") + ylim(0,45) + coord_flip() + ylab("Percent Variance Explained") + xlab("Response\n Variable\n") + scale_fill_manual(values=c("black","chocolate1","brown3","gray40","burlywood4"),name="Predictor Variable:") + geom_text(aes(label=(Percent_Var_Exp),color=as.factor(Sign)),fontface="bold",position=position_stack(vjust=0.5),size=3) + theme_minimal() + geom_text(aes(label=Sum_Var_Exp,y=Sum_Var_Exp+2),size=3.5,fontface="bold") + theme(legend.title=element_text(size=12),legend.text=element_text(size=10),axis.text.x = element_text(color="black"),axis.text.y=element_text(color="black",size=12),axis.title.y = element_text(size=14)) + scale_color_manual(values=c("yellow","white"),guide=FALSE)+ theme(strip.text.x = element_text(color="black",size=10), strip.text.y = element_text(color="black"), strip.background = element_rect(colour="gray40", fill="gray90"),legend.position = "bottom")
dev.off()
