from django.db import models

class Task(models.Model):
    id = models.AutoField(primary_key=True)
    work = models.CharField(max_length=400, default='null')
    isComplete = models.BooleanField(default=False)
    image = models.ImageField(upload_to='task_images/', null=True, blank=True)
# Create your models here.
