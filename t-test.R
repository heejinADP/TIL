library(ggplot2)
mpg <- as.data.frame(ggplot2::mpg)

library(dplyr)

mpg_diff <- mpg %>% 
  select(class, cty) %>% 
  filter(class %in% c("compact", "suv"))
head(mpg_diff)
table(mpg_diff$class)

t.test(data = mpg_diff, cty ~ class, var.equal = T)
#Two Sample t-test
#
#data:  cty by class
#t = 11.917, df = 107, p-value < 2.2e-16
#alternative hypothesis: true difference in means is not equal to 0
#95 percent confidence interval:
#  5.525180 7.730139
#sample estimates:
#  mean in group compact     mean in group suv 
#20.12766              13.50000 

head(mpg)

mpg_diff2 <- mpg %>% 
  select(fl, cty) %>% 
  filter(fl %in% c("r", "p"))
table(mpg_diff2$fl)

t.test(data = mpg_diff2, cty ~ fl, var.equal = T)
#Two Sample t-test
#data:  cty by fl
#t = 1.0662, df = 218, p-value = 0.2875
#alternative hypothesis: true difference in means is not equal to 0
#95 percent confidence interval:
#  -0.5322946  1.7868733
#sample estimates:
#  mean in group p mean in group r 
#17.36538        16.73810 
