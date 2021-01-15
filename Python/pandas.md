# pandas lib

### pandas lib 사용

- csv, excel, json에서 사용되는 lib

- `pip install pandas` or `conda install pandas`

- `pandas`는 `DataFrame`이라는 테이블 형식의 타입을 제공한다

- `pandas`는 `series` 이라는 벡터 형식의 타입을 제공한다

  ```python
  import pandas as pd
  
  bmiDataset = pd.read_csv('./word/service_bmi.csv', encoding ='utf-8')					# DataFrame type.
  print(bmiDataset.info())
  print(bmiDataset.head())    # 최상위 데이터 5개를 보여준다.
  print(bmiDataset.tail())    # 최하위 데이터 5개를 보여준다.
  ```

 - data type - `Series`

   ```python
   print(bmiDataset.height)    # series라는 데이터 타입. 벡터 형태와 유사하다
   print(bmiDataset['weight']) # 이런 형식으로도 접근이 가능하다
   print(bmiDataset['label'])
   ```

- 연산 가능

  ```python
  # EX) 키와 몸무게의 평균
  print('키 avg {} , 몸무게 avg {}'.format( sum(bmiDataset.height) / len(bmiDataset.height),  sum(bmiDataset['weight']) / len(bmiDataset['weight'])))
  
  # EX) 키와 몸무게의 최대값
  print('키 최대값', max(bmiDataset.height))
  print('몸무게 최대값', max(bmiDataset.weight))
  
  # EX) label 의 빈도수
  count = [0,0,0]
  for i in bmiDataset.label:
      if i == 'thin':
          count[0] +=1
      elif i == 'normal':
          count[1] +=1
      elif i == 'fat':
          count[2] +=1
  
  print('thin count : ', count[0])
  print('normal count : ', count[1])
  print('fat count : ', count[2])
  
  labelCnt = {}
  for label in bmiDataset.label:
      labelCnt[label] = labelCnt.get(label, 0) + 1
  print(labelCnt)
  ```

- `DataFrame`

  ```python
  import pandas as pd
  spamDataset = pd.read_csv('./word/spam_data.csv', header = None,encoding ='ms949')
  print(spamDataset.info())
  print(type(spamDataset))    # type : DataFrame
  print(spamDataset.head())
  
  target = spamDataset[0]
  print('target - ', target, type(target))
  text = spamDataset[1]
  print('text - ', text, type(text))
  
  # spam = 1, ham = 0 새로운 타켓을 만들고 싶다면?
  target = [1 if t == 'spam' else 0 for t in target]
  print(target)
  ```



###  `import re` , regular expression 

- 코드클린 - 문자열에 대한 정규표현식을 이용해서 문자를 제거하는 작업

- 크롤링 등등 할 때 정규 표현식을 사용

- 메타 문자 : . ^ $ * + {} [] \ | ()

  - . 는 무엇이든 한 글자를 의미

  - ^ 는 시작문자 지정

  - `*` 는 0 or more

  - `+` 는 1 or more

  - ? 는 0 or 1

  - 괄호를 통해서 조합 

    ```
    [abc] 는 a, b, c 중 한문자와 매치
    [^0-5] 는 not 의미
    ^[0-5] 는 시작문자 의미
    \d 는 숫자의 자릿수
    \D 는 숫자가 아닌 문자매칭의 자릿수
    \w 는 문자 + 숫자를 의미
    \W 는 문자 + 숫자 아닌 문자와 매치
    \s 는 공백
    010-0000-0000  ---->  ^\d{3}-\d{4}-\d{4}, 반드시 숫자로 시작하는 3자리 4자리 4자리
    ```

    

- 대표 함수
  - sub()
  - match()
  - findall()
  - finditer()
  
```python
import re
p = re.compile('[a-z]]+') # 하나이상
match = p.match('PYTHON')
print(match)    #None
  text = spamDataset[1]
    def cleanText(str):
      # re.sub 대체
      # re.sub(pattern= , replace to = , str)
      str = re.sub('[,.?!:;]', ' ', str)
      str = re.sub('[0-9]', ' ', str)
      str = re.sub('[0-9a-zA-Z]', ' ', str)
      str = ' '.join(str.split()) #split() 모든 공백을 하나의 공백으로 join
    	print(str)
  cleanText('5000 amdmDDDf 어어!')
  
   ex) 
  import re
  import pandas as pd

  def cleanText(str):
      # re.sub 대체
      # re.sub(pattern= , replace to = , str)
      answer = []
      str = re.sub('[,.?!:;]', ' ', str)
      str = re.sub('[0-9]', ' ', str)
      str = re.sub('[0-9a-zA-Z]', ' ', str)
      str = ' '.join(str.split()) #split() 모든 공백을 하나의 공백으로 join
      return str

  spamDataset = pd.read_csv('./word/spam_data.csv', header = None,encoding ='ms949')
  text = spamDataset[1]
  print(text)
  cleanText = [cleanText(t) for t in text]
  print(cleanText)

   Excel File 읽기  
  kospiDataset = pd.ExcelFile('./word/sam_kospi.xlsx')
  kospi = kospiDataset.parse('sam_kospi')
  print(kospi.info())

  from statistics import *
   통계를 계산할 때 사용하는 함수
  print('high mean - ', mean(kospi.High))
```


### json 파일 입출력
- json file: 네트워크 상에서 표준으로 사용되는 파일 형식 

- 웹에선 AJAX, 비동기 통신 데이터 타입이 다 json이다.

- 구성 : {key : value , key : value}

- encoding : python(dict, list) => json 문자열(즉, json file 로 변환)

-  decoding : json 문자열          => python 객체(dict 나 list)로
   
-  import json
   
```python
  import json
  # python -> json
user = {'id' : 1234, 'name' : '홍길동'}
print(type(user)) # dict
  
  # dict 처럼 보이지만 문자열이다. 그래서 어떻게 토큰화해서 정보에 접근 할거냐.
  # 파이썬 객체에서 json, encoding
  
  jsonStr = json.dumps(user) # object -> json str
  print(jsonStr, type(jsonStr))   # str
  
  # decoding
  
  pyObj = json.loads(jsonStr)
  print(pyObj, type(pyObj)) # 문자열 -> python, dict으로 바뀐거라서 key,value로 접근 가능
  print(pyObj['name'])
  
  # 홍길동이라는 한글 값을 check 해줘야해
  with open(file = './word/usagov_bitly.txt', mode='r', encoding='utf-8') as file:
      lines = file.readlines()
      # # 줄단위로 list type
      # print(type(lines), len(lines))
      # # 5개, 문자열의 형식
      # print(lines[:5])
      rows = [json.loads(line) for line in lines] # rows 안에는 list 안에 딕셔너리이다.
      print(type(rows))       # list
      print(type(rows[0]))    # dict

  for row in rows:
      for key, value in row.items():
          print('key - {}, value - {}'.format(key, value))

  # list[dict] => 행렬, 데이터 분석에 용이한 pd.DataFrame(행렬)
  rowsDF = pd.DataFrame(rows)
  print(rowsDF.head) # 정형화된 형식이 된다.
```
