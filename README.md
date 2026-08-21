# Frontend Flutter CRUD Personas

Aplicación frontend desarrollada en Flutter con GetX para la gestión de personas (CRUD), consumiendo la API RESTful del backend en FastAPI y PostgreSQL (Supabase). Desarrollada como parte de la actividad del SENA "APP Gestión Personas".

## Requisitos Previos

- Flutter SDK (versión 3.x o superior)
- Dart SDK
- Backend en FastAPI configurado e iniciado (puerto 8000 por defecto)

## Estructura del Proyecto

```text
lib/
├── controllers/    # Controladores de estado con GetX (PersonaController)
├── models/         # Modelos de datos (PersonaModel)
├── services/       # Servicios de red (ApiService - HTTP)
├── validations/    # Validaciones de formularios
├── views/          # Pantallas de la aplicación (Home, List, Form, Detail)
├── widgets/        # Componentes UI reutilizables
└── main.dart       # Punto de entrada de la aplicación
```

## Configuración y Ejecución

### 1. Instalar dependencias

Asegúrate de obtener las dependencias de Flutter ejecutando:

```bash
flutter pub get
```

### 2. Ejecutar la aplicación Flutter

Puedes ejecutar la aplicación en el dispositivo o plataforma de tu elección:

- **Linux Desktop:**
  ```bash
  flutter run -d linux
  ```

- **Navegador Web (Chrome / Brave):**
  ```bash
  flutter run -d chrome
  ```

### 3. Ejecutar todo el sistema (Backend + Frontend) con un solo comando 🚀

Para facilitar las pruebas de integración local, se incluye un script ejecutable (`run_app.sh`) en la raíz del proyecto que levanta el backend FastAPI en segundo plano y lanza la aplicación de Flutter simultáneamente:

```bash
./run_app.sh
```

> **Nota:** Al cerrar la aplicación Flutter, el script detendrá automáticamente el proceso del backend.

## Integración con la API Backend

La aplicación realiza peticiones HTTP a la API alojada en `http://127.0.0.1:8000/api/personas`:

- **GET `/api/personas`**: Obtiene la lista completa de personas.
- **GET `/api/personas/{identificacion}`**: Busca una persona por número de identificación.
- **POST `/api/personas`**: Registra una nueva persona.
- **PUT `/api/personas/{id}`**: Actualiza los datos de una persona existente.
- **DELETE `/api/personas/{id}`**: Elimina una persona de la base de datos.
