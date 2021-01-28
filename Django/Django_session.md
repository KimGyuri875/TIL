## static 복습 

정적 파일(static) : css .javascript (plugin 파일들)

각 APP에 static 파일이 있다.  흩어진 static을 web에서 총괄하기 위해서 `collectstatic`을 한다. 예시로 header.html 와 footer.html 모든 app에서 사용되니깐 WEB에 저장을 하는데 header와 footer도 css가 공통으로 적용이 되어야하니깐 collectstatic을 해준다. 

반드시 templates > static 안에 존재해야한다. 

각 html 파일 위에 `{% load static %}`을 선언해야 static이 적용된다. 

화면 레이아웃 공통의 코드를 매번 쓰는게 아니라 include을 통해서  

## Session 

httpResponse : connectionless, stateless -> 유지를 하지 못한다.

=> 쿠키, 세션으로 상태정보를 서버 side에서 유지. 웹의 tracking 메커니즘을 지원한다. 

ex) 멤버만이 접근할 수 있는 페이지가 존재. 

### 사용자의 상태정보 저장을 위해서는 session, cookie 

##### 세션을 create하는 작업

`request.session['user_name'] = user.user_name` session에 다가 데이터베이스에 있는 정보를 담았다. 

##### 메모리상에 write 하는 작업 

```
context = {}
context['name'] = request.session['user_name']
context['id'] = request.session['user_id']
return render(request, 'home.html', context)
```

return render 에서 사용해서 context 

그냥 render에다가 직접 내용을 쓰면 이동하는 페이지까지만 사용가능하지만 session을 어디가쓰면 데이터를 공유할 수 있는 범위가 templates에 있는 모든 html파일에서 사용가능하다. 

#### session의 값 날리기. logout하기 

session 값을 null로 채우기.

```
request.session['user_name'] = {}
request.session['user_id'] = {}
request.session.modified =True	# commit 허용
return redirect('index')
```

login을 할 때 session을 심는다. 그러면 index 페이지에 들어갈 때 session이 존재하면 index창이 바로 home으로 render. 그대신 계속 session에 있는 값을 계속 render에 심어줘야한다. 

```
context = {'id' : request.session['user_id'],
           'name' : request.session['user_name']}
return render(request, 'home.html', context)
```

이를 templates에서 사용하기 위해서는 {{}}, {% %}을 이용해서 출력할 수 있는데 print는 {{}}이니깐 변수를 print한다라는 개념으로 이해하자.

#### button 이벤트는 script

script안에 는 태그를 쓰지 못하니깐 a href( get 방식) 태그 대신 location.href 를 쓰면 된다. 

#### 데이터베이스에 있는 내용을 url로 넘겨주기

```
<a href= "../bbs_read?id={{board.id}}">
//장고 방식
<a href="{% url 'bbs_read' id=board.id %}">
```

