from django.http import HttpResponse, HttpResponseRedirect
from django.shortcuts import render, redirect
from django.contrib.auth import authenticate, login, logout
from django.contrib.auth.decorators import login_required
from django.db.models import Sum
from service.models import billinfo, paymentrecords
from .middlewares import guest

@guest
def indexPage(request):
    if request.method == "POST":
        uname = request.POST.get('uname', '')
        userpass = request.POST.get('pass', '')

        if not uname or not userpass:
            return render(request, "index.html", {'error': True})

        user = authenticate(request, username=uname, password=userpass)
        if user is not None:
            login(request, user)
            return redirect('home')  # Use the named URL pattern for redirection
        else:
            return render(request, "index.html", {'error1': True})

    return render(request, "index.html")

@login_required(login_url='login')
def homePage(request):
    return render(request, "home.html")

@login_required(login_url='login')
def dashboard(request):
    bilinfo = billinfo.objects.all().order_by('-id')
    pymtinfo = paymentrecords.objects.all().order_by('-id')
    total_amount = bilinfo.aggregate(total_amount=Sum('amount'))['total_amount'] or 0
    
    billinfodata = {
        'billdata': bilinfo,
        'total_amount': total_amount,
        'paymentdet': pymtinfo
    }
    return render(request, "dashboard.html", billinfodata)

def logoutpage(request):
    logout(request)
    return redirect('index')  # Redirect to the login page or home page after logout

    logout(request)
    return redirect('login')