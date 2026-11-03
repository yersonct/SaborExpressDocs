# Inventario de configuración sin secretos

1. `DatabaseProvider`: MySQL | SqlServer | PostgreSQL (elegir uno).
2. `ConnectionStrings`: nombre coherente al motor y valores fuera del repositorio.
3. Firma y expiración JWT según configuración real, sin copiar claves.
4. `AllowedOrigins`: orígenes legítimos de la web y app.
5. Wompi: credenciales y endpoints por ambiente, nunca embebidos en cliente.
6. Correo, geocodificación, señalización SignalR y tiempos de servicio.
7. Base URL desde dispositivo móvil (la PC no es localhost en el teléfono).
8. Registro de configuración con SHA, responsable y fecha, sin compartir credenciales.
