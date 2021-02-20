from django import forms
from django.forms import ModelForm
from blog.models import Message


class MessageForm(ModelForm):
    class Meta:
        model = Message
        fields = ['text']