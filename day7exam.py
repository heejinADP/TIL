from bs4 import BeautifulSoup
import urllib.request as req
import re


# 기사 text 추출
url1="http://www.ytn.co.kr/_ln/0102_201808141608015747"
url2="http://www.yonhapnews.co.kr/bulletin/2018/08/14/0200000000AKR20180814075800003.HTML?from=search"
news1 = req.urlopen(url1).read()
news2 =  req.urlopen(url2).read().decode("utf-8")

soup1=BeautifulSoup(news1,'html.parser')
soup2=BeautifulSoup(news2,'html.parser')

atc1=str(soup1.select("#CmAdContent > span")[0])
atc2=str(soup2.select("#articleWrap > div.article > p")[0])

pat=re.compile('[^가-힣A-Z0-9]+')
a=pat.sub(' ',atc1)
b=pat.sub(' ',atc2)


# 각 문자열 n개로 나누기
def ngram(n, num):
    res = []
    nlen = len(n) - num +1
    for i in range(nlen):
        nn = n[i:i+num]
        res.append(nn)
    return res


# 두 기사간 유사도 찾기
def diff_ngram(sa, sb, num):
    a = ngram(sa, num)
    b = ngram(sb, num)
    cnt=0
    r=[]
    for i in a:
        for j in b:
            if i == j:
                cnt += 1
                r.append(i)
    return cnt / len(a), r


# 함수에 맞게 결과 출력

res,word=diff_ngram(a,b,2)
print("2-gram : ", res,word,"\n")

res,word=diff_ngram(a,b,3)
print("3-gram : ", res,word,"\n")

res,word=diff_ngram(a,b,4)
print("4-gram : ", res,word,"\n")









