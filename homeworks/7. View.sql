-- 1. Создать представление, которое выводит следующие колонки:
-- order_date, required_date, shipped_date, ship_postal_code, company_name, contact_name, phone, last_name, first_name, title
--     из таблиц orders, customers и employees.
-- Сделать select к созданному представлению, выведя все записи, где order_date больше 1го января 1997 года.

CREATE VIEW orders_customers_employees AS
SELECT order_date,
       required_date,
       shipped_date,
       ship_postal_code,
       company_name,
       contact_name,
       phone,
       last_name,
       first_name,
       title
FROM orders o
         JOIN customers c ON o.customer_id = c.customer_id
         JOIN employees e ON e.employee_id = o.employee_id;

SELECT *
FROM orders_customers_employees
WHERE order_date > '1997-01-01';



-- 2. Создать представление, которое выводит следующие колонки:
-- order_date, required_date, shipped_date, ship_postal_code, ship_country, company_name, contact_name, phone, last_name, first_name, title
-- из таблиц orders, customers, employees.
-- Попробовать добавить к представлению (после его создания) колонки ship_country, postal_code и reports_to.
-- Убедиться, что проихсодит ошибка. Переименовать представление и создать новое уже с дополнительными колонками.
-- Сделать к нему запрос, выбрав все записи, отсортировав их по ship_county.
-- Удалить переименованное представление.

CREATE OR REPLACE VIEW orders_customers_employees AS
SELECT order_date,
       required_date,
       shipped_date,
       ship_postal_code,
       company_name,
       contact_name,
       phone,
       last_name,
       first_name,
       title
FROM orders o
         JOIN customers c ON o.customer_id = c.customer_id
         JOIN employees e ON e.employee_id = o.employee_id;

CREATE OR REPLACE VIEW orders_customers_employees_2 AS
SELECT order_date,
       required_date,
       shipped_date,
       ship_country,
       ship_postal_code,
       company_name,
       contact_name,
       phone,
       last_name,
       first_name,
       title,
       c. postal_code,
       reports_to
FROM orders o
         JOIN customers c ON o.customer_id = c.customer_id
         JOIN employees e ON e.employee_id = o.employee_id;

DROP VIEW orders_customers_employees;

SELECT *
FROM orders_customers_employees_2
ORDER BY ship_country;

DROP VIEW orders_customers_employees_2;


-- 3.  Создать представление "активных" (discontinued = 0) продуктов, содержащее все колонки.
-- Представление должно быть защищено от вставки записей, в которых discontinued = 1.
-- Попробовать сделать вставку записи с полем discontinued = 1 - убедиться, что не проходит.

CREATE OR REPLACE VIEW products_view AS
SELECT *
FROM products
WHERE discontinued = 0
    WITH LOCAL CHECK OPTION;

INSERT INTO products_view VALUES (100, 'Frankfurter', 13, 1, 'dd', 10, 10, 0, 15, 1);
