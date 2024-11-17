# TaksApp 📝

TaksApp es una aplicación desarrollada en Flutter para la gestión eficiente de tareas. Esta app sigue la **Clean Architecture**, utilizando `Bloc` como gestor de estados para garantizar modularidad, escalabilidad y mantenibilidad. Está diseñada para ofrecer una experiencia de usuario rápida y fluida, asegurando persistencia local de datos y flujos intuitivos para usuarios registrados y nuevos.

## 🚀 Características Principales

- **Gestión de Tareas**: Crear, editar, eliminar,visualizar y marcar tareas como completadas.
- **Persistencia de Datos**: Usa `SharedPreferences` para almacenar las tareas localmente.
- **Navegación Declarativa**: Implementada con `go_router`.
- **Interfaz Moderna**: Diseñada con componentes reutilizables y accesibles.
- **Gestor de estados**: Usa `flutter_bloc` para la gestión de estados.

---

## 🛠️ Tecnologías Utilizadas

| Herramienta         | Versión         | Descripción                             |
|---------------------|----------------|-----------------------------------------|
| **Flutter**         | 3.24.3         | Framework para desarrollo multiplataforma. |
| **Bloc**            | ^8.1.16         | Gestor de estados basado en patrones reactivos. |
| **SharedPreferences** | ^2.3.3      | Persistencia local para datos clave-valor. |
| **go_router**       | ^14.6.0         | Navegación declarativa y dinámica.       |
| **equatable**       | ^2.0.5         | Comparación de objetos para estados y entidades. |

---

## 📂 Estructura del Proyecto

El proyecto sigue la **Clean Architecture**, dividiendo la lógica en tres capas principales:

1. **Core**
   - Contiene configuraciones globales, temas, utilidades y constantes.
   - Incluye herramientas como `AppStorage` para la persistencia centralizada de datos.
   - Servicios o integraciones externas como `SharedPreferences`.

2. **Features**:
   Cada funcionalidad está separada por módulo:
   - **Data**: Fuentes de datos (`DataSources`) y repositorios.
   - **Domain**: Casos de uso (`UseCases`) y entidades.
   - **Presentation**: Widgets, páginas y blocs específicos.

---

## ⚙️ Pasos para Ejecutar el Proyecto

Sigue estos pasos para configurar y ejecutar el proyecto en tu entorno local:

1. **Clonar el Repositorio**
git clone <URL_DEL_REPOSITORIO>
cd taks_app
2. **Limpiar caché**:
flutter clean
3. **Instalar dependencia**:
flutter pub get
flutter run
4. **Ejecutar la aplicación**:
flutter run

## ⚙️ Requisitos previos

Herramientas necesarias

- **Futter SDK**: Versión 3.24.3 o superior.
- **Entorno de desarrollo**: Android Studio o Visual Studio Code

## 📷 Capturas de Pantalla

### Home Page

_Captura que muestra las tareas, barra de navegación inferior y menú superior._

![Home Page](assets/images/home_app.png)

---

### Task Page

_Pantalla para mostrar las tareas registradas y su estado actual._

![Task Page](assets/images/task_app.png)

### Profile Page

_Pantalla para ver los datos de usuario._

![Profile Page](assets/images/profile_app.png)

### Details Page

_Pantalla para ver los detalles especificos de cada tarea._

![Profile Page](assets/images/details_task.png)

---

## 🔮 Próximas Funcionalidades

Estamos trabajando en nuevas características para mejorar la experiencia del usuario en **TaksApp**. Algunas de las funcionalidades planeadas incluyen:

### 🔒 Inicio de Sesión con PIN

- Implementación de un flujo seguro para el inicio de sesión utilizando un PIN personalizado.
- Opción para recuperar o restablecer el PIN en caso de olvido.

### 🔔 Módulo de Notificaciones

- Recordatorios para tareas pendientes con notificaciones en tiempo real.
- Configuración de preferencias de notificaciones (silenciosas, horarios, etc.).
- Historial de notificaciones recientes.

### ⚙️ Módulo de Configuración

- Personalización de la aplicación, incluyendo temas claros/oscuros.
- Configuración de preferencias de usuario.

### 🧑‍💼 Actualización de Datos Personales

- Edición de información personal, como nombre de usuario y correo electrónico.
- Funcionalidad para cerrar sesión de manera segura.
- Reinicio de la aplicación a su estado inicial (reset).

---

¡Mantente atento a las próximas actualizaciones para disfrutar de estas nuevas funcionalidades!
