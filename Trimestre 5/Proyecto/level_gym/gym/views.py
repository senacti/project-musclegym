
from pyexpat.errors import messages
from django.shortcuts import render, redirect
from django.contrib.auth import authenticate, login
from django.contrib.auth import logout
from .models import Plan, PlanNutricional, Inventario, Cliente, Inscripcion, InscripcionNutricional
from .forms import UserRegistrationForm, LoginForm
from django.contrib.auth.forms import UserCreationForm
from django.contrib.auth.forms import AuthenticationForm
from .forms import CustomUserCreationForm
from .forms import CompraForm
from django.shortcuts import render, get_object_or_404, redirect
from django.http import HttpResponse
from django.template.loader import get_template
from xhtml2pdf import pisa
from io import BytesIO
from django.shortcuts import redirect
from django.contrib.auth import login as auth_login
from django.contrib.auth.forms import AuthenticationForm
from django.views.generic.edit import FormView
from django.urls import reverse
from django.contrib.auth.views import LoginView
from django.urls import reverse_lazy
from django.http import HttpResponse
from openpyxl import Workbook
from io import BytesIO
from .models import Inventario, Cliente
from openpyxl import Workbook
from openpyxl.worksheet.table import Table, TableStyleInfo
from django.http import HttpResponse
from io import BytesIO
from .models import Inventario
import openpyxl
from django.db import IntegrityError


def index(request):
    return render(request, 'gym/index.html')

def salud(request):
    return render(request, 'gym/salud.html')

def user_login(request):
    if request.method == 'POST':
        form = LoginForm(request.POST)
        if form.is_valid():
            username = form.cleaned_data['username']
            password = form.cleaned_data['password']
            user = authenticate(username=username, password=password)
            if user:
                login(request, user)
                return redirect('index')
    else:
        form = LoginForm()
    return render(request, 'gym/login.html', {'form': form})

def tienda(request):
    # Obtener todos los productos desde el modelo Inventario
    productos = Inventario.objects.all()
    
    # Renderizar la plantilla con los productos
    return render(request, 'gym/tienda.html', {'productos': productos})

def planes(request):
    planes = Plan.objects.all()
    planes_nutricionales = PlanNutricional.objects.all()
    return render(request, 'gym/planes.html', {'planes': planes, 'planes_nutricionales': planes_nutricionales})


def register_view(request):
    if request.method == 'POST':
        form = CustomUserCreationForm(request.POST)
        if form.is_valid():
            try:
                user = form.save()
                login(request, user)
                return redirect('index')  # Redirige a la página de inicio después del registro
            except IntegrityError:
                form.add_error('username', 'El nombre de usuario ya está en uso.')
    else:
        form = CustomUserCreationForm()

    return render(request, 'gym/register.html', {'form': form})


class CustomLoginView(FormView):
    template_name = 'login.html'
    form_class = AuthenticationForm

    def form_valid(self, form):
        user = form.get_user()
        auth_login(self.request, user)
        if user.is_superuser:
            return redirect('/admin/')
        return redirect(reverse('index'))
    

def custom_logout(request):
    logout(request)
    return redirect('index')

class CustomLoginView(LoginView):
    template_name = 'login.html'
    
    def get_success_url(self):
        # Redirige a la URL de administración si el usuario es superusuario
        if self.request.user.is_superuser:
            return reverse_lazy('admin:index')
        # Redirige a una página por defecto para otros usuarios
        return super().get_success_url()
    from django.contrib.auth import authenticate, login


def custom_login(request):
    if request.method == 'POST':
        form = AuthenticationForm(request, data=request.POST)
        if form.is_valid():
            user = form.get_user()
            login(request, user)
            if user.is_superuser:
                return redirect('/admin/')
            return redirect('home')  # Redirige a una página por defecto para otros usuarios
    else:
        form = AuthenticationForm()
    return render(request, 'login.html', {'form': form})

def comprar_producto(request, producto_id):
    producto = get_object_or_404(Inventario, pk=producto_id)
    
    if request.method == 'POST':
        form = CompraForm(request.POST)
        if form.is_valid():
            # Aquí puedes agregar la lógica para guardar la compra en la base de datos
            # o procesar el pago.
            
            # Luego de procesar la compra, redirige a la página de confirmación
            return render(request, 'gym/comprar_confirmacion.html', {'producto': producto})
    else:
        # Si no es un POST, simplemente muestra el formulario
        form = CompraForm()
    
    return render(request, 'gym/comprar.html', {'producto': producto, 'form': form})

def adquirir_plan(request, plan_id):
    plan = get_object_or_404(PlanNutricional, pk=plan_id)
    if request.method == 'POST':
        # Lógica para manejar la adquisición del plan (por ejemplo, guardar la compra)
        return redirect('confirmar_adquisicion_plan', plan_id=plan_id)
    return render(request, 'gym/adquirir_plan.html', {'plan': plan})


def adquirir_plan_nutricional(request, plan_id):
    plan = get_object_or_404(PlanNutricional, pk=plan_id)
    if request.method == 'POST':
        # Aquí puedes agregar lógica para procesar la adquisición del plan
        return redirect('confirmar_adquisicion_plan_nutricional', plan_id=plan_id)
    return render(request, 'gym/adquirir_plan_nutricional.html', {'plan': plan})

def confirmar_adquisicion_plan(request, plan_id):
    plan = get_object_or_404(PlanNutricional, pk=plan_id)
    return render(request, 'gym/confirmar_adquisicion_plan.html', {'plan': plan})

def confirmar_adquisicion_plan_nutricional(request, plan_id):
    plan = get_object_or_404(PlanNutricional, pk=plan_id)
    return render(request, 'gym/confirmar_adquisicion_plan_nutricional.html', {'plan': plan})


import os
from django.conf import settings
from django.http import HttpResponse
from reportlab.lib.pagesizes import letter
from reportlab.pdfgen import canvas
from reportlab.platypus import Table, TableStyle, Image
from reportlab.lib import colors
from io import BytesIO
from .models import Inventario, Cliente

def get_static_file_path(filename):
    if not settings.STATICFILES_DIRS:
        raise FileNotFoundError("No static files directories are configured.")
    # Assuming the first directory in STATICFILES_DIRS is where we look for static files
    static_dir = settings.STATICFILES_DIRS[0]
    return os.path.join(static_dir, filename)

def inventario_pdf(request):
    buffer = BytesIO()
    p = canvas.Canvas(buffer, pagesize=letter)
    width, height = letter

    # Ruta al archivo de imagen estático
    try:
        logo_path = get_static_file_path('gym/images/icon.png')
        logo = Image(logo_path, width=100, height=100)
        logo.drawOn(p, 50, height - 150)
    except FileNotFoundError:
        p.drawString(50, height - 150, "Logo no encontrado")

    p.setFont("Helvetica-Bold", 16)
    p.drawString(100, height - 200, "Reporte de Inventario")

    data = [
        ['Nombre', 'Cantidad', 'Precio', 'Descripción']
    ]
    for item in Inventario.objects.all():
        data.append([item.nombre, item.cantidad, f"${item.precio:.2f}", item.descripcion or ""])

    table = Table(data)
    table.setStyle(TableStyle([
        ('BACKGROUND', (0, 0), (-1, 0), colors.grey),
        ('TEXTCOLOR', (0, 0), (-1, 0), colors.whitesmoke),
        ('ALIGN', (0, 0), (-1, -1), 'CENTER'),
        ('FONTNAME', (0, 0), (-1, 0), 'Helvetica-Bold'),
        ('BOTTOMPADDING', (0, 0), (-1, 0), 12),
        ('BACKGROUND', (0, 1), (-1, -1), colors.beige),
        ('GRID', (0,0), (-1,-1), 1, colors.black),
    ]))

    y_position = height - 250
    table.wrapOn(p, width - 100, height)
    table.drawOn(p, 50, y_position)

    p.showPage()
    p.save()

    pdf = buffer.getvalue()
    buffer.close()

    response = HttpResponse(pdf, content_type='application/pdf')
    response['Content-Disposition'] = 'attachment; filename="inventario_report.pdf"'
    return response

def clientes_pdf(request):
    buffer = BytesIO()
    p = canvas.Canvas(buffer, pagesize=letter)
    width, height = letter

    # Ruta al archivo de imagen estático
    try:
        logo_path = get_static_file_path('gym/images/icon.png')
        logo = Image(logo_path, width=100, height=100)
        logo.drawOn(p, 50, height - 150)
    except FileNotFoundError:
        p.drawString(50, height - 150, "Logo no encontrado")

    p.setFont("Helvetica-Bold", 16)
    p.drawString(100, height - 200, "Reporte de Clientes")

    data = [
        ['Usuario', 'Teléfono', 'Dirección', 'Fecha de Nacimiento', 'Fecha de Registro', 'Peso', 'Altura', 'EPS', 'Objetivo']
    ]
    for cliente in Cliente.objects.all():
        data.append([
            cliente.usuario.username,
            cliente.telefono or "",
            cliente.direccion or "",
            str(cliente.fecha_nacimiento) if cliente.fecha_nacimiento else "",
            str(cliente.fecha_registro),
            str(cliente.peso) if cliente.peso else "",
            str(cliente.altura) if cliente.altura else "",
            cliente.eps or "",
            cliente.objetivo or ""
        ])

    table = Table(data)
    table.setStyle(TableStyle([
        ('BACKGROUND', (0, 0), (-1, 0), colors.grey),
        ('TEXTCOLOR', (0, 0), (-1, 0), colors.whitesmoke),
        ('ALIGN', (0, 0), (-1, -1), 'CENTER'),
        ('FONTNAME', (0, 0), (-1, 0), 'Helvetica-Bold'),
        ('BOTTOMPADDING', (0, 0), (-1, 0), 12),
        ('BACKGROUND', (0, 1), (-1, -1), colors.beige),
        ('GRID', (0,0), (-1,-1), 1, colors.black),
    ]))

    y_position = height - 250
    table.wrapOn(p, width - 100, height)
    table.drawOn(p, 50, y_position)

    p.showPage()
    p.save()

    pdf = buffer.getvalue()
    buffer.close()

    response = HttpResponse(pdf, content_type='application/pdf')
    response['Content-Disposition'] = 'attachment; filename="clientes_report.pdf"'
    return response

def adjust_column_widths(sheet):
    """
    Ajusta el ancho de las columnas en función del contenido más largo.
    """
    for column_cells in sheet.columns:
        length = max(len(str(cell.value)) for cell in column_cells)
        sheet.column_dimensions[column_cells[0].column_letter].width = length + 2

