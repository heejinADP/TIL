# KNN : 최근접 이웃. 레이블 없는 데이터를 레이블된 유사 
# 예 : 개인별 선호도 예측, 특정 병 진단, 

getwd()
# setwd("c:/다른경로") 작업디렉토리를 변경
wbcd<-read.csv("d:/R_work/wisc_bc_data.csv", stringsAsFactors = FALSE)
str(wbcd)
wbcd<-wbcd[-1]
str(wbcd)

table(wbcd$diagnosis)
str(wbcd$diagnosis)
wbcd$diagnosis<-factor(wbcd$diagnosis, levels = c('B', 'M'), labels = c('Benign','Malignant'))
wbcd$diagnosis
str(wbcd$diagnosis)
round(prop.table(table(wbcd$diagnosis))*100, digits=1)
summary(wbcd[c("radius_mean", "area_mean", "smoothness_mean")])

normalize <- function(x){
  return((x-min(x)) / (max(x)-min(x)))
}
normalize(c(1,2,3,4,5))
normalize(c(10,20,30,40,50))

wbcd_n<-lapply(wbcd[2:31], normalize)
wbcd_n
str(wbcd_n)
wbcd_n<-as.data.frame(wbcd_n)
str(wbcd_n)

summary(wbcd_n$area_mean)


# 569건 : train 1~469, test 470~560
wbcd_train<-wbcd_n[1:469,]
wbcd_test<-wbcd_n[470:569,]

wbcd_train_labels<-wbcd[1:469,1]
wbcd_test_labels<-wbcd[470:569,1]

head(wbcd_train, 5)
head(wbcd_test,5)
head(wbcd_train_labels, 5)
head(wbcd_test_labels,5)


# KNN 모델링 : 단순히 입력 데이터를 구조화된 형식으로 저장
# KNN에서 데이터를 분류하기 위한 함수 : class
install.packages("class")
library(class)
wbcd_test_pred<-knn(train = wbcd_train, test = wbcd_test, cl = wbcd_train_labels, k = 21)
#모델 성능 평가
CrossTable(x=wbcd_test_labels, y=wbcd_test_pred, prop.chisq = FALSE )






install.packages("arules")
library(arules)
#groceries<-read.csv("d:/R_work/groceries.csv", sep = ",")
#groceries
groceries<-read.transactions("d:/R_work/groceries.csv", sep = ",") # 희소행렬로 읽어들임(빈칸없이 데이터만 읽는다)
summary(groceries)

inspect(groceries[1:5])

itemFrequencyPlot(groceries, support = 0.1) #최소 10%의 지지도
itemFrequencyPlot(groceries, topN = 15) #최대 15위

image(sample(groceries, 100))

apriori(groceries) #support=0.1, confidence=0.8

groceryrules<-apriori(groceries, parameter = list(support = 0.006, confidence = 0.25, minlen = 2)) #minlen: 2개 미만의 아이템을 갖는 규칙 제외
summary(groceryrules)
inspect(groceryrules[1:3])
inspect(sort(groceryrules, by="lift")[1:10])

#연관 규칙의 부분 집합 (berry가 어떤 아이템과 자주 구매되는가)
berryrules<-subset(groceryrules, items %in% "berries")
inspect(berryrules)

write(groceryrules, file="d:/R_work/groceryrules.csv", sep=",", quote=TRUE, row.names=FALSE)
groceryrules_df<-as(groceryrules, "data.frame")
str(groceryrules_df)
