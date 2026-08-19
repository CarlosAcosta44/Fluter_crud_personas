# Planeación de la Aplicación CRUD de Personas (Flutter + GetX)

Este documento sirve como guía para el desarrollo de la actividad del SENA, basado en los apuntes provistos.

## 1. Requerimientos del Proyecto
- **Frontend Móvil**: Flutter.
- **Gestor de Estado y Rutas**: GetX.
- **Backend API**: Python + FastAPI (alojado en un repositorio separado).
- **Base de Datos**: PostgreSQL alojada en Aiven.
- **Comunicación**: Paquete `http` para consumir la API REST.

## 2. Arquitectura de Carpetas (`lib/`)
Se seguirá una estructura basada en la separación de responsabilidades:
- `controllers/`: Contiene la lógica de negocio y estado con GetX (`persona_controller.dart`).
- `models/`: Contiene las clases de datos y su serialización desde/hacia JSON (`persona_model.dart`).
- `services/`: Contiene el acceso a la API externa (`api_service.dart`).
- `views/`: Contiene las pantallas completas de la aplicación:
  - `home_view.dart` (Inicio)
  - `persona_list_view.dart` (Lista de registros)
  - `persona_form_view.dart` (Formulario para crear/editar)
  - `persona_detail_view.dart` (Detalles de una persona)
- `widgets/`: Componentes de interfaz de usuario reutilizables (`persona_card.dart`).

## 3. Dependencias Principales (`pubspec.yaml`)
- `get`: ^4.6.6 (Inyección de dependencias, programación reactiva, manejo de estado y rutas).
- `http`: ^1.2.0 (Cliente nativo para comunicarse con la API del backend en `127.0.0.1:8000`).

## 4. Pantallas y Funcionalidad
1. **Inicio**: Botón para ingresar al CRUD.
2. **Listado**: Muestra las personas registradas. Se utiliza `Obx` (Observer) de GetX para hacerla reactiva.
3. **Formulario (Crear/Editar)**: Validación sencilla. Si se está editando, la "Identificación" no debe poder cambiarse (debe estar deshabilitada).
4. **Detalles**: Muestra toda la información de una persona seleccionada.
5. **Eliminar**: Debe presentar un cuadro de diálogo (Dialog) para confirmar si está seguro de eliminar el registro.

## 5. Metodología de Trabajo
Se utilizará **GitFlow** y **Git Semántico** para los commits:
- `main`: Producción.
- `develop`: Desarrollo.
- `feature/*`: Nuevas características.
- Commits semánticos: `feat`, `fix`, `docs`, `chore`, `refactor`, `style`.
