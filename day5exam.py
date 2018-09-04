from bs4 import BeautifulSoup
import urllib.request as req
import re

cgv="http://www.cgv.co.kr/movies/"
res=req.urlopen(cgv).read().decode("utf-8")
soup=BeautifulSoup(res,'html.parser')

number=soup.select("#contents > div.wrap-movie-chart > div.sect-movie-chart > ol > li > div.box-image > strong")
name=soup.select("#contents > div.wrap-movie-chart > div.sect-movie-chart > ol > li > div.box-contents > a > strong")
book=soup.select("#contents > div.wrap-movie-chart > div.sect-movie-chart > ol > li > div.box-contents > div > strong > span")




for i in range(0, len(number)) :
    print(number[i].string, name[i].string,"===> ", book[i].string)


