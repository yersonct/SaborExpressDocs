# Integración del expediente en SaborExpressDocs (rama dev)

1. Conservar los PDF originales de acta/requisitos/análisis/diseño: este paquete NO los incluye y no debe borrarlos.
2. Crear copia/branch de respaldo antes de sustituir ficheros locales: `git branch respaldo-docs-antes-apa7` (sin subirla necesariamente).
3. Extraer el contenido del ZIP en `C:\Dev\SaborExpress\docs` y combinar carpetas; NO eliminar carpetas originales antes de copiar.
4. Revisar cada Word/PDF y completar datos verdaderos de autoría/instructor/entorno sin introducir información sensible.
5. Revisar cambios con `git status`, `git diff --stat` y, tras `git add -A`, `git diff --cached --name-status`; si aparecen borrados de archivos históricos, restaurarlos antes del commit.
6. El commit debe realizarse solo después de la revisión local y aprobación responsable. No se ha realizado ninguna subida desde este paquete.

Comando propuesto:

```powershell
git add -A
git diff --cached --name-status
git commit -m "docs: ampliar expediente profesional APA7 de SaborExpress"
git push origin dev
```

**Alcance:** análisis estático y revisión bibliográfica; la sección de pruebas presenta escenarios que deberán ejecutarse y firmarse. La colección Postman no acredita que los endpoints hayan pasado ensayos.
