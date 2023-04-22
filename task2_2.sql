--1.Выведите номера групп и количество студентов, обучающихся в них
-- SELECT *FROM student;
-- SELECT *FROM hobby;
-- SELECT COUNT(n_group)
-- FROM student
-- WHERE n_group = 2255;
SELECT n_group,
       COUNT(n_group) AS stud_count
FROM student
GROUP BY n_group
ORDER BY n_group DESC;
--2.Выведите для каждой группы максимальный средний балл
SELECT n_group, MAX(score) AS max_score
FROM student
GROUP BY n_group
ORDER BY n_group ASC;
--3.Подсчитать количество студентов с каждой фамилией
SELECT surname, COUNT(surname) as surname_count
FROM student
GROUP BY surname;
--4.Подсчитать студентов, которые родились в каждом году
SELECT *, COUNT(year_1) AS db_student FROM (
    SELECT EXTRACT(YEAR FROM data_birth) AS year_1
    FROM student
) t
GROUP BY year_1;
--5.Для студентов каждого курса подсчитать средний балл
SELECT  course, AVG(score) FROM (
    SELECT score, substr(CAST(n_group AS varchar), 1, 1) AS course
    FROM student
) t
GROUP BY course;
--6.Для студентов заданного курса вывести один номер группы с максимальным средним баллом
SELECT n_group, course, MAX(score) FROM (
    SELECT n_group, score, substr(CAST(n_group AS varchar), 1, 1) AS course
    FROM student
) t
GROUP BY course, n_group, score
HAVING score = (SELECT max(score) 
               FROM student)
;
--7.Для каждой группы подсчитать средний балл, вывести на экран только 
--те номера групп и их средний балл, в которых он менее или равен 3.5. 
--Отсортировать по от меньшего среднего балла к большему.
SELECT n_group, course, AVG(score) FROM (
    SELECT n_group, score, substr(CAST(n_group AS varchar), 1, 1) AS course
    FROM student
) t
GROUP BY course, n_group
HAVING AVG(score) <= 3.5
ORDER BY avg ASC
;
--8.Для каждой группы в одном запросе вывести количество студентов, 
--максимальный балл в группе, средний балл в группе, 
--минимальный балл в группе
SELECT n_group, AVG(score), COUNT(n_group), MAX(score), MIN(score) FROM student
GROUP BY n_group
;
--9.Вывести студента/ов, который/ые имеют наибольший балл в заданной группе
SELECT n_group, name
FROM student
WHERE score =
    (SELECT MAX(score)
     FROM student)
GROUP BY n_group, name
--10.Аналогично 9 заданию, 
--но вывести в одном запросе для каждой группы студента с максимальным баллом.
SELECT ST.name, ST.n_group FROM student ST,
(
    SELECT n_group, MAX(score) as max_score
    FROM student
    GROUP BY n_group
) Z
WHERE (ST.n_group = Z.n_group)and(ST.score = Z.max_score)
--И на этом запрросе vs code перестал нормально обрабатывать синтаксис, пришлось через pgAdmin работать(((