# Informe final de ingeniería — versión documental

**Proyecto:** SaborExpress  |  **Fecha de corte:** 14 de octubre de 2026  |  **Versión:** 2.0  |  **Tipo:** Documento técnico y académico

**Estado de la evidencia:** inspección documental y estática del código. Las pruebas de ejecución y los datos institucionales no aportados no se presumen realizados.

## 1. Síntesis del trabajo

Este expediente reúne un análisis del estado de código de SaborExpress a octubre de 2026 y documentos de requisitos, diseño, datos, interfaz, operación e investigación. No se ha realizado una evaluación experimental ni aceptación del sistema.

## 2. Sistema caracterizado

API central ASP.NET Core 8, EF Core, JWT, SignalR y procesos hospedados; interfaz administrativa web Next.js 16/React 19; móvil Expo 57/React Native 0.86; persistencia relacional con configuración de motores alternativos. Existe integración programada con Wompi que exige validación real en sandbox.

## 3. Evidencia y método

Se consultaron `Program.cs`, los manifiestos, controladores de dominio, modelos de entidad y estructura de carpetas. Se construyó una matriz de brechas documentales y pruebas futuras. Este informe puede servir como línea base para la presentación del proyecto, no como demostración de rendimiento.

## 4. Principales entregables de la carpeta

| Categoría | Resultado |
| --- | --- |
| 01 | SRS y acta de constitución |
| 02 | Análisis funcional y propuesta técnica |
| 03 | Diseño arquitectónico y diagramas |
| 04 | Manual técnico y de instalación |
| 05 | Manual por roles |
| 06 | Datos y catálogo API |
| 07 | Pruebas/trazabilidad/mejora |
| 08 | Artículo científico ES y EN |

## 5. Conclusiones y próximas actividades

El software puede caracterizarse como una solución modular multi-cliente. El conjunto de documentos elimina vacíos y corrige descripciones obsoletas. La mejora prioritaria es ejecutar pruebas reproducibles de integridad, pagos, autorizaciones, usabilidad y migraciones; completar capturas reales y actas de aprobación.

**Aprobación del equipo / instructor:** pendiente; no se inventa firma.

## Fuentes primarias de implementación

- API: https://github.com/yersonct/SaborExpressBack/tree/main
- Web: https://github.com/yersonct/SaborExpressWeb/tree/main
- Móvil: https://github.com/yersonct/SaborExpressMovil/tree/main
- Referencia de presentación: https://github.com/jsgh1/SRD-v1/tree/dev/docs/docs-SRD

**Control documental:** documento elaborado a partir del estado observado en octubre de 2026. Antes de entregar, verificar el commit exacto, responsable, revisión del instructor y cualquier cambio posterior del código.
