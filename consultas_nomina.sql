
Create database CamaraDeDip;
USE CamaraDeDip;

-- cuántos empleados tenemos
SELECT COUNT(*) AS Total_Empleados FROM Nomina_Junio_2025;

-- cargos más comunes
SELECT CARGO, COUNT(*) AS Total
FROM Nomina_Junio_2025
GROUP BY CARGO
ORDER BY Total DESC;

-- departamentos
SELECT DEPARTAMENTO, COUNT(*) AS Empleados
FROM Nomina_Junio_2025
GROUP BY DEPARTAMENTO
ORDER BY Empleados DESC;

-- 1. Masa salarial total
SELECT 
    SUM(INGRESO_BRUTO)     AS Total_Bruto,
    SUM(ISR)               AS Total_ISR,
    SUM(AFP)               AS Total_AFP,
    SUM(SFS)               AS Total_SFS,
    SUM(INGRESO_NETO)      AS Total_Neto
FROM Nomina_Junio_2025;

-- 2. Promedio salarial por departamento (top 10)
SELECT TOP 10
    DEPARTAMENTO,
    COUNT(*)                    AS Empleados,
    ROUND(AVG(INGRESO_BRUTO),2) AS Promedio_Bruto,
    ROUND(SUM(INGRESO_BRUTO),2) AS Masa_Salarial
FROM Nomina_Junio_2025
GROUP BY DEPARTAMENTO
ORDER BY Masa_Salarial DESC;

-- 3. Los 10 empleados mejor pagados
SELECT TOP 10
    NOMBRE,
    CARGO,
    DEPARTAMENTO,
    INGRESO_BRUTO
FROM Nomina_Junio_2025
ORDER BY INGRESO_BRUTO DESC;

-- 4. Rango salarial - distribución
SELECT 
    CASE 
        WHEN INGRESO_BRUTO < 20000  THEN '< 20K'
        WHEN INGRESO_BRUTO < 30000  THEN '20K - 30K'
        WHEN INGRESO_BRUTO < 40000  THEN '30K - 40K'
        WHEN INGRESO_BRUTO < 50000  THEN '40K - 50K'
        ELSE '> 50K'
    END AS Rango_Salarial,
    COUNT(*) AS Empleados
FROM Nomina_Junio_2025
GROUP BY 
    CASE 
        WHEN INGRESO_BRUTO < 20000  THEN '< 20K'
        WHEN INGRESO_BRUTO < 30000  THEN '20K - 30K'
        WHEN INGRESO_BRUTO < 40000  THEN '30K - 40K'
        WHEN INGRESO_BRUTO < 50000  THEN '40K - 50K'
        ELSE '> 50K'
    END
ORDER BY MIN(INGRESO_BRUTO);

GO
CREATE VIEW V_Resumen_Nomina AS
SELECT
    NOMBRE,
    CARGO,
    DEPARTAMENTO,
    INGRESO_BRUTO,
    ISR,
    AFP,
    SFS,
    INGRESO_NETO,
    ROUND(ISR + AFP + SFS, 2) AS TOTAL_DEDUCCIONES,
    ROUND(((ISR + AFP + SFS) / INGRESO_BRUTO) * 100, 2) AS PCT_DEDUCCION,
    CASE 
        WHEN INGRESO_BRUTO < 20000 THEN '< 20K'
        WHEN INGRESO_BRUTO < 30000 THEN '20K - 30K'
        WHEN INGRESO_BRUTO < 40000 THEN '30K - 40K'
        WHEN INGRESO_BRUTO < 50000 THEN '40K - 50K'
        ELSE '> 50K'
    END AS RANGO_SALARIAL
FROM Nomina_Junio_2025;

GO
SELECT TOP 10 * FROM V_Resumen_Nomina;