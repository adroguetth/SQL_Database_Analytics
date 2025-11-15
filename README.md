# 📚 Análisis de Ventas de Librería

## 🎯 Descripción del Proyecto
Este proyecto utiliza Common Table Expressions (CTEs) para identificar a los autores más vendidos y a los clientes recurrentes.  Demuestra técnicas modernas de análisis de datos, con énfasis en modularidad, rendimiento y business intelligence.

## 🚀 Características Principales

### 🔍 Análisis Implementado
- **Ventas por Autor**: Identificación de autores con ventas > $500 en categorías premium (Ficción, Misterio)
- **Clientes Recurrentes**: Segmentación de clientes VIP con ≥3 pedidos en el último año
- **Métricas de Negocio**: Análisis completo de ventas, autores y comportamiento de clientes
- **Segmentación Avanzada**: Categorización automática 🏆 VIP, ⭐ Recurrente, 🔹 Activo

### ⚡ Optimizaciones Técnicas
- Arquitectura modular con múltiples CTEs
- Filtros temporales optimizados (`DATE('now', '-1 year')`)
- Agregaciones eficientes con cláusulas HAVING
- Índices recomendados para alta performance

## 🛠️ Stack Tecnológico

**Bases de Datos:**
- SQLite

**Características SQL:**
- Common Table Expressions (CTEs)
- JOINs optimizados
- Funciones de agregación
- Segmentación con CASE
- Filtros temporales

## 📁 Estructura del Proyecto

| Recurso | Descripción | Enlace |
|---------|-------------|--------|
| **Portafolio Web** | Proyecto en línea con demostración | [Ver en web](https://www.adroguett-portfolio.cl/SQL/SQL-libreria) |
| **Diagrama ER** | Modelo de datos del proyecto | [Ver imagen](https://github.com/adroguetth/SQL_Database_Analytics/blob/Analisis_de_Ventas_de_Libreria/Diagrama%20ER.png) |
| **Documentación Técnica** | Análisis completo | [Descargar PDF](https://github.com/adroguetth/SQL_Database_Analytics/blob/Analisis_de_Ventas_de_Libreria/Documentacion.pdf) |
| **Esquema CTE: CONSULTA 1.png** | Esquema consulta N°1: Ventas por Autor  | [Ver imagen](https://github.com/adroguetth/SQL_Database_Analytics/blob/Analisis_de_Ventas_de_Libreria/Esquema%20CTE:%20CONSULTA%201.png) |
| **Esquema CTE: CONSULTA 2.png** | Esquema consulta N°2: Clientes Recurrentes  | [Ver imagen](https://github.com/adroguetth/SQL_Database_Analytics/blob/Analisis_de_Ventas_de_Libreria/Esquema%20CTE:%20CONSULTA%202.png) |
| **Código Principal** | Script SQL con consultas CTEs | [Ver código](https://github.com/adroguetth/SQL_Database_Analytics/blob/Analisis_de_Ventas_de_Libreria/analisis_libreria.sql) |
| **README.md** | Este archivo | - |

## 🏆 Resultados de Negocio

**Hallazgos Clave:**
- Autores más rentables en categorías premium
- Clientes VIP por ciudad con mayor valor de compra
- Segmentación natural basada en comportamiento
- Métricas de performance del negocio

**Decisiones Habilitadas:**
- Estrategias de adquisición de clientes
- Optimización del catálogo de libros
- Programas de fidelización segmentados
- Asignación de presupuestos por categoría

## 🚀 Cómo Usar

1. **Ejecutar el script SQL** en tu motor de base de datos preferido
2. **Revisar índices recomendados** para optimizar performance
3. **Adaptar filtros temporales** según necesidades específicas
4. **Integrar con herramientas BI** para visualización avanzada

## ⚡ Métricas de Performance

| Consulta | Tiempo Esperado | Escalabilidad |
|----------|-----------------|---------------|
| Ventas por Autor | < 100ms | Hasta 50K registros |
| Clientes Recurrentes | < 200ms | Hasta 100K registros |

## ✅ Best Practices Implementadas

- ✅ Documentación clara y comentada
- ✅ Consultas modulares con CTEs
- ✅ Optimización con índices estratégicos
- ✅ Validación de integridad referencial
- ✅ Segmentación basada en métricas de negocio

## 🔗 Enlaces Relacionados

- 🌐 **Portafolio Completo**: [https://www.adroguett-portfolio.cl/]
- 📊 **Proyecto en Línea**: [https://www.adroguett-portfolio.cl/SQL/SQL-libreria]
- 📧 **Contacto**: [adroguetth@gmail.com]

## 💼 Habilidades Demostradas

- SQL Avanzado con Common Table Expressions
- Análisis de Negocio y Segmentación de Clientes
- Optimización de Performance en Consultas
- Documentación Técnica Profesional
- Diseño de Arquitecturas de Consultas Modulares
- Business Intelligence con SQL Puro

---

**¿Interesado en análisis de datos?** ¡Contáctame para oportunidades en business intelligence y análisis avanzado con SQL!

---
*Documentación para portafolio técnico - Enfoque en análisis accionable y mejores prácticas de SQL*
