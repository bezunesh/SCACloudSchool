from django.urls import path
from blog import views

app_name = 'blog'

urlpatterns = [
    path('', views.index, name='index'),
    path('new-message', views.newMessage, name='new-message'),
    path('save-message', views.saveMessage, name='save-message'),
]