from django.shortcuts import render, redirect
from .models import *
# Create your views here.

# select * from table;
# -> modelName.objects.all()

# select * from table where id = xxxx;
# -> modelName.objects.get(id = xxxx)
# -> modelName.objects.filter(id = xxxx)

# select * from table where id = xxxx and pwd = yyyy;
# -> modelName.objects.get(id = xxxx, pwd = yyyy)
# -> modelName.objects.filter(id = xxxx, pwd = yyyy)

# select * from table where id = xxxx or pwd = yyyy;
# -> modelName.objects.filter(Q(id = xxxx) | Q(pwd = yyyy))

# select * from table where subject like '%공지%'
# -> modelName.objects.filter(subject_icontains='공지')
# select * from table where subject like '공지%'
# -> modelName.objects.filter(subject_startswith='공지')
# select * from table where subject like '공지%'
# -> modelName.objects.filter(subject_endswith='공지')

# insert into table values()
# model(attr=value, attr=value)
# model.save()

# delete * from tableName where id = xxxx
# -> modelName.objects.get(id=xxxx).delete()

# update tableName set attr = value where id = xxxx
# -> obj = modelName.objects.get(id=xxxx)
# odj.attr = value
# obj.save() --auto commit


def index(request):
    return render(request, 'login.html')

def loginProc(request):
    print('request - loginProc')
    if request.method == "GET" :
        return redirect('index')
    elif request.method == "POST":
        id = request.POST['id']
        pwd = request.POST['pwd']
        #select * from BbsUserRegister where user_id = id and user_pwd = pwd
        #user = BbsUserRegister.objects.filter(user_id=id, user_pwd =pwd)
        user = BbsUserRegister.objects.get(user_id=id, user_pwd=pwd)
        print('user result - ', user)
        if user is not None:
            return render(request, 'home.html')
        else:
            return redirect('index')

def registerForm(request):
    return render(request, 'join.html')

def register(request):
    print('request - register')
    if request.method == "GET":
        return redirect('index')
    elif request.method == "POST":
        id = request.POST['id']
        pwd = request.POST['pwd']
        name = request.POST['name']
        register = BbsUserRegister(user_id=id, user_pwd=pwd,user_name=name )
        # insert into table values()
        register.save()
        return render(request, 'login.html')