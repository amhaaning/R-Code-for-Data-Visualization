library(VennDiagram)

setwd("~/Dropbox/Muehlbauer_lab/Final_GAPIT_Results_from_MSI/Final_GWAS_Results_Compressed_with_Model_Selection/")

QTL_All <- read.delim("QTL_for_Venn_Diagram.txt", header=TRUE,sep="\t",check.names=FALSE)

#Row Type QTL
Row_Type <- QTL_All[QTL_All$Year=="All",]

#List of all QTL detected in 2014
All_2014 <- QTL_All[QTL_All$Year=="2014",]
All_2014 <- rbind(All_2014,Row_Type)

#List of all QTL detected in 2015
All_2015 <- QTL_All[QTL_All$Year=="2015",]
All_2015 <- rbind(All_2015,Row_Type)

#List of 2014 tillering QTL
Tillering_2014 <- unique(as.character(All_2014[All_2014$Category=="Tillering",][[3]]))
#List of 2014 days to heading QTL
Heading_2014 <- unique(as.character(All_2014[All_2014$Category=="Heading",][[3]]))
#List of 2014 inflorescence QTL
Row_Type_2014 <- unique(as.character(All_2014[All_2014$Category=="Row Type",][[3]]))
#List of 2015 tillering QTL
Tillering_2015 <- unique(as.character(All_2015[All_2015$Category=="Tillering",][[3]]))
#List of 2015 days to heading QTL
Heading_2015 <- unique(as.character(All_2015[All_2015$Category=="Heading",][[3]]))
Row_Type_2015 <- unique(as.character(All_2015[All_2015$Category=="Row Type",][[3]]))

a <- list("Tillering"=Tillering_2014,"Heading"=Heading_2014,"Row Type"=Row_Type_2014)

overlap_a <- calculate.overlap(a)

#3 comparisons - tillering QTL in 2014 and 2015 vs. days to heading in 2014 and 2015 vs. spike row number
venn.diagram(a, filename ="Tillering_Heading_Inf_QTL_2014_Venn.tiff", height = 3000, width = 3000,col = "gray",fill = c("forestgreen", "deepskyblue4","darkslateblue"),alpha = 0.4,cex = 2.5,fontface = "bold",cat.cex=c(2,2,2),cat.pos=0,cat.dist=-0.1,fontfamily=("sans"),cat.fontfamily=("sans"),main.fontfamily=("sans"),cat.just=list(c(1.2,0.5),c(-0.2,0.5),c(0.5,10.5)))

b <- list("Tillering"=Tillering_2015,"Heading"=Heading_2015,"Row Type"=Row_Type_2015)

overlap_b <- calculate.overlap(b)

#3 comparisons - tillering QTL in 2014 and 2015 vs. days to heading in 2014 and 2015 vs. spike row number
venn.diagram(b, filename ="Tillering_Heading_Inf_QTL_2015_Venn.tiff", height = 3000, width = 3000,col = "gray",fill = c("forestgreen", "deepskyblue4","darkslateblue"),alpha = 0.4,cex = 2.5,fontface = "bold",cat.cex=c(2,2,2),cat.pos=0,cat.dist=-0.1,fontfamily=("sans"),cat.fontfamily=("sans"),main.fontfamily=("sans"),cat.just=list(c(1.2,0.5),c(-0.2,0.5),c(0.5,10.5)))



