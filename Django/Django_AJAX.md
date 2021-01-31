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

