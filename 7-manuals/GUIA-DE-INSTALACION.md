# Manual de instalación y configuración

**Proyecto:** SaborExpress  |  **Fecha de corte:** 14 de octubre de 2026  |  **Versión:** 2.0  |  **Tipo:** Documento técnico y académico

**Estado de la evidencia:** inspección documental y estática del código. Las pruebas de ejecución y los datos institucionales no aportados no se presumen realizados.

## 1. Requisitos mínimos de entorno de desarrollo

Windows, macOS o Linux compatible, Git, .NET SDK 8, Node.js LTS compatible con Next.js 16 y Expo 57, npm, acceso a un gestor relacional soportado por la configuración .NET y una cuenta de pruebas para las integraciones externas. La capacidad de RAM/CPU y versiones exactas de emuladores se deben ajustar y medir según hardware real; no se promete un mínimo productivo universal.

## 2. Descarga y ramas

```powershell
mkdir C:\Dev\SaborExpress -Force
cd C:\Dev\SaborExpress
git clone https://github.com/yersonct/SaborExpressBack.git back
git clone https://github.com/yersonct/SaborExpressWeb.git web
git clone https://github.com/yersonct/SaborExpressMovil.git movil
git clone https://github.com/yersonct/SaborExpressDocs.git docs
```

La ubicación es un ejemplo. Registrar ramas y SHA con `git -C .\back rev-parse HEAD` y comandos equivalentes. No dar por supuesto que todas las dependencias están sincronizadas en `main`.

## 3. Backend ASP.NET Core

```powershell
cd C:\Dev\SaborExpress\back
dotnet --info
dotnet restore
dotnet build -c Debug
```

**Configuración:** `DatabaseProvider` acepta literalmente `MySQL`, `SqlServer` o `PostgreSQL` según `DatabaseConfiguration.cs`. El `ConnectionStrings` debe incluir, según el proveedor, `MySQLConnection`, `SqlServerConnection` o `PostgresConnection`. Los valores sensibles deben ir en variables de entorno o `dotnet user-secrets`; no copiar cadenas reales del `appsettings.json` al documento. Revisar `JwtSettings`, `AllowedOrigins`, correos, Wompi y cualquier clave externa en clases de configuración.

Ejemplo sintáctico sin credenciales:

```powershell
dotnet user-secrets init
dotnet user-secrets set 'DatabaseProvider' 'PostgreSQL'
dotnet user-secrets set 'ConnectionStrings:PostgresConnection' '<CADENA_LOCAL_DE_PRUEBA>'
```

La API llama migraciones y seeders al arrancar. **Primero usar una BD desechable respaldada**, porque `MigrateAsync` puede alterar el esquema. Lanzar `dotnet run` solo después de validar los secretos y confirmar el proveedor. Swagger UI aparece en la ruta `/` cuando el proceso y el entorno permiten acceder a ella. No se garantiza URL o puerto fijo.

## 4. Web Next.js

```powershell
cd C:\Dev\SaborExpress\web
npm ci
npm run dev
```

`npm run build` permite comprobar empaquetado. Ajustar la URL base de la API según variables reales usadas en `src/config` o servicios; no asumir un nombre de `.env` no comprobado. La URL que imprima Next.js será el punto de acceso local.

## 5. Móvil Expo

```powershell
cd C:\Dev\SaborExpress\movil
npm ci
npx expo start
```

En un teléfono físico se necesita dirección IP accesible por red, no `localhost` del PC. Expo 57 usa dev client o flujo admitido por la versión; confirmar compatibilidad de Expo Go/dispositivo, permisos de ubicación y push. Registrar token push solo en ambiente de prueba autorizado.

## 6. Wompi, SignalR y servicios externos

Usar ambiente sandbox y llaves de prueba; validar firmas de eventos mediante el código del servicio. No activar pagos reales en pruebas. Para SignalR probar sesión JWT, negociación, reconexión y comportamiento cuando no hay conexión.

## 7. Verificación y resolución de fallas

| Problema | Comprobación | Solución segura |
| --- | --- | --- |
| dotnet restore falla | SDK 8 y paquetes | Revisar feeds/proxy sin exponer credenciales |
| No conecta BD | Provider/nombre de cadena/servicio | Probar conexión local y permisos |
| Migración falla | Proveedor e historial | Restaurar BD de pruebas y revisar script |
| CORS rechaza | Origen web, URL API | Ajustar AllowedOrigins para ambiente |
| Móvil no conecta | IP/firewall/HTTPS | Usar IP de PC accesible, TLS de prueba |
| Wompi no confirma | Referencia y firma | Inspeccionar sandbox sin reintentos reales |
| Web no compila | Node/npm/dependencias | npm ci y revisar errores exactos |

## 8. Desinstalación y respaldo

Detener procesos; respaldar BD y archivos según política; eliminar instalaciones de prueba después de garantizar recuperabilidad. Nunca ejecutar eliminación de volúmenes o base productiva como procedimiento genérico.

## Fuentes primarias de implementación

- API: https://github.com/yersonct/SaborExpressBack/tree/main
- Web: https://github.com/yersonct/SaborExpressWeb/tree/main
- Móvil: https://github.com/yersonct/SaborExpressMovil/tree/main
- Referencia de presentación: https://github.com/jsgh1/SRD-v1/tree/dev/docs/docs-SRD

**Control documental:** documento elaborado a partir del estado observado en octubre de 2026. Antes de entregar, verificar el commit exacto, responsable, revisión del instructor y cualquier cambio posterior del código.
