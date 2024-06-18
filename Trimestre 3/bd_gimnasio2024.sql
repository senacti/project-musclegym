create database BD_Gimnasio2024;
use BD_Gimnasio2024;

create table Cliente(
ID_Cliente varchar(20) primary key not null,
p_Nombre Varchar (20) not null,
s_Nombre Varchar (20) null,
p_Apellido varchar(20) not null,
s_Apellido varchar(20) null,
Fecha_Nacimiento date not null,
Genero varchar (10) not null,
Telefono int not null,
Email varchar(30) not null,
Dirección varchar(30) not null,
Estado boolean not null
);
describe Cliente;
-- ---------------------------

create table Planes_nutricionales(
Id_plan_nutricional varchar (20) primary key not null,
Id_Cliente varchar(20) not null,
Calorias_Diarias int null,
Proteinas text null,
Carbohidtaros text null,
Grasas text null,
Estado boolean not null
);
describe Planes_nutricionales;
-- ---------------------------

create table Asistencias(
ID_Asistencia varchar (20) primary key not null,
ID_Cliente varchar (20) not null,
Fecha_asistencia datetime not null,
Estado boolean not null 
);
describe Asistencias;
-- ---------------------------
create table Rutinas(
ID_Rutina varchar(20) primary key not null,
ID_Cliente varchar (20) not null,
Fecha_Inicio datetime not null,
Fecha_Fin datetime not null,
Descripcion text not null,
Estado boolean not null
);
describe Rutinas;
-- ----------------------------

create table Valoracion(
ID_Evaluacion varchar(20) primary key not null,
ID_Cliente varchar(20) not null,
Fecha_Evaluacion datetime not null,
Peso int not null,
Indice_Masa_Corporal int not null,
Observaciones text not null,
Estado boolean not null
);
describe Valoracion;
-- ----------------------------

create table Ventas(
ID_Venta varchar(20) primary key not null,
ID_Cliente varchar(20) not null,
Fecha date not null,
Monto_o_Cantidad int not null,
ID_Membresia varchar(20) not null,
Estado boolean not null
);
describe Ventas;

-- ----------------------------
create table Membresia(
ID_Membresia varchar(20) primary key not null,
Tipo_Membresia varchar(20) not null,
Precio int not null,
descripcion text null,
Estado boolean not null
);
describe Membresia;

-- ---------------------------
create table Ventas_Productos(
ID_Venta_producto varchar(20) primary key,
ID_Venta varchar (20) not null,
ID_Producto varchar(20) not null,
Cantidad int null,
Subtotal int null,
Estado boolean not null
);
describe Ventas_Productos;

-- ---------------------------
create table Productos(
ID_Producto varchar(20) primary key not null,
Nombre varchar(20) not null,
Descripcion text null,
Precio int null,
Cantidad_disponible int null,
Proveedor varchar (20),
Estado boolean not null
);
describe Productos;

-- ---------------------------

create table Clases(
ID_Clase varchar(20) primary key not null,
Nombre varchar (20) not null,
Descripcion text null,
Horario datetime null,
Capacidad int null,
ID_Entrenador varchar(20) not null,
Estado boolean not null
);
describe Clases;

-- ----------------------------
Create table Entrenadores(
ID_Entrenador varchar(20) primary key not null,
p_nombre varchar (20) not null,
s_nombre varchar (20) null,
p_apellido varchar (20) not null,
s_apellido varchar (20) null,
Especialidad varchar(20) not null,
Telefono int not null,
Email varchar (30) not null,
Estado boolean not null
);
describe Entrenadores;

-- -----------------------------
create table Cliente_Entrenadores(
ID_Cliente_Entrenador varchar(20) primary key not null,
ID_Cliente varchar (20) not null,
ID_Entrenador varchar (20) not null,
Fecha_inicio date null,
Fecha_Fin date not null,
Estado boolean not null
);
describe Cliente_Entrenadores;

-- ------------------------------
create table Proveedores (
ID_Proveedor varchar(20) primary key not null, 
Nombre_Proveedor Varchar (20) not null,
Telefono int not null, 
Email varchar (50) not null,
Productos Varchar (20)not null,
Direccion varchar (30) null,
Codigo_Producto varchar(20),
Estado boolean not null
);

describe Proveedores; 

-- ------------------------------

create table Seguimiento (
ID_Seguimiento varchar (20) primary key not null, 
ID_Cliente varchar(20) not null,
Responsable varchar (20) not null
);

describe Seguimiento;
-- ----------------------

create table Servicio_Salud (
ID_Servicio_Salud varchar(20) primary key not null, 
ID_Cliente varchar(20) not null,
Historial_Medico text null
);

describe Servicio_Salud;

---------

create table Roles(
Id_rol varchar (20) primary key not null,
ID_cliente varchar (20) not null,
Descripcion varchar(20) not null
);

describe Roles;

-- ----------------------
alter table Asistencias
add foreign key (ID_Cliente) references Cliente(ID_Cliente);

alter table Rutinas
add foreign key (ID_Cliente) references Cliente(ID_Cliente);

alter table Valoracion
add foreign key (ID_Cliente) references Cliente(ID_Cliente);

alter table Ventas
add foreign key (ID_Cliente) references Cliente(ID_Cliente);

alter table Ventas
add foreign key (ID_Membresia) references Membresia(ID_Membresia);

alter table Ventas_Productos
add foreign key (ID_Venta) references Ventas(ID_Venta);

alter table Ventas_Productos
add foreign key (ID_Producto) references Productos(ID_Producto);

alter table Cliente_Entrenadores
add foreign key (ID_Cliente) references Cliente(ID_Cliente);

alter table Cliente_Entrenadores
add foreign key (ID_Entrenador) references Entrenadores(ID_Entrenador);

alter table Clases
add foreign key (ID_Entrenador) references Entrenadores(ID_Entrenador);

alter table Proveedores
add foreign key (Codigo_Producto) references Productos (ID_Producto);

alter table Planes_nutricionales
add foreign key (Id_cliente) references Cliente (ID_cliente);

alter table Seguimiento
add foreign key (Id_cliente) references Cliente (ID_cliente);

alter table Servicio_Salud
add foreign key (Id_cliente) references Cliente (ID_cliente);

alter table Roles
add foreign key (Id_cliente) references Cliente (ID_cliente);

-- con Insert Into ingresamos los datos de lo usuarios en el orden que lo requerimos para alimentra la base de datos.


INSERT INTO Cliente (ID_Cliente, p_Nombre, s_Nombre, p_Apellido, s_Apellido, Fecha_Nacimiento, Genero, Telefono, Email, Dirección, Estado) values (1234,'Juan','Alberto','Palacios', 'Gutierrez', '1999-10-16','Masculino', 6041234, 'japg@gmail.com', 'calle falsa 123', '1');
INSERT INTO Cliente (ID_Cliente, p_Nombre, s_Nombre, p_Apellido, s_Apellido, Fecha_Nacimiento, Genero, Telefono, Email, Dirección, Estado) values (5678,'Ana','Maria','Ruiz', 'Camacho', '2006-11-21','Femenino', 6051235, 'amrc@gmail.com', 'calle real 123', '1');
INSERT INTO Cliente (ID_Cliente, p_Nombre, s_Nombre, p_Apellido, s_Apellido, Fecha_Nacimiento, Genero, Telefono, Email, Dirección, Estado) values (9012,'Miguel','Angel','Suarez', 'peña', '2002-01-30','Masculino', 6061236, 'masp@gmail.com', 'calle media 456', '0');
INSERT INTO Cliente (ID_Cliente, p_Nombre, p_Apellido, s_Apellido, Fecha_Nacimiento, Genero, Telefono, Email, Dirección, Estado) values (3456,'Karen','Sanchez', 'Gomez', '1995-12-24','Femenino', 6071237, 'ksg@gmail.com', 'calle media 789', '1');
INSERT INTO Cliente (ID_Cliente, p_Nombre, s_Nombre, p_Apellido, s_Apellido, Fecha_Nacimiento, Genero, Telefono, Email, Dirección, Estado) values (7890,'Andres','Felipe','Perez', 'Ruiz', '2000-09-06','Masculino', 6081238, 'afpr@gmail.com', 'calle falsa 145', '0');
INSERT INTO Cliente (ID_Cliente, p_Nombre, s_Nombre, p_Apellido, s_Apellido, Fecha_Nacimiento, Genero, Telefono, Email, Dirección, Estado) values (2345,'Ricardo','Jorge','Sarmiento', 'Angulo', '2001-06-30','Masculino', 6081239, 'rjsa@gmail.com', 'calle falsa 146', '1');
INSERT INTO Cliente (ID_Cliente, p_Nombre, s_Nombre, p_Apellido, s_Apellido, Fecha_Nacimiento, Genero, Telefono, Email, Dirección, Estado) values (6789,'Camila','Andrea','Gutierrez', 'Lopez', '1987-05-12','Femenino', 6081240, 'cagl@gmail.com', 'calle falsa 147', '1');
INSERT INTO Cliente (ID_Cliente, p_Nombre, s_Nombre, p_Apellido, s_Apellido, Fecha_Nacimiento, Genero, Telefono, Email, Dirección, Estado) values (1111,'Maria','paula','Talero', 'Gracia', '2002-05-09','Femenino', 6081241, 'mptg@gmail.com', 'calle falsa 148', '1');
INSERT INTO Cliente (ID_Cliente, p_Nombre, s_Nombre, p_Apellido, s_Apellido, Fecha_Nacimiento, Genero, Telefono, Email, Dirección, Estado) values (1122,'Brayan','white','Oconner', 'Toreto', '1986-05-13','Masculino', 6081242, 'bwot@gmail.com', 'calle real 149', '1');
INSERT INTO Cliente (ID_Cliente, p_Nombre, s_Nombre, p_Apellido, s_Apellido, Fecha_Nacimiento, Genero, Telefono, Email, Dirección, Estado) values (1133,'Juan','Esteban','Soche', 'Lopez', '1985-04-01','Masculino', 6081243, 'jesl@gmail.com', 'calle real 150', '0');

select * from cliente;

INSERT INTO rutinas (ID_Rutina, ID_Cliente, Fecha_Inicio, Fecha_Fin, Descripcion, Estado ) values (301,1234, '2024-03-24', '2024-04-23 00:00:00', 'Pierna', 1 ); 
INSERT INTO rutinas (ID_Rutina, ID_Cliente, Fecha_Inicio, Fecha_Fin, Descripcion, Estado ) values (302,5678, '2024-03-12', '2024-04-11 00:00:00', 'Brazo', 1 );
INSERT INTO rutinas (ID_Rutina, ID_Cliente, Fecha_Inicio, Fecha_Fin, Descripcion, Estado ) values (303,9012, '2024-02-12', '2024-03-11 00:00:00', 'Espalda', 0 );
INSERT INTO rutinas (ID_Rutina, ID_Cliente, Fecha_Inicio, Fecha_Fin, Descripcion, Estado ) values (304,3456, '2024-03-16', '2024-04-15 00:00:00', 'Brazo', 1 );
INSERT INTO rutinas (ID_Rutina, ID_Cliente, Fecha_Inicio, Fecha_Fin, Descripcion, Estado ) values (305,7890, '2024-01-08', '2024-02-07 00:00:00', 'Espalda', 0 );
INSERT INTO rutinas (ID_Rutina, ID_Cliente, Fecha_Inicio, Fecha_Fin, Descripcion, Estado ) values (306,2345, '2024-03-25', '2024-04-24 00:00:00', 'Brazo', 1 );
INSERT INTO rutinas (ID_Rutina, ID_Cliente, Fecha_Inicio, Fecha_Fin, Descripcion, Estado ) values (307,6789, '2024-03-08', '2024-04-07 00:00:00', 'Pierna', 1 );
INSERT INTO rutinas (ID_Rutina, ID_Cliente, Fecha_Inicio, Fecha_Fin, Descripcion, Estado ) values (308,1111, '2024-03-18', '2024-04-17 00:00:00', 'Espalda', 1 );
INSERT INTO rutinas (ID_Rutina, ID_Cliente, Fecha_Inicio, Fecha_Fin, Descripcion, Estado ) values (309,1122, '2024-03-21', '2024-04-20 00:00:00', 'Brazo', 1 );
INSERT INTO rutinas (ID_Rutina, ID_Cliente, Fecha_Inicio, Fecha_Fin, Descripcion, Estado ) values (310,1133, '2024-01-08', '2024-02-08 00:00:00', 'pierna', 0 );

select * from rutinas;

INSERT INTO servicio_salud (ID_Servicio_Salud, ID_Cliente, Historial_Medico) values(601, 1234, 'Hipertension' );
INSERT INTO servicio_salud (ID_Servicio_Salud, ID_Cliente, Historial_Medico) values(602, 5678, 'Esguince rodilla izq' );
INSERT INTO servicio_salud (ID_Servicio_Salud, ID_Cliente, Historial_Medico) values(603, 9012, 'Ninguna' );
INSERT INTO servicio_salud (ID_Servicio_Salud, ID_Cliente, Historial_Medico) values(604, 3456, 'Escoliosis' );
INSERT INTO servicio_salud (ID_Servicio_Salud, ID_Cliente, Historial_Medico) values(605, 7890, 'Manguito rotador Der' );
INSERT INTO servicio_salud (ID_Servicio_Salud, ID_Cliente, Historial_Medico) values(606, 2345, 'Ninguna' );
INSERT INTO servicio_salud (ID_Servicio_Salud, ID_Cliente, Historial_Medico) values(607, 6789, 'Hipertension' );
INSERT INTO servicio_salud (ID_Servicio_Salud, ID_Cliente, Historial_Medico) values(608, 1111, 'Ninguna' );
INSERT INTO servicio_salud (ID_Servicio_Salud, ID_Cliente, Historial_Medico) values(609, 1122, 'Escoliosis' );
INSERT INTO servicio_salud (ID_Servicio_Salud, ID_Cliente, Historial_Medico) values(610, 1133, 'Ninguna' );

select * from servicio_salud ;


INSERT INTO ventas (ID_Venta, ID_Cliente, Fecha, Monto_o_Cantidad, ID_membresia, Estado) values(101, 1234, '2024-03-24', 90000, 401, 1 );
INSERT INTO ventas (ID_Venta, ID_Cliente, Fecha, Monto_o_Cantidad, ID_membresia, Estado) values(102, 5678, '2024-03-12', 160000, 402, 1 );
INSERT INTO ventas (ID_Venta, ID_Cliente, Fecha, Monto_o_Cantidad, ID_membresia, Estado) values(103, 9012, '2024-02-12', 90000, 401, 0 );
INSERT INTO ventas (ID_Venta, ID_Cliente, Fecha, Monto_o_Cantidad, ID_membresia, Estado) values(104, 3456, '2024-03-16', 160000, 402, 1 );
INSERT INTO ventas (ID_Venta, ID_Cliente, Fecha, Monto_o_Cantidad, ID_membresia, Estado) values(105, 7890, '2024-01-08', 90000, 401, 0 );
INSERT INTO ventas (ID_Venta, ID_Cliente, Fecha, Monto_o_Cantidad, ID_membresia, Estado) values(106, 2345, '2024-03-25', 400000, 403, 1 );
INSERT INTO ventas (ID_Venta, ID_Cliente, Fecha, Monto_o_Cantidad, ID_membresia, Estado) values(107, 6789, '2024-03-08', 90000, 401, 1 );
INSERT INTO ventas (ID_Venta, ID_Cliente, Fecha, Monto_o_Cantidad, ID_membresia, Estado) values(108, 1111, '2024-03-18', 160000, 402, 1 );
INSERT INTO ventas (ID_Venta, ID_Cliente, Fecha, Monto_o_Cantidad, ID_membresia, Estado) values(109, 1122, '2024-03-21', 90000, 401, 1 );
INSERT INTO ventas (ID_Venta, ID_Cliente, Fecha, Monto_o_Cantidad, ID_membresia, Estado) values(110, 1133, '2024-01-08', 90000, 401, 0 );

select * from ventas;

INSERT INTO membresia (ID_Membresia, Tipo_Membresia, Precio, descripcion, Estado) values(401, 'CrossFit', 90000 , ' Entrenamiento CrossFit semanal', 1 );
INSERT INTO membresia (ID_Membresia, Tipo_Membresia, Precio, descripcion, Estado) values(402, 'SemiPerson', 160000 , ' Entrenamiento Semipersonalizdo 3 dias,2 CrossFit', 1 );
INSERT INTO membresia (ID_Membresia, Tipo_Membresia, Precio, descripcion, Estado) values(403, 'Personalizado', 400000 , ' Entrenamiento Personalizado todo el mes', 1 );
select * from membresia;

-- ejemplos de utilización de los Join:

-- left join--
select c.ID_Cliente, c.p_Nombre, c.p_Apellido, r.Descripcion  from cliente c left join rutinas r on c.ID_Cliente = r.ID_Cliente;
-- Right join --
select c.ID_Cliente, c.p_Nombre, c.p_Apellido, r.Descripcion  from cliente c right join rutinas r on c.ID_Cliente = r.ID_Cliente;
-- Inner join --
select c.ID_Cliente, c.p_Nombre, c.p_Apellido, r.Descripcion  from cliente c inner join rutinas r on c.ID_Cliente = r.ID_Cliente;
-- cross join --
select c.Id_Cliente, c.p_Nombre, r.ID_Rutina, r.ID_Cliente from cliente c cross join rutinas r;

-- Consulta utilizando Join para la presentación
-- En este ejemplo mezclamos 3 tablas, tomando como principal la de clientes y las unimos con ventas y membresia,
-- arrojandonos datos del cliente su estado, cuanto pago y que tipo de membresia es.

select * From Cliente
left join ventas ON cliente.id_Cliente = ventas.ID_Cliente
left join membresia on ventas.id_cliente = membresia.ID_membresia;


-- TRIGGER  --
-- creamos una tabla de ejemplo llamada acciones 
-- la palabra reservada current_timestamp es un comando que nos almacena automaticamente la hora de modificación en el datatime

CREATE TABLE Acciones (
  ID_Acciones INT  primary key NOT NULL AUTO_INCREMENT,
  Accion VARCHAR(50) NULL,
  Fecha DATETIME NULL DEFAULT CURRENT_TIMESTAMP
);

-- Una vez creada la tabla definimos el trigger con delimiter//  en este cada vez que registremos un dato en valoracion, 
-- va a alimentar la tabla acciones registrandonos fecha y hora del dato generado 

delimiter //
create trigger log_tabla_valoracion after insert on valoracion
for each row begin
    insert into Acciones (Accion) value ('Se creo un nuevo registro en la tabla valoracion');
end//
delimiter ;

INSERT INTO valoracion (ID_Evaluacion, ID_Cliente, Fecha_Evaluacion, peso, Indice_Masa_Corporal, Observaciones, Estado) values(801, 7890, '2024-01-14 10:00:00', 72, 61, 'aceptable', 1 );
INSERT INTO valoracion (ID_Evaluacion, ID_Cliente, Fecha_Evaluacion, peso, Indice_Masa_Corporal, Observaciones, Estado) values(802, 1234, '2024-01-16 11:00:00', 81, 65, 'aceptable', 1 );

select * from Acciones;

-- ROLES Y PERMISOS --

create user 'UserAdmin'@'localhost' identified by 'gaes2';
grant all privileges on * . * to 'UserAdmin'@'localhost';
flush privileges;
create user 'AdminGym'@'localhost' identified by 'levelgym';
grant all privileges on bd_gimnasio2024 . * to 'AdminGym'@'localhost';
flush privileges;

select * from mysql.user;

-- PROCEDIMIENTOS ALMACENADOS -- 
-- con este procedimiento es posible crear y almacenar funciones si necesidad de escribir su codigo,
-- en este ejemplo creamos 2 procedimientos alimentados en la tabla de clientes para saber quienes estan activos y quienes inactivos.

-- drop lo usamos para borrar los procedimientos si por ejemplo temenos que corregirlos.

drop procedure Clientes_Inactivos;
drop procedure Clientes_Activos;

-- Acá creamos el procedimiento definiendo el rango con el delimiter// 
-- para el ejemplo definimo que va a buscar un valor char en la tabla estado, en este caso sera '1' para clientes activos y '0' para clientes inactivos
-- del ejemplo dejamos definido el concat por si utilizaramos una letra para buscar un dato, sin importar la posicion en la que este al marcarla con el porcentaje,
-- esto lo dejamos definido solo como ejemplo para proximas consultas.

delimiter //
create procedure Clientes_Inactivos(in letra char)
begin 
select * from Cliente
where estado like concat('%',letra,'%');
end//
delimiter ;
call Clientes_Inactivos('0');

delimiter //
create procedure Clientes_Activos(in letra char)
begin 
select * from Cliente
where estado like concat('%',letra,'%');
end//
delimiter ;
call Clientes_Activos('1');





