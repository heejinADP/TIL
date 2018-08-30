
# Q1
from bs4 import BeautifulSoup
import urllib.request as req
import re

myurl="https://kin.naver.com/qna/detail.nhn?d1id=1&dirId=10405&docId=307066785&qb=67mF642w7J207YSw&enc=utf8&section=kin&rank=4&search_sort=0&spq=1"
res=req.urlopen(myurl).read().decode("utf-8")
q=BeautifulSoup(res, 'html.parser')
result=q.select("#qna_detail_question > div.end_question._end_wrap_box")
result=str(result[0])
pat=re.compile('[^가-힣ㅏ-ㅣ]+')
result2=pat.sub(' ', res)
print(result2)

# 02
# 단어가 줄 단위로 저장된 words.txt 파일이 주어집니다. 다음 소스 코드를 완성하여 10자 이하인 단어의 개수가 출력되게 만드세요.
# [words.txt 내용]
# anonymously
# compatibility
# dashboard
# experience
# photography
# spotlight
# warehouse
# 출력 : 4

f=open("words.txt","w")
f.write("anonymously\ncompatibility\ndashboard\nexperience\nphotography\nspotlight\nwarehouse")
f.close()

with open('words.txt', 'r') as f:
    count=0
    words = f.readlines()
    for ten in words:
        if len(ten.strip('\n')) <= 10:
            count += 1
print(count)


# 03
# 표준 입력으로 정수와 문자열이 각 줄에 입력됩니다. [힌트 : input 2개(숫자, 문자열)]
# 다음 소스 코드를 완성하여 입력된 숫자에 해당하는 단어 단위 N-gram을 출력하세요.
# 만약 입력된 문자열의 단어 개수가 입력된 정수 미만이라면 'wrong'을 출력하세요.
#
# 실행 결과
# 7 (입력)
# Python is a programming language that lets you work quickly (입력)
# Python is a programming language that lets
# is a programming language that lets you
# a programming language that lets you work
# programming language that lets you work quickly

n = int(input("숫자를 입력 해주세요 : "))
text = input("문장을 입력 해주세요 : ")
words = text.split()

if (len(words) < n):
    print('wrong')
else:
    for i in range(len(words) - (n - 1)):
        for j in range(n):
            print(words[i + j], end=' ')
        print(' ')

# 먼저 input으로 입력된 값은 한 줄로 된 문자열이므로 split을 사용하여 공백을 기준으로 분리한 뒤 words에 저장해줍니다.
# 여기서는 N-gram의 N이 변수 n에 저장되므로 n을 활용하여 조건식을 작성합니다.
# 먼저 단어 개수가 입력된 숫자 미만이면 'wrong'을 출력하라고 했으므로 if 조건문에는 len(words) < n을 넣어줍니다.
# 단어 리스트를 반복할 때는 리스트의 범위를 벗어나지 않도록 range(len(words) - (n - 1))만큼 반복합니다.
# 참고로 2-gram은 요소 한 개 앞까지 반복하므로 range(len(words) - 1)이고,
# 7-gram은 요소 여섯 개 앞까지 반복하므로 range(len(words) - (7 - 1))입니다.
# 그러므로 문자열 마지막에서 (n - 1) 글자 앞까지 반복합니다.
# 단어를 출력할 때도 n개만큼 출력할 수 있도록 range(n)를 넣어주면 됩니다.

