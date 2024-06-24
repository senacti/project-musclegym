<?php

use App\Http\Controllers\PrincipalController;
use App\Http\Controllers\ProfileController;
use App\Http\Controllers\RutinasController;
use App\Http\Controllers\TiendaController;
use Illuminate\Contracts\Auth\MustVerifyEmail;
use Illuminate\Support\Facades\DB;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "web" middleware group. Make something great!
|
*/

Route::get('/', function () {
    return view('welcome');
})->name('principal');

Route::get('/dashboard', function () {
    return view('dashboard');
})->middleware(['auth', 'verified'])->name('dashboard');

Route::get('/servicios', [PrincipalController::class, 'servicios'])->name('servicios.view');

Route::middleware('auth')->group(function () {
    Route::get('/profile', function(Request $request){
        return view('perfil.perfil', [
            'mustVerifyEmail' => $request->user() instanceof MustVerifyEmail,
            'status' => session('status'),
        ]);
    })->name('profile.edit');
    Route::patch('/profile', [ProfileController::class, 'update'])->name('profile.update');
    Route::delete('/profile', [ProfileController::class, 'destroy'])->name('profile.destroy');
});

Route::middleware(['auth'])->group(function(){
    Route::get('/rutinas', [RutinasController::class, 'mostrarRutinas'])->name('rutinas.show');
});

Route::middleware(['auth'])->group(function(){
    Route::get('/tienda', [TiendaController::class, 'mostrarTienda'])->name('tienda.show');
    Route::get('/tienda/membresias', [TiendaController::class, 'mostrarMembresias'])->name('membresias.show');
    
    Route::get('/tienda/productos', [TiendaController::class, 'mostrarProductos'])->name('productos.show');
    Route::post('/tienda/productos', [TiendaController::class, 'guardarProductos'])->name('productos.store');
    Route::delete('/tienda/productos', [TiendaController::class, 'eliminarProductos'])->name('delete.productos');
    Route::post('/comprar/productos/{id}', [TiendaController::class, 'comprarProducto'])->name('comprar.actualizar');
    
    Route::post('/tienda/membresias/{id}', [TiendaController::class, 'guardarMembresia'])->name('membresias.store');
    Route::put('/tienda/membresias/{id}', [TiendaController::class, 'actualizarFechaVenta'])->name('actualizar.fecha.venta');
    Route::delete('/tienda/membresias/{id}', [TiendaController::class, 'eliminarVenta'])->name('eliminar.venta');
    
});

Route::middleware(['auth', 'administrador'])->group(function(){
    Route::get('/reportes', [TiendaController::class, 'reportesView'])->name('reportes.view');
    Route::get('/reportes/descargar', [TiendaController::class, 'reporteDescarga'])->name('descargar.repoorte');
    Route::get('/reportes/descargar/productos', [TiendaController::class, 'reporteDescargaProductos'])->name('descargar.repoorte.productos');
});


require __DIR__.'/auth.php';
