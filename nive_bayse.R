# 나이브 베이즈 분류기 : 스팸메일 분류

sms_raw<-read.csv("sms_test.txt", stringsAsFactors = FALSE)
str(sms_raw)
sms_raw$type<-factor(sms_raw$type)
str(sms_raw)
table(sms_raw$type)

#데이터 준비 : 텍스트 데이터 정리 & 표준화(tm 패키지에서 기능 제공)
#텍스트 처리
#1)corpus(텍스트 문서의 모음) 생성 - 이메일 corpus, vcropus()함수 사요
install.packages("tm")
library(tm)

sms_corpus<-VCorpus(VectorSource(sms_raw$text))
print(sms_corpus)
str(sms_corpus)

#sms_corpus의 요약정보
inspect(sms_corpus[1:2]) 
as.character(sms_corpus[[1]])
lapply(sms_corpus[1:2], as.character)

#소문자 변호
sms_corpus_clean<-tm_map(sms_corpus, content_transformer(tolower)) 
as.character(sms_corpus_clean[[1]])
as.character(sms_corpus[[1]])

#숫자 제거
sms_corpus_clean<-tm_map(sms_corpus_clean, removeNumbers) 

#불용어 제거
sms_corpus_clean<-tm_map(sms_corpus_clean, removeWords, stopwords()) 
as.character(sms_corpus[[1]])
as.character(sms_corpus_clean[[1]])

#구두점 제거
sms_corpus_clean<-tm_map(sms_corpus_clean, removePunctuation) 
as.character(sms_corpus_clean[[1]])
removePunctuation("hi,hello..world!")

#Punctuation을 공백으로 바꾸기
replacePunctuation<-function(x){     
  gsub("[[:punct:]]", " ", x)
}
replacePunctuation("hi,hello..world!")  

install.packages("SnowballC")
library(SnowballC)
wordStem(c("learn","learned","learning","learns"))

sms_corpus_clean<-tm_map(sms_corpus_clean, stemDocument)
inspect(sms_corpus_clean[1:2])
as.character(sms_corpus_clean[[1]])

sms_corpus_clean<-tm_map(sms_corpus_clean, stripWhitespace)

#교정 전과 후의 상태 비교
as.character(sms_corpus[1:5])
as.character(sms_corpus_clean[1:5])

# 텍스트를 단어로 나누는 작업(토큰화)
sms_dtm<-DocumentTermMatrix(sms_corpus_clean)
sms_dtm

# 위의 전처리 작업을 한번에 하기
sms_dtm2<-DocumentTermMatrix(sms_corpus, control = list(
  tolower=TRUE, removeNumbers=TRUE, stopwords=TRUE, removePunctuation=TRUE, stemming=TRUE
))


# 위의 전처리 작업을 한번에 하기2


sms_dtm
sms_dtm2
sms_dtm3

#inspect(sms_dtm)
sms_dtm_train<-sms_dtm[1:50,]
sms_dtm_train

sms_dtm_test<-sms_dtm[51:60,]
sms_dtm_test

sms_train_labels<-sms_raw[1:50,]$type
sms_test_labels<-sms_raw[51:60,]$type
sms_train_labels
sms_test_labels

#prop.table() : 확률
prop.table(table(sms_train_labels))
prop.table(table(sms_test_labels))


install.packages("wordcloud")
library(wordcloud)
wordcloud(sms_corpus_clean, random.order = FALSE, 
          random.color = T, colors = brewer.pal(9, "Set1")) #min.freq = 3

#sms_row에 있는 모든 메시지에 대해 분ㄹ
spam<-subset(sms_raw, type="spam")
ham<-subset(sms_raw, type="ham")
spam
ham

wordcloud(spam$text, random.order = FALSE, 
          random.color = T, colors = brewer.pal(9, "Set1")) 
wordcloud(ham$text, random.order = FALSE, 
          random.color = T, colors = brewer.pal(9, "Set1")) 

sms_freq_words<-findFreqTerms(sms_dtm_train, lowfreq = 2)
str(sms_freq_words)

#sms_dtm_train에서는 단어가 330개 들어가 있음
#sms_dtm_freq_train에는 단어가 62개 있ㅇ
sms_dtm_freq_train<-sms_dtm_train[,sms_freq_words]
sms_dtm_freq_test<-sms_dtm_test[,sms_freq_words]음


# 나이브 베이즈 분류기는 범주형 특징 데이터에 대해서만 훈ㄹ
inspect(sms_dtm_freq_train)

convert_counts<-function(x){
  x<- ifelse(x>0, "YES", "NO")
}

#MARGIN =1 행방향, MARGIN=2 열방향
sms_train<-apply(sms_dtm_freq_train, MARGIN = 2,convert_counts)
sms_train

sms_test<-apply(sms_dtm_freq_test, MARGIN = 2,convert_counts)
sms_test


#####################모델링##########################

install.packages("e1071")
library(e1071)

sms_classifier<-naiveBayes(sms_train, sms_train_labels) #,laplace=1
sms_test_pred<-predict(sms_classifier, sms_test)
sms_test_pred

library(gmodels)
CrossTable(sms_test_pred, sms_test_labels,dnn = c('predicted','actual'))
