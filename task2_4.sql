SELECT *FROM student2;
SELECT *FROM student_hobby2;
SELECT *FROM hobby2;

-- CREATE TABLE student2 (
--     id         SERIAL PRIMARY KEY,
--     name       VARCHAR(255) NOT NULL,
--     surname    VARCHAR(255) NOT NULL,
--     n_group    INTEGER NOT NULL,
--     score      NUMERIC(3,2),
--     address    VARCHAR(3000),
--     date_birth DATE
-- );

-- CREATE TABLE hobby2 (
--     id    SERIAL PRIMARY KEY,
--     name  VARCHAR(255) NOT NULL,
--     risk  NUMERIC(4,2) NOT NULL
-- );

-- CREATE TABLE student_hobby2 (
--     id          SERIAL PRIMARY KEY,
--     student_id  INTEGER NOT NULL REFERENCES student(id) ON DELETE CASCADE,
--     hobby_id    INTEGER NOT NULL REFERENCES hobby(id) ON DELETE CASCADE,
--     date_start  TIMESTAMP NOT NULL,
--     date_finish DATE
-- );

-- /*
--     Добавление данных
-- */
-- INSERT INTO student2 (id, name, surname, n_group, date_birth, score) VALUES (1, 'Иван', 'Иванов', 2222, '09-09-1999', 4.02);
-- INSERT INTO student2 (id, name, surname, n_group, date_birth, score) VALUES (2, 'Михаил', 'Михайлов', 4032, '03-12-1997', 3.25);
-- INSERT INTO student2 (id, name, surname, n_group, date_birth, score) VALUES (3, 'Виктория', 'Николаева', 4011, '11-23-1994', 4.23);
-- INSERT INTO student2 (id, name, surname, n_group, date_birth, score) VALUES (4, 'Нуль', 'Нулёвый', 2222, '04-05-1998', 4.23);
-- INSERT INTO student2 (id, name, surname, n_group, date_birth, score) VALUES (5, 'Евгения', 'Сидорова', 2222, '04-05-1996', 3.59);
-- INSERT INTO student2 (id, name, surname, n_group, date_birth, score) VALUES (6, 'Сергей', 'Иванцов', 3011, '12-24-1995', 3.85);
-- INSERT INTO student2 (id, name, surname, n_group, date_birth, score) VALUES (7, 'Николай', 'Борисов', 3011, '12-08-2000', 4.22);
-- INSERT INTO student2 (id, name, surname, n_group, date_birth, score) VALUES (8, 'Виктория', 'Воронцов', 3011, '11-11-1999', 4.63);
-- INSERT INTO student2 (id, name, surname, n_group, date_birth, score) VALUES (9, 'Марина', 'Кузнецов', 3011, '01-25-1998', 3.11);
-- INSERT INTO student2 (id, name, surname, n_group, date_birth, score) VALUES (10, 'Джон', 'Уик', 3011, null, 3.45);
-- INSERT INTO student2 (id, name, surname, n_group, date_birth, score) VALUES (11, 'Виктор', 'Понедельник', 3011, '11-23-1994', 3.98);
-- INSERT INTO student2 (id, name, surname, n_group, date_birth, score) VALUES (12, 'Алиса', 'Васильченко', 2222, null, 2.98);
-- INSERT INTO student2 (id, name, surname, n_group, date_birth, score) VALUES (13, 'Артём', 'Иван', 2222, '05-28-1999', 4.03);
-- INSERT INTO student2 (id, name, surname, n_group, date_birth, score) VALUES (14, 'Шарлотта', 'Калла', 2222, '05-23-1996', 4.67);
-- INSERT INTO student2 (id, name, surname, n_group, date_birth, score) VALUES (15, 'Юлия', 'Белорукова', 4011, '11-28-1997', 3.58);
-- INSERT INTO student2 (id, name, surname, n_group, date_birth, score) VALUES (16, 'Татьяна', 'Акимова', 4011, '01-23-1995', 4.98);
-- INSERT INTO student2 (id, name, surname, n_group, date_birth, score) VALUES (17, 'Ульяна', 'Кайшева', 4011, '03-03-1998', 4.37);
-- INSERT INTO student2 (id, name, surname, n_group, date_birth, score) VALUES (19, 'Никита', 'Крюков', 4011, '08-04-1999', 2.55);
-- INSERT INTO student2 (id, name, surname, n_group, date_birth, score) VALUES (20, 'Иван', 'Шаповалов', 4032, '04-29-2002', 2);
-- INSERT INTO student2 (id, name, surname, n_group, date_birth, score) VALUES (21, 'Анастасия', 'Овсянникова', 4032, '12-31-1998', 4.25);
-- INSERT INTO student2 (id, name, surname, n_group, date_birth, score) VALUES (22, 'Людмила', 'Иванова', 4032, '05-02-1993', 3.65);
-- INSERT INTO student2 (id, name, surname, n_group, date_birth, score) VALUES (23, 'Валентина', 'Сидорова', 4032, null, 3.76);


-- INSERT INTO hobby2 (id, risk, name) VALUES (2, 0.3, 'Теннис');
-- INSERT INTO hobby2 (id, risk, name) VALUES (5, 0.4, 'Лыжные');
-- INSERT INTO hobby2 (id, risk, name) VALUES (7, 0.2, 'Фехтование');
-- INSERT INTO hobby2 (id, risk, name) VALUES (1, 0.8, 'Футбол');
-- INSERT INTO hobby2 (id, risk, name) VALUES (3, 0.5, 'Баскетбол');
-- INSERT INTO hobby2 (id, risk, name) VALUES (4, 0.4, 'Биатлон');
-- INSERT INTO hobby2 (id, risk, name) VALUES (6, 0.6, 'Волейбол');
-- INSERT INTO hobby2 (id, risk, name) VALUES (8, 0, 'Музыка');


-- INSERT INTO student_hobby2 (id, student_id, hobby_id, date_start, date_finish) VALUES (1, 2, 3, '03-15-2004', null);
-- INSERT INTO student_hobby2 (id, student_id, hobby_id, date_start, date_finish) VALUES (2, 2, 5, '02-18-2009', null);
-- INSERT INTO student_hobby2 (id, student_id, hobby_id, date_start, date_finish) VALUES (3, 3, 4, '11-12-1993', '12-11-2016');
-- INSERT INTO student_hobby2 (id, student_id, hobby_id, date_start, date_finish) VALUES (4, 4, 5, '03-14-2004', '05-03-2006');
-- INSERT INTO student_hobby2 (id, student_id, hobby_id, date_start, date_finish) VALUES (5, 5, 8, '06-18-2014', '08-09-2017');
-- INSERT INTO student_hobby2 (id, student_id, hobby_id, date_start, date_finish) VALUES (6, 6, 7, '03-19-2018', '03-15-2017');
-- INSERT INTO student_hobby2 (id, student_id, hobby_id, date_start, date_finish) VALUES (7, 7, 4, '04-07-2017', null);
-- INSERT INTO student_hobby2 (id, student_id, hobby_id, date_start, date_finish) VALUES (8, 8, 2, '11-09-2018', null);
-- INSERT INTO student_hobby2 (id, student_id, hobby_id, date_start, date_finish) VALUES (9, 8, 1, '02-28-2019', '03-02-2019');
-- INSERT INTO student_hobby2 (id, student_id, hobby_id, date_start, date_finish) VALUES (10, 9, 4, '12-19-2009', '12-24-2009');
-- INSERT INTO student_hobby2 (id, student_id, hobby_id, date_start, date_finish) VALUES (11, 9, 5, '06-18-2013', '09-25-2018');
-- INSERT INTO student_hobby2 (id, student_id, hobby_id, date_start, date_finish) VALUES (12, 11, 6, '06-18-2014', '08-21-2018');
-- INSERT INTO student_hobby2 (id, student_id, hobby_id, date_start, date_finish) VALUES (13, 12, 7, '01-23-1999', '04-14-2004');
-- INSERT INTO student_hobby2 (id, student_id, hobby_id, date_start, date_finish) VALUES (14, 1, 1, '07-19-2017', null);
--INSERT INTO student_hobby2 (id, student_id, hobby_id, date_start, date_finish) VALUES (15, 16, 5, '02-13-2018', null);

--1.Удалите всех студентов с неуказанной датой рождения
DELETE FROM student2
WHERE date_birth IS NULL
;
SELECT * FROM student2;

--2.Измените дату рождения всех студентов, с неуказанной датой рождения на 01-01-1999
UPDATE student2
SET date_birth = '01-01-1999'
WHERE date_birth IS NULL
;

--3.Удалите из таблицы студента с номером зачётки 21
DELETE FROM student
WHERE n_zachet = 21
;

--4.Уменьшите риск хобби, которым занимается наибольшее количество человек
WITH
t as (SELECT name, COUNT(hobby_id), risk FROM hobby2 h2
JOIN student_hobby2 sh2 ON sh2.student_id = h2.id
GROUP BY name, student_id, risk
HAVING count(hobby_id) > 1) 
UPDATE hobby2
SET risk = 0
FROM t
WHERE t.name = hobby2.name
;

--5.Добавьте всем студентам, которые занимаются хотя бы одним хобби 0.01 балл
WITH
t as (SELECT st2.name, h2.name, st2.score FROM hobby2 h2
JOIN student_hobby2 sh2 ON sh2.hobby_id = h2.id 
JOIN student2 st2 ON st2.id = sh2.student_id 
WHERE sh2.date_finish IS NOT NULL
)
UPDATE student2 
SET score = student2.score + 0.01
FROM t
WHERE t.score = student2.score
;

--6.Удалите все завершенные хобби студентов
DELETE FROM student_hobby2
WHERE date_finish IS NULL
;

--7.Добавьте студенту с id 4 хобби с id 5. date_start - '15-11-2009, date_finish - null
INSERT INTO student_hobby2 (id, student_id, hobby_id, date_start, date_finish) VALUES (16, 4, 5, '11-15-2009', null);

--8.Напишите запрос, который удаляет самую раннюю из студентов_хобби запись, в случае, 
--если студент делал перерыв в хобби (т.е. занимался одним и тем же несколько раз)
DELETE FROM 
    student_hobby2 sh1 
WHERE 
    EXISTS (
        SELECT 
            1 
        FROM 
            student_hobby2 sh2 
        WHERE 
            sh2.student_id = sh1.student_id 
            AND sh2.hobby_id = sh1.hobby_id 
            AND sh2.date_start < sh1.date_start
    );

--9.Поменяйте название хобби всем студентам, 
--кто занимается футболом - на бальные танцы, а кто баскетболом - на вышивание крестиком
INSERT INTO hobby2 (id, risk, name) VALUES (9, 0, 'Вышивание крестиком');
INSERT INTO hobby2 (id, risk, name) VALUES (10, 0.1, 'Бальные танцы');

WITH
t as (SELECT st2.name, h2.name, sh2.hobby_id, sh2.student_id FROM student2 st2
JOIN student_hobby2 sh2 ON sh2.student_id = st2.id
JOIN hobby2 h2 ON h2.id = sh2.hobby_id
WHERE h2.name = 'Футбол' 
)
UPDATE student_hobby2 sh2
SET hobby_id = 10
FROM t
WHERE t.student_id = sh2.student_id;
WITH
t as (SELECT st2.name, h2.name, sh2.hobby_id, sh2.student_id FROM student2 st2
JOIN student_hobby2 sh2 ON sh2.student_id = st2.id
JOIN hobby2 h2 ON h2.id = sh2.hobby_id
WHERE h2.name = 'Баскетбол' 
)
UPDATE student_hobby2 sh2
SET hobby_id = 9
FROM t
WHERE t.student_id = sh2.student_id;

--10.Добавьте в таблицу хобби новое хобби с названием "Учёба"
INSERT INTO hobby2 (id, risk, name) VALUES (11, 0, 'Учеба');

--11.У всех студентов, средний балл которых меньше 3.2 поменяйте во всех хобби (если занимается чем-либо) 
--и добавьте (если ничем не занимается), что студент занимается хобби из 10 задания
UPDATE 
    student2 
SET 
    score = 3.2 
WHERE 
    score < 3.2;

INSERT INTO 
    student_hobby2 (student_id, hobby_id, date_start, date_finish) 
SELECT 
    s.id, COALESCE(h.id, uh.id), CURRENT_DATE, NULL 
FROM 
    student2 s 
    LEFT JOIN student_hobby2 sh ON s.id = sh.student_id 
    LEFT JOIN hobby2 h ON sh.hobby_id = h.id 
    LEFT JOIN hobby2 uh ON uh.name = 'Учеба' 
WHERE 
    s.score < 3.2 
    AND (
        h.risk > 0 
        OR NOT EXISTS (
            SELECT 
                1 
            FROM 
                student_hobby2 sh2 
            WHERE 
                sh2.student_id = s.id
        )
    );

--12.Переведите всех студентов не 4 курса на курс выше
UPDATE student2
SET n_group = CAST(CONCAT(CAST((CAST(substr(CAST(n_group AS varchar), 1, 1) AS INT) + 1) AS varchar), CAST(substr(CAST(n_group AS varchar), 2, 3) AS VARCHAR)) AS INT)
WHERE CAST(substr(CAST(n_group AS varchar), 1, 1) AS INT) < 4
;

--13.Удалите из таблицы студента с номером зачётки 2
DELETE FROM student
WHERE n_zachet = 2
;
--14.Измените средний балл у всех студентов, которые занимаются хобби более 10 лет на 5.00
UPDATE student2
SET score = 5.00
WHERE id IN (
    SELECT s.id
    FROM student2 s
    INNER JOIN student_hobby2 sh ON s.id = sh.student_id
    WHERE DATE_PART('year', age(sh.date_start)) >= 10
)
;
--15.Удалите информацию о хобби, если студент начал им заниматься раньше, чем родился
DELETE FROM hobby2
WHERE id IN (
  SELECT hobby_id
  FROM student_hobby2
  INNER JOIN student2 ON student2.id = student_hobby2.student_id
  WHERE date_start >= date_birth
);




