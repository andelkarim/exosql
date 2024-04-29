CREATE VIEW ALL_WORKERS AS
SELECT last_name, first_name, age, first_day AS start_date
FROM WORKERS_FACTORY_1
WHERE last_day IS NULL
UNION ALL
SELECT last_name, first_name, NULL AS age, start_date AS start_date
FROM WORKERS_FACTORY_2
WHERE end_date IS NULL
ORDER BY start_date DESC;


CREATE VIEW ALL_WORKERS_ELAPSED AS
SELECT last_name, first_name, age, start_date, SYSDATE - start_date AS days_elapsed
FROM ALL_WORKERS;


CREATE VIEW BEST_SUPPLIERS AS
SELECT supplier_id, name, SUM(quantity) AS total_delivered
FROM (
    SELECT s.supplier_id, s.name, sb.quantity
    FROM SUPPLIERS s
    JOIN SUPPLIERS_BRING_TO_FACTORY_1 sb ON s.supplier_id = sb.supplier_id
    UNION ALL
    SELECT s.supplier_id, s.name, sb.quantity
    FROM SUPPLIERS s
    JOIN SUPPLIERS_BRING_TO_FACTORY_2 sb ON s.supplier_id = sb.supplier_id
)
GROUP BY supplier_id, name
HAVING SUM(quantity) > 1000
ORDER BY total_delivered DESC;


CREATE VIEW ROBOTS_FACTORIES AS
SELECT r.id AS robot_id, r.model, f.id AS factory_id, f.main_location
FROM ROBOTS r
JOIN ROBOTS_FROM_FACTORY rf ON r.id = rf.robot_id
JOIN FACTORIES f ON rf.factory_id = f.id;

