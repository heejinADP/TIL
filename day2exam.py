# 1. map과 lambda 함수를 이용하여 [5,7,9] 리스트의 각 요소값에 5가 곱해진 [25, 35, 45]라는 리스트를 만드시오.
five=list(map(lambda x: x * 5, [5,7,9]))
print(five)



# 2. [1, 2, 3, 4]와 ['a', 'b', 'c', 'd']라는 리스트가 있다. 이 두개의 리스트를 합쳐 다음과 같은 리스트를 만드시오.
# 결과 : [(1, 'a'), (2, 'b'), (3, 'c'), (4, 'd')]
mix=list(zip([1,2,3,4],['a','b','c','d']))
print(mix)




# 3. random모듈을 이용하여 로또번호(1~45 사이의 숫자 6개)를 생성하시오. (단, 중복된 숫자가 있으면 안됨)
import random
lotto=random.sample(range(1, 47), 6)
print(lotto)


