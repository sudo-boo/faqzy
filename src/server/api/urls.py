from django.urls import path
from .views import get_answer,add_query

urlpatterns = [
    path('get_answer/', get_answer, name='get_answer'),
    path('add_query/', add_query, name='add_query'),
]
