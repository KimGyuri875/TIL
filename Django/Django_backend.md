![image-20210125093836534](C:\Users\gyuri_c1qkifk\AppData\Roaming\Typora\typora-user-images\image-20210125093836534.png)





## MVT 패턴이란

Model은 데이터 베이스에 저장되는 데이터를 의미하는 것이고, Template은 사용자에게 보여지는 UI부분(html)을, View는 실질적으로 프로그램 로직이 동작하여 데이터를 가져오고 적절하게 처리한 결과를 Template에 전달하는 역할을 수행한다. Url를 통해서 정보를 요청하고 view는 control 역할로 모델과 템플렛에서 할 일을 나눠준다. 



## Django 프로젝트 구조

terminal에 명령어

```
django-admin startproject baseWEB
```

를 실행하면 baseWEB 이 생성된다.

위 명령어 실행 결과는 다음과 같다.

```
프로젝트_이름/
    baseWEB/
        baseWEB/
            __init__.py
            settings.py
            urls.py
            wsgi.py
        manage.py            
    venv/
```

`settings.py` : 환경에 관한 정보를 관리하는 root 가 생성된 것이다. 만들어준 APP은 꼭 `INSTALLED_APPS` 에 등록을 해주어야한다. `DEBUG=True` 는 배포할때 false로 바꾼다. 데이터베이스는 sqlite3로 기본설정이 되어있다. 

`urls.py` : 사용자의 request가 이곳으로 들어와 맞는 APP으로 연결을 시켜준다.



## Django 앱 구조

Terminal 에 명령어

```
>dir/w
>cd baseWEB
>python manage.py runserver
```

를 통해 WEB에 있는 manage.py가 있는 디렉토리로 들어온다.  `runserver`를 통해서 서버를 실행시킨다. 이때 runserver를 통해서 port 번호를 지정해서 접근할 수도 있다.

manage.py 파일이 있는 디텍토리에서 앱(APP)  만들기 위해서 명령어

```
>python manage.py startapp HelloApp
```

를 수행해 `HelloApp`을 만든다. 

이때 만든 APP을 settings `INSTALLED_APPS =`에 등록을 시켜줘야한다.

위 명령어 실행 결과, APP의 형태는 다음과 같다.

```
프로젝트_이름/
    baseWEB/
    	baseWEB/
        HelloApp/
            __init__.py
            admin.py
            apps.py
            models.py
            tests.py
            views.py
        manage.py            
    venv/
```

이제 만든 app를 base urls에 연결해서 사용자의 request가 들어갔을 때 연결되도록 한다.

먼저 HelloApp폴더에 `urls.py`을 만든다.

base urls.py에 include 해준다

```python
path('hello/', include('HelloApp.urls')),
```



> base.urls 로 요청이 들어오고 -> 여기 HelloApp.urls로 이동을 해서  HelloApp.urls에서  .views의 특정 함수를 찾아서 이동한다. 



## Views

HelloApp.urls에는 연결될 views의 함수를 정의한다. 

```python
from django.contrib import admin
from django.urls import path, include
from HelloApp    import views
urlpatterns = [
    #localhost:8000/hello/index/
    path('index/', views.index),
    path('baseball/', views.baseball),
    path('football/', views.football, name ='foot'),
    path('basketball/', views.basketball),
    path('login/', views.login),
]
```

`path`의 첫번째 인자는 url에 작성되는 이름?형태이고 두번째는 실제 호출되는 views의 함수이름이다. football처럼 `name=''`이라는 별칭을 붙여줘 접근성을 높일 수 있다. 상대 경로, 절대경로 대신 `<a href={% url 'foot' %}> 축구 </a>; ` 으로 접근할 수 있게 해준다.  

views의 함수는 꼭 사용자의 request 객체가 인자로 들어와야한다.

```python
from django.shortcuts import render, HttpResponse

# Create your views here.
def index(request):
    #return HttpResponse('*** 여기는 시작 페이지 입니다 ***')
    context = {'ment' : '이곳은 연습장입니다.'}
    return render(request, 'hello/index.html', context)

def login(request):
    msg = request.POST['msg']
    print('param msg - ', msg)
    return HttpResponse('*** 여기는 login 페이지 입니다 ***')
```

이때 필요한 패키지 import하는거 잊으면 안된다.

{{}} 는 프린트 역할을 해준다.



## Templates

HelloApp 아래 `templates`라는 디렉토리를 생성한다. 디렉토리안에 폴더를 만들어 html templates 들을 생성한다. 

```
form method ="post|get" action="destination">
```

- GET 방식 : 클라이언트의 데이터를 URL에 붙여서 보낸다. 즉 뒤에 ,querystring이 붙는다. 
- POST 방식 : 데이터 전송을 기반으로 한 요청 메소드이다. 즉 POST방식은 BODY에 데이터를 넣어서 보낸다. 

url : xxxx.xom?key = value & key = value ->get 

​							<- querystring------->

url : xxxx.com -> post

```python
    <div align = "center">{{ment}}</div>
    <hr/>
    <form method ="post" action="../login/">
        {% csrf_token %}
        <input type="text" name="msg">
        <input type="submit" value="send">
    </form>
    <hr/>
    <a href="../baseball"> 야구 </a> &nbsp;&nbsp;&nbsp;
    <a href={% url 'foot' %}> 축구 </a> &nbsp;&nbsp;&nbsp;
    <a href="http://127.0.0.1:8000/hello/basketball"> 농구 </a>
```

`{% csrf_token %}`은 msg에 전달되는 text내용을 console에 print한다. 왜냐 form을 통해서 url로 login 함수를 요청한 것이다. view.login 함수가 실행되면서 print함수가 수행된다.  



