from django.contrib import admin
from .models import Plan, PlanNutricional, Inventario, Cliente, Inscripcion, InscripcionNutricional, Transaccion, SeguimientoCliente
from django.utils.html import format_html
from import_export import resources
from import_export.admin import ImportExportModelAdmin

# Registro del modelo Plan
@admin.register(Plan)
class PlanAdmin(ImportExportModelAdmin):
    list_display = ('nombre', 'descripcion', 'precio', 'duracion')
    search_fields = ('nombre', 'descripcion')

# Registro del modelo PlanNutricional
@admin.register(PlanNutricional)
class PlanNutricionalAdmin(ImportExportModelAdmin):
    list_display = ('nombre', 'descripcion', 'precio', 'duracion')
    search_fields = ('nombre', 'descripcion')

# Registro del modelo Inventario
@admin.register(Inventario)
class InventarioAdmin(ImportExportModelAdmin):
    list_display = ('nombre', 'cantidad', 'precio', 'imagen_tag')
    search_fields = ('nombre', 'descripcion')

    def imagen_tag(self, obj):
        if obj.imagen:
            return format_html('<img src="{}" style="width: 100px; height: auto;" />', obj.imagen.url)
        return "-"
    
    imagen_tag.short_description = 'Imagen'
    

# Registro del modelo Cliente
@admin.register(Cliente)
class ClienteAdmin(ImportExportModelAdmin):
    list_display = ('usuario', 'telefono', 'direccion', 'fecha_nacimiento', 'fecha_registro')
    search_fields = ('usuario__username', 'telefono', 'direccion')

# Registro del modelo Inscripcion
@admin.register(Inscripcion)
class InscripcionAdmin(ImportExportModelAdmin):
    list_display = ('cliente', 'plan', 'fecha_inicio', 'fecha_fin', 'estado')
    list_filter = ('estado', 'fecha_inicio', 'fecha_fin')
    search_fields = ('cliente__usuario__username', 'plan__nombre')

# Registro del modelo InscripcionNutricional
@admin.register(InscripcionNutricional)
class InscripcionNutricionalAdmin(ImportExportModelAdmin):
    list_display = ('cliente', 'plan_nutricional', 'fecha_inicio', 'fecha_fin', 'estado')
    list_filter = ('estado', 'fecha_inicio', 'fecha_fin')
    search_fields = ('cliente__usuario__username', 'plan_nutricional__nombre')

# Registro del modelo Transaccion
@admin.register(Transaccion)
class TransaccionAdmin(ImportExportModelAdmin):
    list_display = ('cliente', 'monto', 'fecha', 'descripcion')
    search_fields = ('cliente__usuario__username', 'descripcion')

# Registro del modelo SeguimientoCliente
@admin.register(SeguimientoCliente)
class SeguimientoClienteAdmin(ImportExportModelAdmin):
    list_display = ('cliente', 'fecha', 'notas')
    search_fields = ('cliente__usuario__username', 'notas')
