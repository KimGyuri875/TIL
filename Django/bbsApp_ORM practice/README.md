##  header, footer, templates (css, js) 적용하는 방법

css, js는 static 이라는 폴더에 저장을 해줘야 한다. 

header.html, footer.html은 여러 app에서 사용될거니깐 WEB아래 templates 폴더 안에 넣어준다.



#### settings 변경해주기

```
STATICFILES_DIRS = [
    os.path.join(BASE_DIR, 'bbsApp', 'static'),
]
```

 settings에 다가 정적 파일이 있는 곳을 작성해주어야한다. 

```
BASE_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
```

```
TEMPLATES = [
    {
        'BACKEND': 'django.template.backends.django.DjangoTemplates',
        'DIRS': [os.path.join(BASE_DIR), 'web/templates'],
        'APP_DIRS': True,
        'OPTIONS': {
            'context_processors': [
                'django.template.context_processors.debug',
                'django.template.context_processors.request',
                'django.contrib.auth.context_processors.auth',
                'django.contrib.messages.context_processors.messages',
            ],
        },
    },
```

`'DIRS': [os.path.join(BASE_DIR), 'web/templates'],` 는 header, footer 처럼 공통 되는 코드를 가리키는 곳으로, html 파일에 include를 통해서 넣는다. 



#### html에 header, footer 적용하기

`{% include 'header.html' %}`을 바디(home.html)에 다가 include 하고 

block 임을 `{% block content%}`  전체 ~~~ `{%endblock %}`으로 표시한다. 



#### static 폴더를 하나로 모으기

static으로 있는 내용이 여러 디렉터리에 흩어져있는걸 하나로 모아야한다. 

baseWeb에 있는 footer.html, header.html도 bbsApp안에있는 static의 resource를 사용할 수 있도록 

`>python manage.py collectstatic `

그결과 baseWeb 아래 static 이라는 폴더가 생기면서 모이게 된다. 

`{% load static %}` 을 통해서 login.html 와 같은 곳에 static을 사용해줄 것임을 작성한다. 



### MODEL ORM

models.py 를 통해 테이블을 생성하고 admin.py를 통해서 orm을 등록, 관리한다. 

model 을 class을 통해서 생성 class 는 table 과 같은 의미로 컬럼을 등록하면 된다. 

`>python manage.py makemigrations`

`>python manage.py migrate`

이제 orm을 관리할 수 있는 관리자를 만들 수 있다. 관리자는 데이터베이스 관리를 위한 계정이다. 

`>python manage.py createsuperuser`

http://127.0.0.1:8000/admin/login 에서 admin 로그인 하고 테이블을 관리할 수 있다. 

views.py 파일에 어떤식으로 데이터베이스에 접근해야하는지 정리해놨다.



### views return 방식(화면 분기 방식)

- HttpResponse() - X

- JsonResponse() - json

- render() - templates(xxxx.html)으로 이동, url을 보면 변경이 되지 않음

- redirect(path를 쓰는게 아니라 path의 별칭, alias를 넣어준다) : 요청을 재지정하는 것이다.  

  urls---> views에서 request를 받아서 templates로 보내는게 아니라 views에서 또다른 request를 요청하는 것이다. 

  ex) 글을 씀 -> list 페이지로 이동 -> 이럴때 render를 쓰는게 아니다. 왜냐 글을 썼으면 DB에 저장 insert(update, delete) select가 동시에 일어나기 위해서는 insert를 하고 select를 위한 또다른 요청을 보내는거다. 

  redirect를 할 경우 url이 변경된다. (함수에 함수 부르기)

  

{{}} --print

{% %} -- code (if , for )