# SaborExpress

## Descripción del Proyecto

SaborExpress es una plataforma moderna de delivery inspirada en aplicaciones como Rappi y sistemas de domicilios para restaurantes.

El proyecto tiene como objetivo ofrecer una solución completa para pedidos de comida en línea, gestión de entregas, pagos digitales y seguimiento en tiempo real.

El sistema está dividido en múltiples módulos para mantener una arquitectura profesional, organizada y escalable.

---

# Objetivo Principal

Desarrollar una aplicación de delivery moderna y escalable que permita a los usuarios:

- Visualizar productos
- Realizar pedidos
- Realizar pagos en línea
- Rastrear pedidos en tiempo real
- Gestionar restaurantes y productos
- Administrar la plataforma desde un panel administrativo

---

# Estructura del Proyecto

```txt
SaborExpress/

├── frontend-web/
├── mobile-app/
├── backend/
├── database/
├── docs/
└── README.md
```

---

# Módulos del Sistema

## 1. Frontend Web

Este módulo contiene:

- Panel administrativo
- Página principal del negocio
- Gestión de productos
- Gestión de pedidos
- Dashboard de estadísticas

### Tecnologías

- Next.js
- TypeScript
- TailwindCSS
- shadcn/ui

### Next.js

#### ¿Qué es?

Es un framework moderno para construir aplicaciones web utilizando React.

#### ¿Por qué se utiliza?

- Alto rendimiento
- Optimización SEO
- Arquitectura profesional
- Escalable para proyectos grandes

#### Función en este proyecto

- Panel administrativo
- Página del restaurante
- Catálogo de productos
- Gestión de pedidos

---

### TypeScript

#### ¿Qué es?

Es una versión tipada de JavaScript.

#### ¿Por qué se utiliza?

- Reduce errores
- Organiza mejor el código
- Facilita mantenimiento
- Escalable para proyectos grandes

#### Función en este proyecto

- Manejo de usuarios
- Validación de pedidos
- Modelos de pagos
- Estructura de productos

---

### TailwindCSS

#### ¿Qué es?

Framework CSS basado en utilidades.

#### ¿Por qué se utiliza?

- Desarrollo rápido de interfaces
- Diseño responsive
- Código limpio
- Diseño moderno

#### Función en este proyecto

- Botones
- Formularios
- Cards
- Menús
- Diseño adaptable

---

### shadcn/ui

#### ¿Qué es?

Librería moderna de componentes para React.

#### ¿Por qué se utiliza?

- Componentes reutilizables
- Interfaz profesional
- Desarrollo más rápido

#### Función en este proyecto

- Modales
- Tablas
- Formularios
- Diálogos
- Filtros

---

# 2. Aplicación Móvil

Este módulo contiene:

- Aplicación cliente
- Aplicación repartidor

### Tecnologías

- React Native
- Expo

### React Native

#### ¿Qué es?

Framework para construir aplicaciones móviles usando JavaScript y React.

#### ¿Por qué se utiliza?

- Un solo código para Android e iOS
- Desarrollo más rápido
- Gran comunidad

#### Función en este proyecto

- Visualización de productos
- Carrito de compras
- Seguimiento de pedidos
- GPS y ubicación

---

### Expo

#### ¿Qué es?

Plataforma que facilita el desarrollo con React Native.

#### ¿Por qué se utiliza?

- Pruebas rápidas
- Publicación sencilla
- Integración con APIs móviles

#### Función en este proyecto

- Notificaciones push
- Acceso GPS
- Cámara
- Compilación Android/iOS

---

# 3. Backend

El backend es el núcleo principal del sistema.

Aquí se administran:

- Usuarios
- Pedidos
- Productos
- Pagos
- Direcciones
- Autenticación

### Tecnología

- Supabase

### Supabase

#### ¿Qué es?

Plataforma backend basada en PostgreSQL.

#### ¿Por qué se utiliza?

- Desarrollo rápido
- APIs automáticas
- Sistema de autenticación
- Tiempo real
- Almacenamiento en la nube

#### Función en este proyecto

- Inicio de sesión
- Base de datos
- Gestión de pedidos
- Productos
- Estados en tiempo real
- Imágenes

---

# 4. Mapas y GPS

### Tecnología

- Google Maps API

### Función

Se utiliza para:

- Mostrar mapas
- Calcular rutas
- Gestionar direcciones
- Seguimiento de repartidores

#### Función en este proyecto

- Rastreo en tiempo real
- Ubicación del repartidor

---

# 5. Pasarela de Pagos

### Tecnología

- Wompi

### ¿Qué es?

Plataforma colombiana de pagos en línea.

### ¿Por qué se utiliza?

Permite aceptar:

- Tarjetas
- Nequi
- PSE
- Transferencias

### Función en este proyecto

- Procesamiento de pagos
- Cobro seguro de pedidos

---

# 6. Hosting

### Tecnología

- Vercel

### ¿Qué es?

Plataforma cloud para desplegar aplicaciones web.

### ¿Por qué se utiliza?

- Fácil despliegue
- Configuración rápida
- Plan gratuito
- Excelente integración con Next.js

### Función en este proyecto

- Publicar frontend web
- Publicar panel administrativo

---

# Herramientas de Desarrollo

Durante el desarrollo del proyecto se utilizarán diferentes herramientas para facilitar la programación, diseño, pruebas, documentación y despliegue del sistema.

Estas herramientas permitirán mejorar la productividad, mantener una arquitectura organizada y acelerar el desarrollo del proyecto.

---

## Cursor

### ¿Qué es?

Cursor es un editor de código moderno impulsado por inteligencia artificial.

### ¿Para qué se utilizará?

- Escribir código más rápido
- Corregir errores automáticamente
- Generar componentes
- Optimizar funciones
- Ayudar en el desarrollo frontend y backend

### ¿Por qué se utilizará?

Porque permite acelerar considerablemente el desarrollo del proyecto y mejorar la productividad del desarrollador.

---

## Visual Studio Code

### ¿Qué es?

Visual Studio Code es un editor de código fuente ampliamente utilizado para desarrollo de software.

### ¿Para qué se utilizará?

- Desarrollo general del proyecto
- Edición de archivos
- Integración con Git
- Ejecución de terminales
- Instalación de extensiones

### ¿Por qué se utilizará?

Porque es ligero, rápido y compatible con las tecnologías utilizadas en el proyecto.

---

## Figma

### ¿Qué es?

Figma es una herramienta de diseño UI/UX basada en la nube.

### ¿Para qué se utilizará?

- Diseño de interfaces
- Creación de prototipos
- Diseño de pantallas móviles
- Diseño web
- Flujo de navegación

### ¿Por qué se utilizará?

Porque permite visualizar la aplicación antes de programarla y facilita la planificación del diseño.

---

## Git

### ¿Qué es?

Git es un sistema de control de versiones.

### ¿Para qué se utilizará?

- Controlar cambios del proyecto
- Guardar versiones del código
- Trabajar de forma organizada
- Recuperar versiones anteriores

### ¿Por qué se utilizará?

Porque es una herramienta fundamental en proyectos profesionales de software.

---

## GitHub

### ¿Qué es?

GitHub es una plataforma para alojar repositorios Git.

### ¿Para qué se utilizará?

- Almacenar el proyecto en la nube
- Gestionar versiones
- Compartir código
- Mantener respaldo del proyecto

### ¿Por qué se utilizará?

Porque facilita la administración del código y el trabajo colaborativo.

---

## Postman

### ¿Qué es?

Postman es una herramienta para probar APIs.

### ¿Para qué se utilizará?

- Probar endpoints
- Validar respuestas del backend
- Simular peticiones HTTP
- Verificar autenticación

### ¿Por qué se utilizará?

Porque facilita las pruebas y validaciones del backend.

---

## Draw.io

### ¿Qué es?

Herramienta para crear diagramas técnicos.

### ¿Para qué se utilizará?

- Diagramas de flujo
- Diagramas de arquitectura
- Casos de uso
- Diagramas UML

### ¿Por qué se utilizará?

Porque ayuda a documentar visualmente el sistema.

---

## Docker

### ¿Qué es?

Docker es una plataforma de contenedores.

### ¿Para qué se utilizará?

- Estandarizar ambientes
- Facilitar despliegues
- Ejecutar servicios aislados

### ¿Por qué se utilizará?

Porque mejora la portabilidad y estabilidad del proyecto.

---

## npm / pnpm

### ¿Qué es?

Son gestores de paquetes para proyectos JavaScript.

### ¿Para qué se utilizarán?

- Instalar dependencias
- Ejecutar scripts
- Gestionar librerías

### ¿Por qué se utilizarán?

Porque permiten administrar fácilmente todas las herramientas del proyecto.

---

# Objetivo de las Herramientas de Desarrollo

El uso de estas herramientas permitirá:

- Mantener un desarrollo organizado
- Mejorar la productividad
- Facilitar el mantenimiento
- Automatizar procesos
- Diseñar interfaces profesionales
- Realizar pruebas técnicas
- Documentar correctamente el proyecto
- Implementar buenas prácticas de desarrollo