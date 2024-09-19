from django.urls import path
from . import views
from django.contrib.auth import views as auth_views
from .views import CustomLoginView
from django.contrib.auth.views import LogoutView
from .views import custom_logout
from .views import inventario_pdf, clientes_pdf

urlpatterns = [
    path('', views.index, name='index'),
    path('login/', views.user_login, name='login'),
    path('register/', views.register_view, name='register'),
    path('tienda/', views.tienda, name='tienda'),
    path('planes/', views.planes, name='planes'),
    path('salud/', views.salud, name='salud'),
    path('login/', CustomLoginView.as_view(), name='login'),
    path('logout/', custom_logout, name='logout'), 
    path('comprar/<int:producto_id>/', views.comprar_producto, name='comprar_producto'),
    path('adquirir-plan/<int:plan_id>/', views.adquirir_plan, name='adquirir_plan'),
    # Configuración de la URL para confirmar la adquisición del plan
    path('confirmar-adquisicion-plan/<int:plan_id>/', views.confirmar_adquisicion_plan, name='confirmar_adquisicion_plan'),

    path('adquirir_plan_nutricional/<int:plan_id>/', views.adquirir_plan_nutricional, name='adquirir_plan_nutricional'),
    path('confirmar_adquisicion_plan_nutricional/<int:plan_id>/', views.confirmar_adquisicion_plan_nutricional, name='confirmar_adquisicion_plan_nutricional'),
    path('inventario_pdf/', inventario_pdf, name='inventario_pdf'),
    path('clientes_pdf/', clientes_pdf, name='clientes_pdf'),
    
]
