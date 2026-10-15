# Integración segura en rama dev

El contenido del ZIP se coloca **dentro de la carpeta del repositorio `docs/`**, no en una carpeta anidada. Las rutas del ZIP ya son relativas a la raíz de `SaborExpressDocs`. No contiene los PDF históricos `SENA_*` ni la guía `clean-architecture-guide.md`, pues deben conservarse desde Git.

## 1. Antes de copiar

```powershell
cd C:\Dev\SaborExpress\docs
git branch --show-current
git status
```

Si los siguientes archivos históricos aparecen como eliminados y quieres preservarlos, restáuralos antes del commit (recomendado):

```powershell
git restore -- '1-project-charter/SENA_Project_Charter_Completo.pdf' '2-requirements/SENA_Carpeta2_Requisitos_Ampliado_v2.pdf' '3-analysis/SENA_Carpeta3_Analisis_Ampliado.pdf' '4-design/SENA_Carpeta4_Diseno_Ampliado_Azul.pdf' 'clean-architecture-guide.md'
```

El comando solo recupera esas rutas históricas; no modifica la nueva documentación ni deshace otras modificaciones.

## 2. Descomprimir en la raíz del repositorio

```powershell
Expand-Archive -LiteralPath "$env:USERPROFILE\Downloads\SaborExpressDocs_DOCUMENTACION_INTEGRAL_2026-10-14.zip" -DestinationPath 'C:\Dev\SaborExpress\docs' -Force
```

Si el ZIP quedó en otra ruta, sustituir la ruta de `-LiteralPath`.

Antes de preparar el commit, si conservas las dos plantillas antiguas del paquete anterior, puedes retirarlas (el artículo nuevo ya las sustituye):

```powershell
Remove-Item -LiteralPath '11-research/ARTICULO-INVESTIGACION-PLANTILLA.md', '11-research/SaborExpress_Articulo_Investigacion_Plantilla.docx' -ErrorAction SilentlyContinue
```

## 3. Comprobar cambios y hacer el commit

```powershell
cd C:\Dev\SaborExpress\docs
git status
git add -A
git diff --cached --stat
git diff --cached --name-status
git commit -m "docs: completar expediente tecnico y articulos cientificos SaborExpress" -m "Se actualizan SRS, analisis, propuesta, diseno, modelos, catalogo API, manuales, plan de pruebas, trazabilidad, investigacion ES/EN y bibliografia con referencias verificables."
git push origin dev
```

**Revisar primero** `git diff --cached --name-status`; no confirmar si aparecen eliminaciones inesperadas o secretos. El push requiere permiso de escritura en la rama `dev`.
