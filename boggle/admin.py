from django.contrib import admin
from .models import Quiz, Report
from boggle.models import Task
from .models import Dictionary

admin.site.register(Task)
admin.site.register(Quiz)
admin.site.register(Dictionary)
admin.site.register(Report)
# Register your models here.
