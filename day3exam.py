




# emails = ['python@mail.example.com', 'python+kr@example.com',              # 올바른 형식
#           'python-dojang@example.co.kr', 'python_10@example.info',         # 올바른 형식
#           'python.dojang@e-xample.com',                                    # 올바른 형식
#           '@example.com', 'python@example', 'python@example-com']          # 잘못된 형식
#
# 아래와 같은 결과가 출력되는 정규식을 만드세요.
# True True True True True False False False

import re
emails = ['python@mail.example.com', 'python+kr@example.com',              # 올바른 형식
          'python-dojang@example.co.kr', 'python_10@example.info',         # 올바른 형식
          'python.dojang@e-xample.com',                                    # 올바른 형식
          '@example.com', 'python@example', 'python@example-com']          # 잘못된 형식

pat=re.compile("[a-z0-9._+-]+[@][a-z-]+[.][com|co.kr|info]")
# pat=re.compile('^[a-zA-Z0-9+-_.]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$')
emailsList=[]
for address in emails:
    res = pat.match(address)
    if res==None:
        emailsList.append(False)
    else:
        emailsList.append(True)
print(emailsList)























