-- View 1: Média de temperatura por dispositivo
CREATE OR REPLACE VIEW avg_temp_por_dispositivo AS
SELECT "room_id/id" AS device_id, AVG(temp) AS avg_temp
FROM temperature_readings
GROUP BY "room_id/id";

-- View 2: Leituras por hora
CREATE OR REPLACE VIEW leituras_por_hora AS
SELECT EXTRACT(HOUR FROM CAST(noted_date AS timestamp)) AS hora,
       COUNT(*) AS contagem
FROM temperature_readings
GROUP BY hora
ORDER BY hora;


-- View 3: Temperaturas máximas e mínimas por dia
CREATE OR REPLACE VIEW temp_max_min_por_dia AS
SELECT DATE(noted_date) AS data,
       MAX(temp) AS temp_max,
       MIN(temp) AS temp_min
FROM temperature_readings
GROUP BY data
ORDER BY data;
