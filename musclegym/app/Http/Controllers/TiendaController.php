<?php

namespace App\Http\Controllers;

use Barryvdh\DomPDF\Facade\Pdf;
use Carbon\Carbon;
use Dompdf\Dompdf;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;

class TiendaController extends Controller
{
    public function mostrarTienda(){
        return view('tienda/tienda');
    }

    public function mostrarMembresias(){
        // DB::table('users')
        //     ->select('users.id','users.name','profiles.photo')
        //     ->join('profiles','profiles.id','=','users.id')
        //     ->where(['something' => 'something', 'otherThing' => 'otherThing'])
        //     ->get();
        $datos = [
            'membresias' => DB::table('membresia')->get(),
            'ventas' => DB::table('ventas')->join('users', 'users.id', '=', 'ventas.ID_Cliente')->select('ventas.ID_Cliente', 'ventas.ID_Venta', 'ventas.Monto_o_Cantidad', 'users.name', 'ventas.ID_Membresia', 'ventas.Fecha')->get()
        ];
        return view('tienda/membresias', $datos);
    }

    public function guardarMembresia($id){
        date_default_timezone_set('America/Bogota');
        try {

            $consulta = DB::table('ventas')->where('ID_Cliente', Auth::user()->id)->where('ID_Membresia', $id)->exists();
            if($consulta){
                return back()->with('membresiaMensaje', 'Ya cuenta con esta Membresia');
            }
            else{
                $idVenta = DB::table('ventas')->orderBy('ID_Venta', 'desc')->first();
                $datos = [
                    'ID_Venta' => intval($idVenta->ID_Venta) + 1,
                    'ID_Cliente' => Auth::user()->id,
                    'Fecha' => Carbon::now(),
                    'Monto_o_Cantidad' => $id == 401 ? 90000 : ($id == 402 ? 160000 : 400000),
                    'ID_Membresia' => $id,
                    'Estado' => 1
                ];
                DB::table('ventas')->insert($datos);
    
                return back()->with('membresiaMensaje', 'Se creo la membresia');

            }
            
        } catch (\Exception $e) {
            logs($e->getMessage());
            return back()->with('membresiaMensaje', 'Ocurrio un error');
        }
    }

    public function actualizarFechaVenta($id){
        try {
            $membresia = DB::table('ventas')->where('ID_Venta', $id)->value('Fecha');
            if($membresia == Carbon::now()->format('Y-m-d')){
                return back()->with('administradorMensajes', 'La fecha ya es la actual');
            }
            else{
                DB::table('ventas')->where('ID_Venta', $id)->update([
                    'Fecha' => Carbon::now()
                ]);
                return back()->with('administradorMensajes', 'Se actualizo la fecha de membresia');
            }
        } catch (\Exception $e) {
            logs($e->getMessage());
            return back()->with('administradorMensajes', 'Ocurrio un error');
        }
    }

    public function eliminarVenta($id){
        try {
            DB::table('ventas')->where('ID_Venta', $id)->delete();
            return back()->with('administradorMensajes', 'Se elimino la membresia correctamente');
        } catch (\Exception $e) {
            logs($e->getMessage());
            return back()->with('administradorMensajes', 'Ocurrio un error');
        }
    }


    public function reportesView(){
        return view('reportes/reportes');
    }

    public function reporteDescarga(Request $request){
        try {
            $inicio = $request->fechaInicio;
            $fin = $request->fechaFin;
            $ventas = DB::table('ventas')->whereDate('Fecha', '>=', $inicio)->whereDate('Fecha', '<=', $fin)->get();

            $pdf = Pdf::loadView('reportes.reporteGenerado', compact('ventas'));
            return $pdf->download('reporteLibros.pdf');
        } catch (\Exception $e) {
            logs($e->getMessage());
            return back()->with('mensajeReporte', 'Ocurrio un error');
        }
    }
}
