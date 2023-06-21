-- 1. Написать функцию, которая копирует таблицу customers.

CREATE OR REPLACE function backup_customers() RETURNS void AS
$$
DROP TABLE IF EXISTS backedup_customers;

CREATE TABLE backedup_customers AS
SELECT *
FROM customers;
$$ LANGUAGE SQL;

SELECT backup_customers();

SELECT * FROM backedup_customers;

-- 2. Создать функцию, которая возвращает средний фрахт

CREATE OR REPLACE function get_avg_freight() RETURNS float8 AS
$$
SELECT AVG(freight)
FROM orders;
$$ LANGUAGE SQL;

SELECT get_avg_freight();

-- 3. Написать функцию, которая принимает 2 целочисленных параметра,
-- используемых как нижняя и верхняя граница генерируемого рандомного числа

CREATE OR REPLACE function random_between(low int, hight int) RETURNS int AS
$$
BEGIN
RETURN floor(random() * (hight - low + 1) + low);
END;
$$ LANGUAGE plpgsql;

SELECT random_between(3, 7)
FROM generate_series(1, 5);

-- 4. Вернуть самую низкую и высокую зарплату среди сотрудников из заданного города

CREATE OR REPLACE function get_salary_by_city(emp_city varchar, out min_salary numeric, out max_salary numeric)  AS
$$
SELECT MIN(salary), MAX(salary) FROM employees WHERE city = emp_city;
$$ LANGUAGE SQL;

SELECT * FROM get_salary_by_city('London');