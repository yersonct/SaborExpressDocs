-- CONSULTA DIDÁCTICA: corresponde a convenciones PostgreSQL hipotéticas.
-- NO implica que las tablas físicas reales tengan exactamente estos nombres.
-- Exportar SQL EF con el proveedor correcto antes de ejecutar.
SELECT o."Id" AS pedido, o."BranchId" AS sede, p."Id" AS pago,
       p."Status" AS estado_pago
FROM "Orders" AS o
LEFT JOIN "Payments" AS p ON p."OrderId" = o."Id"
WHERE o."BranchId" = :branch_id;
