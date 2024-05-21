from django.urls import path
from django.conf import settings
from django.conf.urls.static import static
from posting import views

app_name = 'posting'

urlpatterns = [
    path('', views.getTaskList, name='getTaskList'),  # 'getTaskList'의 오타 수정

    path('addTask', views.addTask, name='addTask'),
    path('updateTask/<int:pk>/<str:work>', views.updateTask, name='updateTask'),
    path("deleteTask/<int:pk>", views.deleteTask, name='deleteTask'),
]

# static() 함수를 urlpatterns에 추가하여 미디어 URL 처리
# urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)
