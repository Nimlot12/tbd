-- Сервис удалённого заказа еды:
-- Возможности:

-- Пользователь. Регистрация
-- Пользователь. Авторизация
-- Пользователь. Просмотр меню.
-- Пользователь. Добавление в корзину
-- Пользователь. Оформление заказа (Считаем, что оплата производится «автоматом»)
-- Пользователь. Просмотр оформленных ранее заказов с пагинацией и поиском по диапазону дат и блюд из меню, а также с сортировкой по ценнику и дате
-- Пользователь. Возможность повторить (добавить в корзину) все блюда из ранее оформленного заказа
-- Пользователь. Просмотр состояния заказа
-- Управляющий. Добавление новых позиций в меню (должен быть указан состав, вес, белки, жиры, углеводы, ккал)
-- Управляющий. Видеть список заказов
-- Управляющий. Менять статус заказа


CREATE TABLE users(
    id_user SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    surname TEXT NOT NULL,
    date_birth DATE,
    date_reg DATE,
    email TEXT UNIQUE,
    call TEXT,
    password TEXT NOT NULL
);
SELECT *FROM users;
CREATE TABLE menu(
    id_menu SERIAL PRIMARY KEY,
    id_product INTEGER NOT NULL,
    name TEXT NOT NULL,
    price INTEGER NOT NULL
);
INSERT INTO menu (id_product, name, price) VALUES (5, 'onion', 523);
SELECT *FROM menu;
CREATE TABLE orders(
    id_order SERIAL PRIMARY KEY,
    id_user INTEGER NOT NULL,
    date_order DATE NOT NULL,
    status TEXT NOT NULL,
    CHECK (status IN ('not ready', 'ready', 'closed'))
);
SELECT *FROM orders;
CREATE TABLE bag(
    id_order INTEGER NOT NULL,
    id_menu INTEGER NOT NULL,
    date_add DATE NOT NULL
);
SELECT *FROM bag;
CREATE TABLE products(
    id_product SERIAL PRIMARY KEY,
    name TEXT UNIQUE NOT NULL,
    ves INTEGER NOT NULL,
    belki INTEGER NOT NULL,
    lipid INTEGER NOT NULL,
    uglevod INTEGER NOT NULL,
    kkal INTEGER NOT NULL,
    price INTEGER NOT NULL
);
SELECT *FROM products;

--Запросы:

--1. Регистрация пользователя
INSERT INTO users (name, surname, date_birth, date_reg, email, call, password) VALUES ('Иван', 'Иванов', '1990-03-15', '2023-05-27', 'Ivanov@uni-dubna.ru', '+79999999999', '050554iv');

--2. Авторизация пользователя
SELECT name, email, password FROM users;

--3. Просмотр меню
SELECT name, price FROM menu;

--4. Добавление в корзину
INSERT INTO bag (id_order, id_menu, date_add) VALUES (2, 3, '2023-05-24');

--5. Удаление из корзины
DELETE FROM bag
WHERE id_order = 1;

--6. Оформление заказа
INSERT INTO orders (id_user, date_order, status) VALUES (2, '2023-05-24', 'not ready');

--7. Просмотр заказов, сортировка по датам, ценнику и вывод блюд из меню
SELECT ord.id_order, m.name, m.price, ord.date_order, ord.status FROM orders ord
JOIN bag b ON b.id_order = ord.id_order
JOIN menu m ON m.id_menu = b.id_menu
ORDER BY m.price, date_order DESC;

--8. Просмотр состояния заказа
SELECT status FROM orders;

--9. Добавление новых позиций в меню
INSERT INTO products (name, ves, belki, lipid, uglevod, kkal, price) VALUES ('sugar', 23, 12, 45, 34, 87, 123);
INSERT INTO menu (id_product, name, price) 
SELECT id_product, name, price FROM products;

--10. Просмотр списка заказов
SELECT *FROM orders;

--11. Изменение статуса заказа
UPDATE orders
SET status = 'ready'
WHERE status = 'not ready';

UPDATE orders
SET status = 'closed'
WHERE status = 'ready';

--12. Вывод цены заказа
SELECT ord.id_order, SUM(price) FROM orders ord
JOIN bag b ON b.id_order = ord.id_order
JOIN menu m ON m.id_menu = b.id_menu
GROUP BY ord.id_order;

--13. Вывод пользователей, которые сделали заказ
SELECT us.name, us.surname, ord.id_order FROM users us
JOIN orders ord ON ord.id_user = us.id_user;

--14. Удаление завершенных заказов
DELETE FROM orders
WHERE status = 'closed';

--15. Сортировка блюд по цене в меню
SELECT *FROM menu
ORDER BY price ASC;

--16. Вывести все блюда, у которых цена больше 250
SELECT *FROM menu
WHERE price > 250;

--17. Вывести все готовящиеся заказы
SELECT *FROM orders
WHERE status = 'not ready';

--18. Вывести заказ с наименьшей суммой
WITH t as (
    SELECT ord.id_order, SUM(price) FROM orders ord
    JOIN bag b ON b.id_order = ord.id_order
    JOIN menu m ON m.id_menu = b.id_menu
    GROUP BY ord.id_order
),
q as (
    SELECT min(sum) FROM t
)
SELECT id_order FROM t, q
WHERE sum = q.min
;

--19. Вывести заказ с наибольшей суммой
WITH t as (
    SELECT ord.id_order, SUM(price) FROM orders ord
    JOIN bag b ON b.id_order = ord.id_order
    JOIN menu m ON m.id_menu = b.id_menu
    GROUP BY ord.id_order
),
q as (
    SELECT max(sum) FROM t
)
SELECT id_order FROM t, q
WHERE sum = q.max
;

--20. Вывести пользователя, с наименьшей суммой неготого заказа
WITH t as (
    SELECT ord.id_order, SUM(price) FROM orders ord
    JOIN bag b ON b.id_order = ord.id_order
    JOIN menu m ON m.id_menu = b.id_menu
    GROUP BY ord.id_order
),
q as (
    SELECT min(sum) FROM t
)
SELECT users.name, users.surname, t.id_order, orders.status FROM users, orders, t, q
WHERE sum = q.min AND orders.status = 'not ready' AND users.id_user = orders.id_user
;

