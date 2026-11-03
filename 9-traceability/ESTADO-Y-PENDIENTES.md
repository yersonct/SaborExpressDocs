# Estado y pendientes de cierre SaborExpress

**Corte:** 3 de noviembre de 2026 · **Responsable de esta actualización:** yersonct

## Cómo interpretar este documento

Este registro es un resumen operativo de las brechas conocidas. No declara terminadas las 30 HU. El detalle de estado, SHAs, PR, ejecuciones y evidencia por HU está en [CIERRE-HU-2026-11-03.md](CIERRE-HU-2026-11-03.md); la relación de requisitos funcionales y pruebas está en [MATRIZ-TRAZABILIDAD.md](MATRIZ-TRAZABILIDAD.md).

Los identificadores `DOC-01` a `DOC-08` que aparecen en registros históricos de este repositorio no son los 28 hallazgos del anexo institucional. El anexo con su inventario individual aún no está disponible y no se han inventado hallazgos para reemplazarlo.

## Bloqueos que impiden el cierre

| Área / HU | Estado real | Siguiente evidencia requerida | Responsable/dependencia |
|---|---|---|---|
| Backend 01–02 | Credenciales comprometidas no rotadas; el historial compartido no se reescribió. | Revocación/rotación por proveedor; respaldo forense privado verificable; coordinación y plan seguro previo a decidir saneamiento. | Acceso del propietario a Render, PostgreSQL, correo y Wompi; ventana operativa. |
| Backend 03, 07 | CI, secret-scan y GitGuardian pasaron en `7e6950f`; prueba negativa artificial pasó localmente. El SHA nuevo `17a8ce4` solo tiene verificaciones locales. | Obtener CI/secret-scan remoto en `17a8ce4` y un run en `main`; verificar el historial después del proceso seguro de HU-01/02. | Permiso para crear PR/checks; rotación segura de HU-01/02. |
| Backend 05 | Hay pruebas locales de autorización por rol y sede, pero no la matriz completa. | Ejecución usuario de sede A contra recursos de sede B en endpoints y roles definidos. | Ambiente aislado/staging y cuentas sintéticas de ambas sedes. |
| Backend 06, 09, 28 | PR #86 se cerró al integrarse con la rama de integración `codex/*`, no con `main`. El candidato `hu-cierre-backend` tiene 14 commits de `yersonct` sobre `main`; el PR nuevo a `main` devolvió 403 y PR #85 continúa abierto desde `codex/*`. Sin protección ni revisiones independientes. | Permiso para abrir PR de `hu-cierre-backend` a `main`, obtener revisión, checks requeridos y evidencia de protección. | Permiso de escritura en GitHub y revisor independiente. |
| Backend 10–13 | Smoke local de readiness devolvió 503 por migraciones pendientes. Smoke remoto exitoso pertenece a un SHA antecesor; no hubo reversión ni restore medido. | Arranque limpio; staging con SHA candidato, smoke y rollback; migración en base desechable; backup/restore cronometrado. | Credenciales de staging y base aislada/almacenamiento autorizado. |
| Backend 15–17 | OpenAPI y rutas comparadas; suites locales pasaron. | Contratos runtime de schemas, errores, archivos y cargas; matriz CORS/JWT/privacidad en staging. | Staging y cuentas de prueba. |
| Backend 18–23 | Hay módulos y suites locales; no hay recorrido completo de siete roles y dos sedes. | Ejecutar pedidos, cocina, caja, Wompi/facturas, domicilios, catálogo, desconexión y recuperación con resultados identificables. | Staging, cuentas por rol/sede y sandbox del proveedor de pago. |
| Web 08–11 | Candidato Web pasó CI y quedó incluido en `main`; PR #43 está cerrado. No hay revisión independiente ni protección; Vercel reportó success en `main`, pero no se verificó el alias productivo. | Confirmar revisión/protección, clon/arranque limpio y deploy/smoke/rollback de aceptación en staging y producción. | Revisor independiente, permisos del repo y entorno staging. |
| Web 15–16, 18–23 | Rutas compatibles por comparación estática; E2E local usa API sintética. | Contratos reales y recorridos integrados de roles/operaciones con API, manejo de errores y archivos. | Staging compartido con Backend y Móvil. |
| Web 25 | Auditoría Playwright local pasó en 11 pantallas bajo criterios descritos; no mide WCAG completa ni KPI institucional. | Repetición reproducible con criterios acordados, Web desplegada y dispositivos/usuarios definidos cuando aplique. | Entorno y protocolo de aceptación acordados. |
| Web 30 | SHA candidato y CI documentados. | Incorporar SHA final, CI, smoke y evaluación institucional. | Cierre de los criterios previos y reevaluador. |
| Móvil 08–11 | Candidato Móvil pasó CI y quedó incluido en `main`; PR #32 está cerrado. No se confirmó APK productiva, instalación física ni rollback. | Revisión/protección, clon limpio, perfil EAS/release, instalación y smoke/reversión. | Revisor independiente, credenciales EAS, dispositivo y entorno staging. |
| Móvil 15–16, 18–23 | Código y pruebas locales; comparación de rutas estática. | Contrato API y recorridos por rol, pagos/archivos, desconexión y sincronización contra servicios compartidos. | Staging con Backend/Web y cuentas de prueba. |
| Móvil 24–25 | No hay APK de producción probada en dispositivo físico ni reporte móvil reproducible. | Keystore/EAS, APK, instalación y ensayo BLE/impresora/QR/sesión/reconexión; medición de accesibilidad/rendimiento en dispositivos definidos. | Propietario de firma, dispositivo físico, impresora y protocolo de medición. |
| Móvil 30 | SHA/CI candidatos registrados; `app.json` local sigue sin entrar a la rama. | Evidencia final de build e instalación física en el paquete de evaluación. | Responsable debe revisar `app.json`; reevaluación institucional. |
| Docs 14 | DER/diccionario/SQL se derivaron de EF Core y migraciones. | Comparar contra esquema desplegado verificable. | Acceso de solo lectura a una base desplegada. |
| Docs 26 | Matriz RF→HU→repositorio/SHA→PR→CP→evidencia está actualizada en esta rama; asociaciones RF→HU son propuestas y todos los RF conservan estado parcial/pendiente. | Confirmar asociaciones contra anexo y ligar cada CP a una ejecución/artefacto y revisión independiente. | Anexo institucional y revisor. |
| Docs 27 | Manuales Markdown y fuente institucional se actualizaron por rol; DOCX/PDF se regeneraron con `scripts/render-user-manuals.ps1` y se validaron. | Validar los pasos con la versión desplegada aceptada; añadir KPIs reales con fuente/método/límites, sin usar la medición local como KPI de producción. | Aceptación funcional en staging/producción y métricas operativas disponibles. |
| Docs 28 | Web/Móvil/Docs tienen PR cerrados e incluidos en `main`; Backend conserva PR #85 abierto desde `codex/*` y el PR nuevo a `main` devolvió 403. No se registran revisiones independientes. Las identidades históricas `lozano2303` y `CristianJPalma` son del usuario, según confirmó; no se reescribieron. | Registrar issues/PR con permisos disponibles, obtener revisión independiente y fijar SHAs. Decidir saneamiento histórico solo con el proceso seguro HU-01/02. | Permiso de escritura de Issues/PR, revisor y coordinación operativa. |
| Docs 29 | No se localizó el anexo institucional que enumera uno crítico, siete altos, dieciséis medios y cuatro bajos. | Obtener el anexo original y registrar sus 28 hallazgos individualmente con evidencia y responsable. | Instructor/entidad evaluadora. |
| Docs 30 | Paquete parcial con informes locales, SHAs y checks remotos. Web, Móvil y Docs están incluidos en `main`; Backend sigue fuera. | Fijar release SHAs finales de los cuatro repos, asociar CI/smoke/dispositivo, y someter a reevaluación. | Cierre de dependencias anteriores e institución evaluadora. |

## Reglas de publicación y control

- No se hacen commits directos a `main`. Web, Móvil y Docs ya están incluidos en `main`; la rama Backend permanece separada. Este informe se actualiza en una rama Docs propia.
- Los commits nuevos deben mantener autoría `yersonct`; una prueba de GitHub sobre `contributors` no cambia la autoría histórica.
- No subir secretos, capturas con datos privados, respaldos de producción ni identificadores financieros.
- No marcar `PASS` por la existencia de código, por una comparación estática o por un check de una suite agregada.
- No ejecutar migraciones, restauraciones ni reversión contra producción como parte de este cierre.
- `SaborExpressMovil/app.json` es un cambio local preexistente y no forma parte de los commits de cierre hasta revisión de su responsable.

## Relación con registros históricos

El registro original `DOC-01`–`DOC-08` queda como lista interna de observaciones documentales y no sustituye las HU-CIERRE ni los 28 hallazgos del anexo. Sus acciones se revisan dentro de HU-14 y HU-26–30. Las pruebas y su alcance están en `8-testing/evidencias`; cuando no exista artefacto específico, la fila correspondiente permanece pendiente.
