<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MuscleGym</title>
    <link rel="preconnect" href="https://fonts.bunny.net">
    {{-- <link href="https://fonts.bunny.net/css?family=figtree:400,600&display=swap" rel="stylesheet" /> --}}
    <link rel="stylesheet" href="{{ asset('css/style.css') }}" />
</head>
<body style="background: url({{ asset('storage/imagenes/index.png') }}) no-repeat; background-position: top">

    @include('layouts.header')

    @yield('content')
</body>
</html>