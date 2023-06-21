--1. Найти заказчиков и обслуживающих их заказы сотрудников таких,
-- что и заказчики и сотрудники из города London, а доставка идёт компанией Speedy Express.
-- Вывести компанию заказчика и ФИО сотрудника.

SELECT c.company_name, e.first_name || ' ' || e.last_name AS Name
FROM customers c
         JOIN orders o ON c.customer_id = o.customer_id
         JOIN employees e ON e.employee_id = o.employee_id
         JOIN shippers s ON s.shipper_id = o.ship_via
WHERE e.city = 'London'
  AND c.city = 'London'
  AND s.company_name = 'Speedy Express';


--2. Найти активные (см. поле discontinued) продукты из категории Beverages и Seafood,
-- которых в продаже менее 20 единиц.
-- Вывести наименование продуктов, кол-во единиц в продаже, имя контакта поставщика и его телефонный номер.

SELECT product_name, units_in_stock, contact_name, phone
FROM categories
         JOIN products p on categories.category_id = p.category_id
         JOIN suppliers s on s.supplier_id = p.supplier_id
WHERE discontinued = 0
  AND category_name IN ('Beverages', 'Seafood')
  AND units_in_stock < 20;



--3. Найти заказчиков, не сделавших ни одного заказа. Вывести имя заказчика и order_id.
SELECT contact_name
FROM customers
         LEFT JOIN orders o ON customers.customer_id = o.customer_id
WHERE o.customer_id IS NULL;


--4. Переписать предыдущий запрос, использовав симметричный вид джойна (подсказка: речь о LEFT и RIGHT).

SELECT contact_name
FROM orders o
         RIGHT JOIN customers c ON c.customer_id = o.customer_id
WHERE o.customer_id IS NULL;
