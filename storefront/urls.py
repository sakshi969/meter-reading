"""
URL configuration for storefront project.

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/5.0/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.contrib import admin
from django.urls import path
from storefront import views
from analysis.views import charts, user_detail_view

urlpatterns = [
    path('admin/', admin.site.urls),
    path('', views.indexPage, name='login'),
    path('home/', views.homePage),
    path('dashboard/', views.dashboard, name='dashboard'),
    path('logout/', views.logoutpage),
    path('charts/', charts, name='charts'),
    path('user/', user_detail_view, name='user_detail'),
]