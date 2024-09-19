from django.db import models
from django.contrib.auth.models import User

class Plan(models.Model):
    nombre = models.CharField(max_length=100)
    descripcion = models.TextField()
    precio = models.DecimalField(max_digits=10, decimal_places=2)
    duracion = models.PositiveIntegerField(help_text="Duración en días")

    def __str__(self):
        return self.nombre

class PlanNutricional(models.Model):
    nombre = models.CharField(max_length=100)
    descripcion = models.TextField()
    precio = models.DecimalField(max_digits=10, decimal_places=2)
    duracion = models.PositiveIntegerField(help_text="Duración en días")

    def __str__(self):
        return self.nombre

class Inventario(models.Model):
    nombre = models.CharField(max_length=100)
    cantidad = models.PositiveIntegerField()
    precio = models.DecimalField(max_digits=10, decimal_places=2)
    descripcion = models.TextField(blank=True, null=True)
    imagen = models.ImageField(upload_to='inventory_images/', blank=True, null=True)

    def __str__(self):
        return self.nombre

class Cliente(models.Model):
    usuario = models.OneToOneField(User, on_delete=models.CASCADE)
    telefono = models.CharField(max_length=15, blank=True, null=True)
    direccion = models.TextField(blank=True, null=True)
    fecha_nacimiento = models.DateField(blank=True, null=True)
    fecha_registro = models.DateField(auto_now_add=True)
    foto = models.ImageField(upload_to='fotos_clientes/', blank=True, null=True)
    peso = models.DecimalField(max_digits=5, decimal_places=2, blank=True, null=True)
    altura = models.DecimalField(max_digits=4, decimal_places=2, blank=True, null=True)
    eps = models.CharField(max_length=100, blank=True, null=True)
    objetivo = models.CharField(max_length=255, blank=True, null=True)
    
    # Información médica adicional
    tiene_lesion = models.BooleanField(default=False)
    descripcion_lesion = models.TextField(blank=True, null=True)
    tiene_procedimiento_medico = models.BooleanField(default=False)
    descripcion_procedimiento_medico = models.TextField(blank=True, null=True)

    def __str__(self):
        return f"{self.usuario.username} - {self.fecha_registro.strftime('%Y-%m-%d')}"

class Inscripcion(models.Model):
    cliente = models.ForeignKey(Cliente, on_delete=models.CASCADE)
    plan = models.ForeignKey(Plan, on_delete=models.CASCADE)
    fecha_inicio = models.DateField()
    fecha_fin = models.DateField()
    estado = models.CharField(max_length=20, choices=[('Activo', 'Activo'), ('Inactivo', 'Inactivo')])

    def __str__(self):
        return f'{self.cliente} - {self.plan}'

class InscripcionNutricional(models.Model):
    cliente = models.ForeignKey(Cliente, on_delete=models.CASCADE)
    plan_nutricional = models.ForeignKey(PlanNutricional, on_delete=models.CASCADE)
    fecha_inicio = models.DateField()
    fecha_fin = models.DateField()
    estado = models.CharField(max_length=20, choices=[('Activo', 'Activo'), ('Inactivo', 'Inactivo')])

    def __str__(self):
        return f'{self.cliente} - {self.plan_nutricional}'

class Transaccion(models.Model):
    cliente = models.ForeignKey(Cliente, on_delete=models.CASCADE)
    monto = models.DecimalField(max_digits=10, decimal_places=2)
    fecha = models.DateField(auto_now_add=True)
    descripcion = models.TextField(blank=True, null=True)

    def __str__(self):
        return f'{self.cliente} - {self.monto} - {self.fecha}'

class SeguimientoCliente(models.Model):
    cliente = models.ForeignKey(Cliente, on_delete=models.CASCADE)
    fecha = models.DateField()
    notas = models.TextField()

    def __str__(self):
        return f'{self.cliente} - {self.fecha}'


class Inventario(models.Model):
    nombre = models.CharField(max_length=100)
    cantidad = models.PositiveIntegerField()
    precio = models.DecimalField(max_digits=10, decimal_places=2)
    descripcion = models.TextField(blank=True, null=True)
    imagen = models.ImageField(upload_to='inventory_images/', blank=True, null=True)

    def __str__(self):
        return self.nombre

