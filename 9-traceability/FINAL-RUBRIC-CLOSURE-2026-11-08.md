# Final rubric closure record — SaborExpress

**Cutoff:** 2026-11-08  
**Owner:** Yerson Stiven Cuellar Rubiano (`yersonct`)  
**Delivery version:** `final-delivery-2026`

This record links the final-delivery package to reproducible evidence. It does not convert a planned test, a static comparison or a historical result into a runtime acceptance result.

Este registro enlaza el paquete de entrega final con evidencia reproducible. No convierte una prueba planeada, una comparación estática o un resultado histórico en aceptación de ejecución.

## Closed delivery controls / Controles de entrega cerrados

| Control | Evidence |
|---|---|
| Fork release | `yersonct/ADSO-3145555` Release `final-delivery` with eight ZIP assets. |
| Repository tags | `final-delivery-2026` exists in Back, Docs, Mobile and Web. |
| PR scope | PR #18 contains the SaborExpress final-delivery folder only. |
| Integrity | The eight asset hashes are recorded in the final package `code-tag/SHA256SUMS.txt`. |
| Public source | The four source repositories are public and linked from the final package. |

## Corrective changes applied in the closure branch / Cambios correctivos aplicados en la rama de cierre

- Completed the public delivery README, author identity, role, delivery checklist and external-file statement.
- Completed the individual contribution report with an eight-week heatmap and repository-level evidence.
- Completed the known applicant, author, producer, rights-holder, work, declaration and attachment fields in the software-registration form without exposing private instructor identifiers.
- Declared the direct dependency families used by the backend, web and mobile repositories.
- Replaced empty mobile `catch` blocks with English diagnostic logging.
- Replaced backend notification `catch` blocks and the pending logging TODO with structured `ILogger` warnings.
- Removed the obsolete localization entry that claimed invoice PDF generation was unimplemented; the controller and generator are present and covered by invoice-PDF tests.
- Added coverage collection to the backend test workflow and coverage-reporting commands to web and mobile workflows. The published artifact must still be reviewed against the rubric threshold after the final CI run.

## Evidence still required / Evidencia todavía requerida

These are environmental or institutional actions and are intentionally not fabricated in this repository:

- Clean lift and database migration from the exact final tags.
- Login and end-to-end flow evidence for every declared role and both branches.
- Negative authorization, failure-recovery and payment-provider sandbox receipts against the lifted system.
- Physical Android, Bluetooth, printer, QR, reconnection, accessibility and performance evidence.
- Coverage percentages from the final CI artifacts, including the rubric threshold decision.
- Final institutional confirmation of authorship, ownership and third-party licenses.

The final package contains the commands and evidence matrix needed to close these rows when the corresponding environment or authority is available.
