### script 복습

```
<form method="post" id="removeFrm">
   {% csrf_token %}
   <input type="hidden" name="id" value="{{board.id}}">
</form>
```

위에 form에 action이 존재하지 않는다. action을 script를 통해서 추가를 할거다. 
script라는 것이 도큐먼트에 수정 삭제 추가를 할 수 있는 거니깐.

```
$('#remoBtn').click(function() {
   $('#removeFrm').attr('action', "{% url 'bbs_remove' %}").submit()
})
```

이 script를 통해서 action이라는 속성을 추가하는 것이다. 



### AJAX 복습 

```
$.ajax({
   url :"{% url 'bbs_search' %}",
   type: "post",
   data: {"csrfmiddlewaretoken" : '{{csrf_token}}',
         type : type,
         keyword : keyword},
   dateType: 'json',
   success:function(ary){
      alert('success')
   }
})
```

ajax 통신을 하기 위해선 딕셔너리 형태로 넘겨줘야하는데 여러개라면 list로 묶어서 딕셔너리로 묶어서 넘겨준다.  

#### AJAX 란
Ajax는 프레임워크가 아닌 구현하는 방식을 의미한다. 데이터를 이동하고 화면을 구성하는데 있어서 웹 화면을 갱신하지 않고 필요한 데이터를 서버로 보내고 가져오는 방법이다. 화면 갱신이 없어서 사용자 입장에서는 매우 편리하고 빠르게 작업을 처리하는 것처럼 느끼게 한다.

##### 데이터 전송
Ajax는 서버와 클라이언트간에 데이터를 이동하고 화면을 구성하는 구현 방식입니다. 비동기식 데이터 전송이다. 서버로 데이터를 요청하고 응답을 기다리는 동안 웹은 자신의 다른 업무를 진행하고 응답이 오면 그 후 작업을 진행한다. 즉, 사용자 입장에서는 화면 갱신도 없고, 요청-응답 사이 시간에도 다른 일을 진행할 수 있기 때문에 편리하고 빠르게 작업을 처리하는 것처럼 느껴진다.

##### 데이터 형식
Ajax 통신에서 데이터를 전송하는 형식은 크게 3가지로 CSV, JSON, XML 형식이 있다. JSON형식은 JavaScript의 객체 형태로 데이터를 전송하는 형식이다. XML과 CSV형식의 단점을 최소화한 형식이다. 

##### 데이터 전송 형식
GET(열람), POST(생성), PUT(갱신), DELETE(삭제), HEAD(요청). CRUD방식으로 GET,POST방식을 주로 지원한다. GET방식은 단순히 읽어 오는 경우에 쓰이며 POST방식의 경우 데이터를 생성, 수정, 삭제하는 경우에 쓰인다. 

##### jQuery Ajax
jQuery 라이브러리에서의 Ajax는 보다 다양하고 단순한 방법으로 javaScript Ajax를 구현을 할 수 있게 해준다. 

> 출처 및 참조 https://www.nextree.co.kr/p9521/
