# Propuesta técnica y plan de solución

**Proyecto:** SaborExpress  |  **Fecha de corte:** 14 de octubre de 2026  |  **Versión:** 2.0  |  **Tipo:** Documento técnico y académico

**Estado de la evidencia:** inspección documental y estática del código. Las pruebas de ejecución y los datos institucionales no aportados no se presumen realizados.

## 1. Resumen ejecutivo

Se propone mantener y estabilizar una plataforma modular compuesta por una API .NET, un portal de administración Next.js y una aplicación Expo para usuarios/roles de operación. La decisión prioritaria no es añadir microservicios, sino asegurar integridad de transacciones, autorización por sede, pruebas de pagos y despliegue reproducible.

## 2. Objetivo, alcance y entregables

El objetivo es documentar y validar los componentes ya presentes, integrarlos mediante un contrato OpenAPI verificable y asegurar una puesta en marcha comprobable. Entregables: SRS trazable, diagramas, manual técnico, manual de instalación, manual de usuario, catálogo de rutas, diccionario EF, matriz de pruebas, plan de mejora y artículo científico.

## 3. Alternativas de arquitectura

| Opción | Ventaja | Riesgo/condición | Decisión |
| --- | --- | --- | --- |
| Monolito modular .NET | Menor complejidad de despliegue; actual | Exige límites de dominio claros | Mantener |
| Microservicios por dominio | Escalado y autonomía independientes | Costo operativo y consistencia distribuidos | No afirmar ni migrar sin evidencia |
| Supabase como backend único | Servicios integrados | No coincide con código actual | Descartada como descripción actual |
| Dos frontends API compartida | Reuso de contratos de negocio | Versionado y permisos | Mantener y probar |

## 4. Plan de implementación y responsables

| Fase | Actividades | Criterio de cierre |
| --- | --- | --- |
| P1 – saneamiento | Congelar commit, corregir README, inventariar secretos y dependencias | Inventario y .env.example publicados |
| P2 – integridad | Migraciones reproducibles, pruebas CRUD por proveedor objetivo | Test y restauración pasan |
| P3 – autorizaciones | Matriz rol/recurso/sede; pruebas negativas | 0 accesos indebidos en matriz |
| P4 – pagos | Sandbox Wompi, validación de firmas y duplicados | Conciliación sin doble cargo |
| P5 – operación | Ensayos E2E y monitoreo; backup/restore | Evidencias firmadas por QA |
| P6 – entrega | Manual de usuario, capacitación, revisión académica | Acta de aceptación |

## 5. Recursos y condiciones

Ambiente de desarrollo: .NET SDK 8, Node/npm, repositorios, motor DB compatible, conexión a sandbox Wompi, entorno Expo (SDK y dispositivo/emulador), herramientas de pruebas API y un lugar seguro para secretos. Host, proveedor, precio y SLA de producción quedan sujetos a decisión del equipo; no se asignan precios sin cotización actual.

## 6. Riesgos priorizados

| Riesgo | Impacto | Respuesta |
| --- | --- | --- |
| Duplicado de webhook | Alto | Idempotencia/firmas/eventos |
| Token o privilegios insuficientes | Alto | Pruebas OWASP API1/API5 |
| Claves subidas a repo | Alto | Escaneo y rotación |
| Migración automática al iniciar | Medio/alto | Revisar estrategia en producción |
| CORS permisivo de desarrollo | Alto | Lista estricta de orígenes reales |
| Caída de SignalR | Medio | Reconexión + reconciliación por REST |
| Cobertura de pruebas desconocida | Alto | Construir pipeline CI |

## 7. Criterios de éxito (a medir)

Operaciones funcionales críticas aprobadas, porcentaje de requisitos cubiertos por pruebas, incidencias bloqueantes resueltas, p95 de operaciones según carga acordada, trazabilidad de pagos y accesibilidad básica. Este plan no registra resultados cumplidos antes de ejecutar pruebas.

## Fuentes primarias de implementación

- API: https://github.com/yersonct/SaborExpressBack/tree/main
- Web: https://github.com/yersonct/SaborExpressWeb/tree/main
- Móvil: https://github.com/yersonct/SaborExpressMovil/tree/main
- Referencia de presentación: https://github.com/jsgh1/SRD-v1/tree/dev/docs/docs-SRD

**Control documental:** documento elaborado a partir del estado observado en octubre de 2026. Antes de entregar, verificar el commit exacto, responsable, revisión del instructor y cualquier cambio posterior del código.
