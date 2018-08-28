library(ggplot2)
economics <- as.data.frame(ggplot2::economics)
cor.test(economics$unemploy, economics$pce)

#Pearson's product-moment correlation

#data:  economics$unemploy and economics$pce
#t = 18.605, df = 572, p-value < 2.2e-16
#alternative hypothesis: true correlation is not equal to 0
#95 percent confidence interval:
#0.5603164 0.6625460
#sample estimates:
#cor 
#0.6139997 



####correlation matrix######
head(mtcars)

car_cor <- cor(mtcars)
round(car_cor, 2)
#mpg   cyl  disp    hp  drat    wt  qsec    vs    am  gear  carb
#mpg   1.00 -0.85 -0.85 -0.78  0.68 -0.87  0.42  0.66  0.60  0.48 -0.55
#cyl  -0.85  1.00  0.90  0.83 -0.70  0.78 -0.59 -0.81 -0.52 -0.49  0.53
#disp -0.85  0.90  1.00  0.79 -0.71  0.89 -0.43 -0.71 -0.59 -0.56  0.39
#hp   -0.78  0.83  0.79  1.00 -0.45  0.66 -0.71 -0.72 -0.24 -0.13  0.75
#drat  0.68 -0.70 -0.71 -0.45  1.00 -0.71  0.09  0.44  0.71  0.70 -0.09
#wt   -0.87  0.78  0.89  0.66 -0.71  1.00 -0.17 -0.55 -0.69 -0.58  0.43
#qsec  0.42 -0.59 -0.43 -0.71  0.09 -0.17  1.00  0.74 -0.23 -0.21 -0.66
#vs    0.66 -0.81 -0.71 -0.72  0.44 -0.55  0.74  1.00  0.17  0.21 -0.57
#am    0.60 -0.52 -0.59 -0.24  0.71 -0.69 -0.23  0.17  1.00  0.79  0.06
#gear  0.48 -0.49 -0.56 -0.13  0.70 -0.58 -0.21  0.21  0.79  1.00  0.27
#carb -0.55  0.53  0.39  0.75 -0.09  0.43 -0.66 -0.57  0.06  0.27  1.00


####heat map####
install.packages("corrplot")
library(corrplot)
corrplot(car_cor)

corrplot(car_cor, method = "number")

col <- colorRampPalette(c("#BB4444", "#EE9988", "#ffffff", "#77AADD", "#4477AA"))
corrplot(car_cor, 
         method = "color",
         col = col(200),
         type = "lower",
         order = "hclust",
         addCoef.col = "black",
         tl.col = "black",
         tl.srt = 45, 
         diag = F)
