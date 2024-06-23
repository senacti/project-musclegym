<style>
    
</style>

<header class="header">
    <a href="#" class="Logo">
        <i class="fas fa-dumbbell"></i><b style="color: black">MuscleGym</b> </a
    >
    <nav class="navbar">
        <a href="{{route('principal')}}">Inicio</a>
        <!--Home-->
        <a href="{{route('servicios.view')}}">Servicios</a>
        <!--services-->
        @guest
            <a href="error404.html">Contacto</a>
        @endguest
        @auth
            <a href="{{ route('reportes.view') }}">Reportes</a>
        @endauth
        <!--contact-->
        @guest
            <a href="error500.html">Nosotros</a>
        @endguest

        @auth
            <a href="{{ route('tienda.show') }}">Tienda</a>
        @endauth
        {{-- Rutinas --}}
        <a href="{{ route('rutinas.show') }}">Rutinas</a>
        <!--pricing-->
        <a href="#">|</a>


        @guest
            <a href="{{ route('login') }}" class="btn">Inicia sesión</a>
            <!--Login-->
            <a href="{{route('register')}}" class="btn"> Registrate</a>
        @endguest

        @auth
   
        <div class="dropdown">
            <button class="dropbtn">
                {{ Auth::user()->name }}
            </button>
            <div class="dropdown-content">
                <form method="POST" action="{{ route('logout') }}">
                    @csrf
                    <a href="{{ route('logout') }}" onclick="event.preventDefault(); this.closest('form').submit();">
                        Cerrar Sesion
                    </a>
                </form>
              <a href="{{route('profile.edit')}}">Perfil</a>
            </div>
          </div>
        @endauth

        <!--sign up-->
    </nav>
</header>