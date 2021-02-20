from django.db import models


class Message(models.Model):
    text = models.TextField(max_length=500)

    def __str__(self):
        return self.text
