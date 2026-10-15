# Procedimiento de implementación y liberación

**Proyecto:** SaborExpress  |  **Fecha de corte:** 14 de octubre de 2026  |  **Versión:** 2.0  |  **Tipo:** Documento técnico y académico

**Estado de la evidencia:** inspección documental y estática del código. Las pruebas de ejecución y los datos institucionales no aportados no se presumen realizados.

## 1. Punto de partida

Existen tres proyectos de aplicación: `SaborExpressBack`, `SaborExpressWeb`, `SaborExpressMovil`. Se recomienda definir el SHA de liberación por repositorio; versiones de paquetes no implican que el despliegue haya ocurrido. Requiere un ambiente de pruebas representativo y un responsable de cambios.

## 2. Secuencia de implementación (plan repetible)

1. Revisión de requisitos y congelamiento temporal de ramas. 2. Validación de dependencias y secretos. 3. Restauración/compilación API. 4. Aprovisionamiento DB y generación/revisión de migraciones. 5. Ejecución de tests unitarios/integración. 6. Compilación de Next.js. 7. Compilación/ejecución del cliente Expo. 8. Pruebas de contrato Swagger y seguridad. 9. Sandbox Wompi. 10. Ensayos con roles/sedes/usuarios ficticios. 11. Ensayo de respaldo/restauración y rollback. 12. Aprobación formal.

## 3. Control por etapa

| Etapa | Entrada | Validación | Salida |
| --- | --- | --- | --- |
| Preparar | Ramas + configuración | Versiones y secretos ocultos | SHA por repo |
| Construir | Código + SDKs | dotnet build / npm run build | Artefactos |
| Migrar | DB efímera | Generación SQL e idempotencia | Esquema documentado |
| Integrar | API/web/móvil | Pruebas E2E/SignalR/Wompi | Registros de QA |
| Aprobar | Evidencias | Checklist y firmas | Acta de aceptación |
| Publicar | Infra autorizada | Smoke y monitoreo | Release trazable |

## 4. Reversión

Ante falla, detener promoción, revisar integridad de la base y restaurar copia si el cambio de esquema lo necesita; volver a binarios conocidos, suspender tráfico de pago hasta reconciliar transacciones pendientes y registrar el incidente. No usar una reversión de Git como reemplazo de un procedimiento de rollback de datos.

## 5. Documentos de control

Acta de cambios con fecha, versión, ventana, responsables, ticket, evidencias de QA, historial de migraciones, lista de secretos rotados, resultado de smoke y autorización. Ninguna fecha de despliegue ni firma se completa artificialmente.

## Fuentes primarias de implementación

- API: https://github.com/yersonct/SaborExpressBack/tree/main
- Web: https://github.com/yersonct/SaborExpressWeb/tree/main
- Móvil: https://github.com/yersonct/SaborExpressMovil/tree/main
- Referencia de presentación: https://github.com/jsgh1/SRD-v1/tree/dev/docs/docs-SRD

**Control documental:** documento elaborado a partir del estado observado en octubre de 2026. Antes de entregar, verificar el commit exacto, responsable, revisión del instructor y cualquier cambio posterior del código.
