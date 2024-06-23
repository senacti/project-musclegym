<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;

class RutinasController extends Controller
{
    public function mostrarRutinas(){
        $datos = [
            'rutinasUsuario' => DB::table('rutinas')->where('ID_Cliente', Auth::user()->id)->get(),
        ];

        return view('rutinas/rutina', $datos);
    }
}
