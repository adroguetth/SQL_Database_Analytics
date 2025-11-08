-- =====================================================
-- ANÁLISIS AVANZADO DE LIBRERÍA - CONSULTAS SQL
-- =====================================================
-- Archivo: analisis_libreria_avanzado.sql
-- Autor: Alfonso Droguett
-- Email: adroguetth@gmail.com
-- Descripción: Análisis de ventas y clientes recurrentes usando CTEs
-- =====================================================

-- =====================================================
-- CONSULTA 1: VENTAS POR AUTOR EN CATEGORÍAS ESPECÍFICAS
-- =====================================================
-- Objetivo: Identificar autores con ventas > $500 en categorías premium
-- Tiempo desarrollo: 1 hora
-- Complejidad: Intermedio
-- =====================================================

WITH Caracteristicas_libros AS (
    -- CTE 1: Unir información de libros con autores y categorías
    -- Propósito: Crear una vista unificada de los libros con sus metadatos
    SELECT
        a.id_libro,
        b.nombre AS autor,
        c.nombre_categoria AS categoria_libro
    FROM Libros a
    INNER JOIN Autores b ON a.id_autor = b.id_autor  -- Corregido: b.id_autor en lugar de b.id.autor
    INNER JOIN Categorias c ON a.id_categoria = c.id_categoria
),
Ventas_unitarias AS (
    -- CTE 2: Calcular ventas individuales por libro
    -- Propósito: Multiplicar cantidad × precio_unitario para cada venta
    SELECT
        a.autor AS autor,
        a.categoria_libro AS categoria_libro,
        b.precio_unitario * b.cantidad AS ventas
    FROM Caracteristicas_libros a
    INNER JOIN Detalles_Pedidos b ON a.id_libro = b.id_libro
)
-- CONSULTA FINAL: Agrupar y filtrar resultados
SELECT
    autor,
    categoria_libro,
    SUM(ventas) AS ventas_totales
FROM Ventas_unitarias
WHERE categoria_libro IN ('Ficción', 'Misterio')  -- Optimizado: IN en lugar de OR
GROUP BY autor, categoria_libro
HAVING SUM(ventas) > 500  -- Filtro: solo autores con ventas significativas
ORDER BY ventas_totales DESC;  -- Ordenar por ventas descendentes

-- =====================================================
-- CONSULTA 2: CLIENTES RECURRENTES POR CIUDAD
-- =====================================================
-- Objetivo: Identificar clientes VIP con patrones de compra recurrentes
-- Tiempo desarrollo: 5 horas
-- Complejidad: Avanzado
-- =====================================================

WITH
-- CTE 1: Filtrar pedidos del último año
-- Propósito: Reducir el dataset a un período relevante para el análisis
pedidos_recientes AS (
    SELECT
        id_cliente,
        id_pedido,
        fecha_pedido
    FROM Pedidos
    WHERE fecha_pedido >= DATE('now', '-1 year')  -- Filtro temporal: último año
),

-- CTE 2: Identificar clientes recurrentes
-- Propósito: Encontrar clientes con al menos 3 pedidos en el período
clientes_recurrentes AS (
    SELECT
        id_cliente,
        COUNT(id_pedido) AS total_pedidos  -- Agregado: contar pedidos para referencia
    FROM pedidos_recientes
    GROUP BY id_cliente
    HAVING COUNT(id_pedido) >= 3  -- Criterio de recurrencia: ≥3 pedidos
),

-- CTE 3: Calcular valor total de cada pedido
-- Propósito: Sumar el valor de todos los items en cada pedido
valor_pedidos AS (
    SELECT
        a.id_cliente,
        a.id_pedido,
        SUM(b.cantidad * b.precio_unitario) AS valor_total_pedido
    FROM Pedidos a
    JOIN Detalles_Pedidos b ON a.id_pedido = b.id_pedido
    WHERE a.fecha_pedido >= DATE('now', '-1 year')  -- Consistencia: mismo filtro temporal
    GROUP BY a.id_pedido, a.id_cliente
),

-- CTE 4: Calcular promedio de pedidos por cliente recurrente
-- Propósito: Obtener el ticket promedio de cada cliente VIP
promedio_por_cliente AS (
    SELECT
        c.id_cliente,
        c.total_pedidos,  -- Incluir métrica de recurrencia
        AVG(d.valor_total_pedido) AS promedio_valor_pedido,
        SUM(d.valor_total_pedido) AS valor_total_cliente  -- Agregado: valor total del cliente
    FROM clientes_recurrentes c
    JOIN valor_pedidos d ON c.id_cliente = d.id_cliente
    GROUP BY c.id_cliente, c.total_pedidos
)

-- CONSULTA FINAL: Unir con datos demográficos y ordenar
SELECT
    e.ciudad,
    e.nombre AS nombre_cliente,
    p.total_pedidos,
    ROUND(p.promedio_valor_pedido, 2) AS valor_promedio_pedidos,
    ROUND(p.valor_total_cliente, 2) AS valor_total_cliente,
    -- Segmentación basada en el valor promedio
    CASE
        WHEN p.promedio_valor_pedido > 150 THEN '🏆 VIP'
        WHEN p.promedio_valor_pedido > 100 THEN '⭐ Recurrente'
        ELSE '🔹 Activo'
    END AS segmento_cliente
FROM promedio_por_cliente p
JOIN Clientes e ON p.id_cliente = e.id_cliente
ORDER BY p.promedio_valor_pedido DESC, p.total_pedidos DESC;

-- =====================================================
-- CONSULTA ADICIONAL: MÉTRICAS RESUMEN DEL ANÁLISIS
-- =====================================================
-- Propósito: Proporcionar un resumen ejecutivo de los hallazgos

WITH metricas_generales AS (
    SELECT
        COUNT(DISTINCT id_cliente) AS total_clientes,
        COUNT(DISTINCT id_autor) AS total_autores,
        COUNT(DISTINCT id_libro) AS total_libros,
        SUM(cantidad * precio_unitario) AS ventas_totales_anuales
    FROM Detalles_Pedidos dp
    JOIN Pedidos p ON dp.id_pedido = p.id_pedido
    JOIN Libros l ON dp.id_libro = l.id_libro
    WHERE p.fecha_pedido >= DATE('now', '-1 year')
)
SELECT
    total_clientes,
    total_autores,
    total_libros,
    ROUND(ventas_totales_anuales, 2) AS ventas_totales_anuales,
    ROUND(ventas_totales_anuales / total_clientes, 2) AS ticket_promedio_por_cliente
FROM metricas_generales;

-- =====================================================
-- INDICADORES DE PERFORMANCE Y OPTIMIZACIÓN
-- =====================================================

/*
ÍNDICES RECOMENDADOS PARA MEJOR PERFORMANCE:

CREATE INDEX idx_pedidos_fecha ON Pedidos(fecha_pedido);
CREATE INDEX idx_detalles_pedido_id ON Detalles_Pedidos(id_pedido);
CREATE INDEX idx_libros_autor ON Libros(id_autor);
CREATE INDEX idx_libros_categoria ON Libros(id_categoria);
CREATE INDEX idx_clientes_ciudad ON Clientes(ciudad);

MÉTRICAS DE PERFORMANCE ESPERADAS:
- Consulta 1: < 100ms con índices apropiados
- Consulta 2: < 200ms con datasets de hasta 100K registros
- Escalabilidad: Optimizado para crecimiento de datos
*/

-- =====================================================
-- ESTRUCTURA ESPERADA DE RESULTADOS
-- =====================================================

/*
RESULTADOS CONSULTA 1 (VENTAS POR AUTOR):
+-------------------+-------------+----------------+
| autor             | categoria   | ventas_totales |
+-------------------+-------------+----------------+
| J.K. Rowling      | Ficción     | 1250.00        |
| Stephen King      | Misterio    | 890.50         |
| Agatha Christie   | Misterio    | 745.75         |
+-------------------+-------------+----------------+

RESULTADOS CONSULTA 2 (CLIENTES RECURRENTES):
+----------+----------------+--------------+---------------------+-------------------+
| ciudad   | nombre_cliente | total_pedidos| valor_promedio      | segmento_cliente  |
+----------+----------------+--------------+---------------------+-------------------+
| Madrid   | María González | 5            | 185.00              | 🏆 VIP           |
| Barcelona| Carlos Rodríguez| 4           | 162.50              | 🏆 VIP           |
| Valencia | Ana Martínez   | 3            | 145.75              | ⭐ Recurrente    |
+----------+----------------+--------------+---------------------+-------------------+
*/

-- =====================================================
-- NOTAS DE MANTENIMIENTO
-- =====================================================

/*
VERSION: 1.0
ÚLTIMA ACTUALIZACIÓN: [2025-10-31]
CAMBIOS REALIZADOS:
- Corrección de sintaxis en JOIN de Autores
- Optimización de filtros con IN
- Adición de métricas adicionales
- Mejora en la documentación

PRÓXIMAS MEJORAS:
- Implementar funciones de ventana para rankings
- Agregar análisis de tendencias temporales
- Crear vistas materializadas para reporting
*/

-- =====================================================
-- FIN DEL ARCHIVO
-- =====================================================
