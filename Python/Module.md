### collection 모듈

- Counter 클래스

  데이터의 개수를 셀 때 유용한 파이썬

  ```python
  def countLetters(word):
      counter = {}
      for letter in word:
          if letter not in counter:
              counter[letter] = 0
          counter[letter] += 1
      return counter
  
  countLetters('hello world'))
  # {'h': 1, 'e': 1, 'l': 3, 'o': 2, ' ': 1, 'w': 1, 'r': 1, 'd': 1}
  ```

  `collections` 모듈의 `Counter` 클래스를 사용해보자

  ```python
  from collections import Counter
  
  Counter('hello world') # Counter({'l': 3, 'o': 2, 'h': 1, 'e': 1, ' ': 1, 'w': 1, 'r': 1, 'd': 1})
  ```

  응용을 해보자.

  ```python
  from collections import Counter
  
  def find_max(word):
      counter = Counter(word)
      max_count = -1
      for letter in counter:
          if counter[letter] > max_count:
              max_count = counter[letter]
              max_letter = letter
      return max_letter, max_count
  
  find_max('hello world') # ('l', 3)
  ```

  - 출처 https://www.daleseo.com/python-collections-counter/
