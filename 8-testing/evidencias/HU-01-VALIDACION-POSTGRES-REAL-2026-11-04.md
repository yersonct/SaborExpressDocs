# HU-CIERRE-01 — validación con PostgreSQL aislado

**Fecha:** 2026-11-04 (America/Bogota)
**Rama Backend bajo prueba:** `fix/hu-01-postgres-serializable-retry`
**SHA base:** `caa4f0336a4f96f529c5da10d37128e381822b9c` (`develop`, con PR #88 integrado)
**Estado del árbol de trabajo al ejecutar:** cambios locales de HU-01 sin commit; no se hizo push, merge ni despliegue durante esta validación.

## Base utilizada y resguardo

La ejecución se hizo contra el contenedor desechable `saborexpress-hu01-pgtest`. Antes de migrar se comprobaron el contenedor activo, su publicación exclusiva en `127.0.0.1:55432`, y las variables de identidad `hu01_test` para base y usuario. Una conexión de solo lectura confirmó `current_database() = hu01_test`, `current_user = hu01_test` y puerto PostgreSQL interno `5432`. El test aborta antes de migrar si falla cualquiera de esas comprobaciones.

La contraseña se leyó localmente del entorno del contenedor, se mantuvo en memoria y se pasó al proceso de pruebas en una variable temporal. No se imprimió, guardó en archivos ni incorporó a esta evidencia. No se usaron Neon, Render, staging ni producción.

## Cambios de código bajo prueba

- `EfAuthTransactionRunner` vuelve a ejecutar hasta tres veces una transacción serializable ante los SQLSTATE PostgreSQL de serialización (`40001`) y deadlock (`40P01`), con espera breve acotada y limpieza del `ChangeTracker` tras abortar.
- La notificación SignalR de sesión reemplazada se ejecuta tras el commit, evitando repetir un efecto externo si se reintenta la operación.
- Los JWT incluyen `jti` aleatorio, evitando que un inicio de sesión posterior vuelva a emitir el mismo access token por compartir el mismo segundo de expiración.
- Se añadió una prueba PostgreSQL opt-in al proyecto Security.Tests. Solo se compila al usar `-p:HU01PostgresIntegration=true`; la prueba requiere `HU01_PG_TEST_PASSWORD` y fija internamente el destino local aprobado.

## Resultados ejecutados

| Verificación | Resultado |
| --- | --- |
| Preflight de host, puerto, base y usuario | PASS — destino verificado antes de migrar |
| Migraciones EF Core | PASS — aplicadas exclusivamente en `hu01_test` |
| Recuperación de contraseña y revocación de todas las sesiones | PASS |
| Rechazo del refresh token anterior | PASS |
| Invalidación del access token anterior | PASS — el evento `OnTokenValidated` real, respaldado por PostgreSQL, rechazó el JWT anterior al encontrar la sesión invalidada |
| Login con contraseña nueva y rechazo de la anterior | PASS |
| Reutilización del reset token | PASS — segundo uso rechazado |
| Fallo inyectado y rollback PostgreSQL | PASS — se conservaron el hash previo, el access token, el refresh token activo y el reset sin completar |
| Conflicto serializable real y reintento | PASS — dos transacciones independientes actualizaron la misma fila; al menos una callback se reejecutó y ambas actualizaciones quedaron guardadas |
| Carrera reset/refresh con contextos separados | PASS — reset completado; estado final sin refresh tokens activos y access token invalidado |
| Build Backend | PASS — 0 advertencias, 0 errores; 1.63 s |
| Security.Tests completa, sin filtros, con integración PostgreSQL habilitada | PASS — 99/99; incluye la prueba PostgreSQL real; 5 s de ejecución |
| Security.Tests completa, sin filtros, configuración normal | PASS — 98/98; 3 s de ejecución |
| QA.Tests completa, sin filtros | PASS — 62/62; 177 ms de ejecución |
| `git diff --check` | PASS — sin errores de whitespace |

Los comandos se ejecutaron con `--no-restore` y sin filtros. Se deshabilitaron analizadores durante las compilaciones por el tiempo excesivo del compilador del proyecto; el código y las suites se compilaron y ejecutaron.

La variación histórica de conteos proviene de usar ramas con bases de pruebas distintas. La rama corta `fix/hu-01-password-reset-revoke-refresh-pr` (base `f92cd3d`) tenía 25 pruebas Security y 61 QA; la rama histórica `fix/hu-01-password-reset-revoke-refresh` tenía la suite Security ampliada y registró 98 Security y 62 QA. La base actual `develop` incluye esa suite ampliada y cambios adicionales de QA: volvió a ejecutar 98 pruebas Security existentes y, al habilitar la prueba de PostgreSQL, sumó una más (99); QA quedó en 62. Ambas ejecuciones actuales se hicieron sin filtros.

El test elimina sus filas sintéticas al finalizar, también mediante `finally` en caso de fallo. El esquema y el historial de migraciones permanecen únicamente en la base local desechable.

## Alcance de la evidencia

La validación demuestra la atomicidad y revocación local con PostgreSQL real, incluido un aborto transaccional y un conflicto serializable con reintento. No acredita revocaciones externas de credenciales ni las demás tareas de cierre de HU-01.

No se modificaron secretos de proveedores, bases remotas, ni ramas remotas. Se mantiene el flujo `rama HU-01 → develop → qa → staging → main`; no se promovió la corrección.
