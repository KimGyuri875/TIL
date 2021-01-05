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
  
  
### heapq 모듈 

> 데이터를 정렬된 상태로 저장하기 위해서 사용

- `import heapq`

- 힙에 원소 추가

  ```python
  heap = []
  
  heapq.heapq.heappush(heap, 4)
  heapq.heappush(heap, 1) 
  ```

  `heappush()`함수는 `O(logN)`의 시간 복잡도를 가진다
  
- 힙에서 원소 삭제

  ```python
  print(heapq.heappop(heap))
  ```

- 최소값 삭제하지 않고 얻기

  ```python
  print(heap[0])
  ```

- 기존 리스트를 힙으로 변환

  ```python
  heap = [4, 1, 7, 3, 8, 5]
  heapq.heapify(heap)
  ```

- heapq 모듈을 이용한 최대 힙

  ```python
  import heapq
  
  nums = [4, 1, 7, 3, 8, 5]
  heap = []
  
  for num in nums:
    heapq.heappush(heap, (-num, num))  # (우선 순위, 값)
  
  while heap:
    print(heapq.heappop(heap)[1])  # index 1, index 0 은 우선순위
  ```
    - 출처 https://www.daleseo.com/python-heapq/
