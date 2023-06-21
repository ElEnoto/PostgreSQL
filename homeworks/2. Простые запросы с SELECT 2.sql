-- 1. Выбрать все заказы из стран France, Austria, Spain
SELECT * FROM orders WHERE ship_country IN ('France', 'Austria', 'Spain');


-- 2. Выбрать все заказы, отсортировать по required_date (по убыванию)
-- и отсортировать по дате отгрузке (по возрастанию)
SELECT * FROM orders
ORDER BY required_date DESC, shipped_date;

-- 3. Выбрать минимальное кол-во  единиц товара среди тех продуктов, которых в продаже более 30 единиц.
SELECT min(unit_price) FROM products WHERE units_in_stock > 30;
SELECT * FROM products;

-- 4. Выбрать максимальное кол-во единиц товара среди тех продуктов, которых в продаже более 30 единиц.
SELECT max(units_in_stock) FROM products WHERE unit_price > 30;

-- 5. Найти среднее значение дней уходящих на доставку с даты формирования заказа в USA
SELECT avg(shipped_date - order_date) FROM orders WHERE ship_country = 'USA';

-- 6. Найти сумму, на которую имеется товаров (кол-во * цену) причём таких,
-- которые планируется продавать и в будущем (см. на поле discontinued)
SELECT sum(units_in_stock * unit_price) FROM products WHERE discontinued = 0