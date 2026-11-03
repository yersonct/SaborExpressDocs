# Instrucciones para integrar SaborExpressDocs sin borrar historia

**Autor de esta versión:** Yerson Stiven Cuellar Rubiano (ficha 3145555).

1. Crear una copia del repositorio `C:\Dev\SaborExpress\docs` o rama de respaldo. Confirmar `git status` y rama `dev`.
2. Si los PDF SENA y `clean-architecture-guide.md` figuran eliminados sin intención, restaurarlos con `git restore -- <ruta>` ANTES de copiar este paquete.
3. Extraer **el contenido del ZIP** directamente en la raíz de `C:\Dev\SaborExpress\docs`; no extraer una carpeta superior anidada.
4. Revisar Word y PDF, créditos de autor, bibliografía y diagramas; corregir cualquier información institucional o de ejecución no aportada.
5. Ejecutar `git status`, `git add -A`, `git diff --cached --name-status` para detectar eliminaciones no deseadas y secretos. Solo entonces `git commit` y `git push origin dev`.

## Comandos sugeridos (PowerShell)

```powershell
cd 'C:\Dev\SaborExpress\docs'
git status
git add -A
git diff --cached --name-status
# Confirmar que no existan bajas inesperadas ni claves.
git commit -m "docs: entregar expediente profesional SaborExpress APA7 ficha 3145555"
git push origin dev
```

**Precaución:** `git add -A` también registra eliminaciones; revisar antes de confirmar. Esta entrega no modifica los repositorios Back/Web/Movil ni realiza push.
