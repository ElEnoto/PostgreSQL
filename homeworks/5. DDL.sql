-- 1. Создать таблицу teacher с полями
-- teacher_id serial, first_name varchar, last_name varchar, birthday date, phone varchar, title varchar

CREATE TABLE teacher
(
    teacher_id serial,
    first_name varchar,
    last_name  varchar,
    birthday   date,
    phone      varchar,
    title      varchar
);

-- 2. Добавить в таблицу после создания колонку middle_name varchar

ALTER TABLE teacher ADD COLUMN middle_name varchar;

-- 3. Удалить колонку middle_name

ALTER TABLE teacher DROP COLUMN middle_name;

-- 4. Переименовать колонку birthday в birth_date

ALTER TABLE teacher RENAME COLUMN birthday TO birth_date;

-- 5. Изменить тип данных колонки phone на varchar(32)

ALTER TABLE teacher ALTER COLUMN phone SET DATA TYPE varchar(32);

-- 6. Создать таблицу exam с полями exam_id serial, exam_name varchar(256), exam_date date

CREATE TABLE exam
(
    exam_id   serial,
    exam_name varchar(256),
    exam_date date
);


-- 7. Вставить три любых записи с автогенерацией идентификатора

INSERT INTO exam (exam_name, exam_date)
VALUES ('math', '2022-01-01'),
       ('en', '2022-01-02'),
       ('ru', '2022-01-03');

-- 8. Посредством полной выборки убедиться, что данные были вставлены нормально и
-- идентификаторы были сгенерированы с инкрементом

SELECT * FROM exam;

-- 9. Удалить все данные из таблицы со сбросом идентификатор в исходное состояние

TRUNCATE TABLE exam RESTART IDENTITY;



-- //////////////////////////////////////////////////////////////////////////////////////////

-- 1. Создать таблицу exam с полями:

-- - идентификатора экзамена - автоинкрементируемый, уникальный, запрещает NULL;
-- - наименования экзамена
-- - даты экзамена

-- DROP TABLE exams;

CREATE TABLE exams
(
    exam_id   serial UNIQUE NOT NULL,
    exam_name varchar,
    exam_date date
);


-- 2. Удалить ограничение уникальности с поля идентификатора

ALTER TABLE exams DROP CONSTRAINT exams_exam_id_key;

-- 3. Добавить ограничение первичного ключа на поле идентификатора

ALTER TABLE exams ADD CONSTRAINT exams_exam_id_key PRIMARY KEY (exam_id);

-- 4. Создать таблицу person с полями

-- - идентификатора личности (простой int, первичный ключ)
-- - имя
-- - фамилия

CREATE TABLE persons
(
    person_id  integer PRIMARY KEY,
    first_name varchar,
    last_name  varchar
);


-- 5. Создать таблицу паспорта с полями:

-- - идентификатора паспорта (простой int, первичный ключ)
-- - серийный номер (простой int, запрещает NULL)
-- - регистрация
-- - ссылка на идентификатор личности (внешний ключ)

CREATE TABLE passports (
                           passport_id integer PRIMARY KEY,
                           serial_number integer NOT NULL,
                           address varchar,
                           person_id integer,
                           CONSTRAINT FK_person_id FOREIGN KEY (person_id) REFERENCES persons(person_id)
);

-- 6. Добавить колонку веса в таблицу book (создавали ранее) с ограничением,
-- проверяющим вес (больше 0 но меньше 100)

CREATE TABLE book
(
    book_id serial PRIMARY KEY
);


ALTER TABLE book ADD COLUMN weight integer CONSTRAINT CH_weight CHECK ( weight > 0 AND weight < 100);

-- 7. Убедиться в том, что ограничение на вес работает (попробуйте вставить невалидное значение)

INSERT INTO book (weight) VALUES (200);

-- 8. Создать таблицу student с полями:

-- - идентификатора (автоинкремент)
-- - полное имя
-- - курс (по умолчанию 1)

CREATE TABLE student
(
    student_id serial,
    name       varchar,
    course     integer DEFAULT 1
);


-- 9. Вставить запись в таблицу студентов и убедиться,
-- что ограничение на вставку значения по умолчанию работает

INSERT INTO student (name) VALUES ('max');

SELECT * FROM student;

-- 10. Удалить ограничение "по умолчанию" из таблицы студентов

ALTER TABLE student ALTER COLUMN course DROP DEFAULT;

-- 11. Подключиться к БД northwind и добавить ограничение на поле unit_price таблицы products
-- (цена должна быть больше 0)

ALTER TABLE products
    ADD CONSTRAINT CH_unit_price CHECK ( unit_price > 0 );


-- 12. "Навесить" автоинкрементируемый счётчик на поле product_id таблицы products (БД northwind).
-- Счётчик должен начинаться с числа следующего за максимальным значением по этому столбцу.

SELECT MAX(product_id) FROM products;

CREATE SEQUENCE IF NOT EXISTS products_product_id_seq
    START WITH 78 OWNED BY products.product_id;

ALTER TABLE products
    ALTER COLUMN product_id SET DEFAULT nextval('products_product_id_seq');

-- 13. Произвести вставку в products (не вставляя идентификатор явно) и убедиться,
-- что автоинкремент работает. Вставку сделать так, чтобы в результате команды вернулось значение,
-- сгенерированное в качестве идентификатора.


INSERT INTO products(product_name, supplier_id, category_id, quantity_per_unit,
                     unit_price, units_in_stock, units_on_order, reorder_level, discontinued)
VALUES ('prod', 1, 1, 10, 20, 20, 10, 1, 0)
    RETURNING product_id;

