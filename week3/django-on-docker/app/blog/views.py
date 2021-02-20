from django.http import HttpResponseRedirect 
from django.shortcuts import render
from django.contrib import messages
from django.urls import reverse
from blog.models import Message
from blog.forms import MessageForm

def index(request):
    # show message list
    messages = Message.objects.all()
    return render(request, 'blog/messages.html', {'msgs': messages})

def newMessage(request):
    form = MessageForm()
    return render(request, 'blog/new-message.html', {'form': form})

def saveMessage(request):
    if request.method == 'POST':
        form = MessageForm(request.POST)
        if form.is_valid():
            new_message = form.save()
            messages.add_message(request, messages.INFO, "Message added successfully!")

            return HttpResponseRedirect(reverse('blog:index'))
    else:
        form=MessageForm()
    return render(request, 'blog/new-message.html', {'form', form})
