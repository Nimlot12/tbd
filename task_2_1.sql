-- ALTER TABLE student ADD score numeric;
-- UPDATE student 
-- SET  score = 2.5
-- WHERE id = 10;
-- SELECT * FROM student;
-- SELECT * FROM hobby;
--Вывести всеми возможными способами имена и фамилии студентов, средний балл которых от 4 до 4.5
SELECT name, surname, score FROM student 
WHERE score = 4 OR score = 4.1 OR score = 4.2 OR score = 4.3 OR score = 4.4 OR score = 4.5; 
SELECT name, surname, score FROM student 
WHERE score >= 4 AND score <= 4.5; 
SELECT name, surname, score FROM student 
WHERE score BETWEEN 4 AND 4.5; 
--Познакомиться с функцией CAST. Вывести при помощи неё студентов заданного курса (использовать Like)
SELECT surname, n_group FROM student 
WHERE CAST(n_group AS varchar) LIKE '%53';
--Вывести всех студентов, отсортировать по убыванию номера группы и имени от а до я
SELECT name, surname, n_group FROM student 
ORDER BY name, n_group DESC;
--Вывести студентов, средний балл которых больше 4 и отсортировать по баллу от большего к меньшему
SELECT surname, score FROM student 
WHERE score >= 4
ORDER BY score DESC;
--Вывести на экран название и риск 2-х хобби (на своё усмотрение)
SELECT id, name, risk FROM hobby WHERE id IN(3, 7);
--Вывести id_hobby и id_student которые начали заниматься хобби между двумя заданными датами (выбрать самим) и студенты должны до сих пор заниматься хобби
-- SELECT *FROM student_hobby;
-- INSERT INTO student_hobby(id_student, id_hobby, date_start, date_finish)
-- VALUES (2, 1, '2015-01-15', '2019-12-19'),
-- (3, 5, '2021-10-01', NULL),
-- (4, 7, '2010-07-17', '2016-12-17'),
-- (5, 2, '2018-06-08', '2020-11-09'),
-- (6, 4, '2017-09-06', '2023-01-15'),
-- (7, 9, '2022-02-11', NULL),
-- (8, 8, '2019-12-05', '2021-12-23'),
-- (9, 10, '2011-11-19', '2015-05-24'),
-- (10, 6, '2019-10-08', '2021-07-19');
SELECT id_student, id_hobby, date_start FROM student_hobby 
WHERE date_start BETWEEN '2019-01-01' AND '2023-12-31';
SELECT id_student, id_hobby, date_finish FROM student_hobby 
WHERE date_finish IS NULL;
--Вывести студентов, средний балл которых больше 4.5 и отсортировать по баллу от большего к меньшему
SELECT surname, score FROM student
WHERE score >= 4.5
ORDER BY score DESC;
--Из запроса №7 вывести несколькими способами на экран только 5 студентов с максимальным баллом
SELECT surname, score FROM student
WHERE score >= 4.5
ORDER BY score DESC LIMIT 5;
--Выведите хобби и с использованием условного оператора сделайте риск словами
-- >=8 - очень высокий
-- >=6 & <8 - высокий
-- >=4 & <8 - средний
-- >=2 & <4 - низкий
-- <2 - очень низкий
SELECT risk, name, 
CASE
WHEN risk >= 8 THEN 'очень высокий'
WHEN risk >= 6 AND risk < 8  THEN 'высокий'
WHEN risk >= 4 AND risk < 6 THEN 'средний'
WHEN risk >= 2 AND risk < 4 THEN 'низкий'
WHEN risk < 2 THEN 'очень низкий'
END riskslova
FROM hobby;
--Вывести 3 хобби с максимальным риском
SELECT name, risk FROM hobby
WHERE risk < 8
ORDER BY risk DESC LIMIT 3;






