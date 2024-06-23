@extends('layouts.layout')

@section('content')

<section class="home">
    <div class="max-width">
        <div class="home-content">
            @if(Auth::user()->rol == 2)
                <div style="display: flex; gap: 20px">
                    @foreach ($rutinasUsuario as $rutina)
        
                        <div style="width: 200px; height: 200px; background-color: tomato; display: flex; flex-direction: column; align-items: center; border-radius: 20px">
                            <h4 style="text-align: center; font-size: 50px">{{$rutina->Descripcion}}</h4>
                            @if ($rutina->Descripcion === "Pierna")
                                <img src="{{ asset('storage/rutinas/pierna.png') }}" style="width: 100px; height: 100px;" />
                            @else
                            <img src="{{ asset('storage/rutinas/brazo.png') }}" style="width: 100px; height: 100px;" />
                            @endif
                        </div>
                    
                    @endforeach
                </div>
            @else
                <p>Administrador</p>
            @endif
        </div>
    </div>
</section>
@endsection