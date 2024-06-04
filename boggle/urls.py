from django.urls import path
from django.conf import settings
from django.conf.urls.static import static
from boggle import views
from django.urls import path



app_name = 'boggle'

urlpatterns = [
    path('', views.getTaskList, name='getTaskList'),  
    path('addTask', views.addTask, name='addTask'),
    path('updateTask/<int:pk>/<str:work>', views.updateTask, name='updateTask'),
    path("deleteTask/<int:pk>", views.deleteTask, name='deleteTask'),

    path('quiz_data_api', views.quiz_data_api, name='quiz_data_api'),
    path('check_answer/', views.check_answer, name='check_answer'),


    path('addReport', views.addReport, name='addReport'),
    path('getReportList', views.getReportList, name='getReportList'),
    path('updateReport/<int:pk>/', views.updateReport, name='updateReport'),
    path('deleteReport/<int:pk>/', views.deleteReport, name='deleteReport'),

]


