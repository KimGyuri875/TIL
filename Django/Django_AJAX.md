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
Ajax는 서버와 클라이언트간에 데이터를 이동하고 화면을 구성하는 구현 방식입니다. 비동기식 데이터 전송이다. 
![image-20210131234043605](C:\Users\gyuri_c1qkifk\AppData\Roaming\Typora\typora-user-images\image-20210131234043605.png)
