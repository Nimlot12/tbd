SELECT * FROM student;
SElECT * FROM hobby;
SELECT * FROM student_hobby;

--1.Вывести все имена и фамилии студентов, и название хобби, которым 
--занимается этот студент (student_hobby.student_id равен student.id и 
--student_hobby.hobby_id равен hobby.id.) 
SELECT st.name, st.surname, h.name 
FROM student st, hobby h, student_hobby sh
WHERE sh.id_student = st.id AND sh.id_hobby = h.id
;

--2.Вывести информацию о студенте, занимающимся хобби самое продолжительное время.
SELECT t.name, t.surname, t.new_date
FROM (SELECT st.name, st.surname, sh.date_start, sh.date_finish, (sh.date_finish - sh.date_start) as new_date
FROM student st, student_hobby sh
WHERE sh.id_student = st.id) t
WHERE t.new_date = (SELECT MAX(t1.new_date) 
FROM (SELECT st.name, st.surname, sh.date_start, sh.date_finish, 
(sh.date_finish - sh.date_start) as new_date
FROM student st, student_hobby sh
WHERE sh.id_student = st.id) t1)
;

--3.Вывести имя, фамилию, номер зачетки и дату рождения для студентов, средний балл которых выше среднего, 
--а сумма риска всех хобби, которыми он занимается в данный момент, больше 0.9.
SELECT s.name, s.surname, s.n_zachet, s.data_birth 
FROM student s
JOIN student_hobby sh ON s.id = sh.id_student
JOIN hobby h ON sh.id_hobby = h.id
WHERE score > (SELECT AVG(score) FROM student) AND (SELECT SUM(risk) FROM hobby) > 0.9
;

--4.Вывести фамилию, имя, зачетку, дату рождения, название хобби и длительность в месяцах, 
--для всех завершенных хобби Диапазон дат.
SELECT st.name, st.surname, st.n_zachet, st.data_birth, h.name as hobby, 
extract(month from age(sh.date_finish, sh.date_start))+ extract (year from age (sh.date_finish, sh.date_start)*12) as prom
From student st
JOIN student_hobby sh ON st.id=sh.id_student
JOIN hobby h ON h.id=sh.id_hobby
WHERE sh.date_finish IS NOT NULL
;

--5. Вывести фамилию, имя, зачетку, дату рождения студентов, которым исполнилось N 
-- полных лет на текущую дату, и которые имеют более 1 действующего хобби.
SELECT st.name, st.surname, st.n_zachet, st.data_birth,  
extract(years from age(st.data_birth))
FROM student st
JOIN (SELECT s.name, s.surname, COUNT(sh.id_hobby) FROM
student s
JOIN student_hobby sh ON s.id = sh.id_student
GROUP BY s.name, s.surname
HAVING COUNT(sh.id_hobby) = 1) t
  ON t.surname = st.surname AND t.name = st.name
WHERE t.count > 1
;
-- никого не выведет, т.к. в моей таблице каждый студент заниается только одним хобби((\

--6.Найти средний балл в каждой группе, учитывая только баллы студентов, 
--которые имеют хотя бы одно действующее хобби.
SELECT st.n_group, AVG(st.score) FROM
student st
JOIN (SELECT s.name, s.surname FROM
student s
JOIN student_hobby sh ON s.id = sh.id_student
GROUP BY s.name, s.surname, sh.date_finish
HAVING sh.date_finish IS NULL) t ON t.name = st.name AND st.surname = t.surname
GROUP BY n_group
;

--7.Найти название, риск, длительность в месяцах самого продолжительного
-- хобби из действующих, указав номер зачетки студента.
SELECT h.name, st.n_zachet, h.risk, 12*extract(year from age(t.date_start))+extract(month from age(t.date_start)) as prom 
FROM
student st
JOIN (SELECT sh.date_start, sh.id_hobby, s.name, s.surname FROM
student s
JOIN student_hobby sh ON s.id = sh.id_student
GROUP BY sh.date_start, sh.id_hobby, s.name, s.surname, sh.date_finish
HAVING sh.date_finish IS NULL) t ON t.name = st.name AND st.surname = t.surname
JOIN hobby h ON h.id = t.id_hobby
;

--8. Найти все хобби, которыми увлекаются студенты, имеющие максимальный балл.
SELECT st.name, st.surname, h.name FROM student st
JOIN (SELECT st.id, st.name, st.score, st.surname, sh.id_hobby FROM
student st
JOIN student_hobby sh ON st.id = sh.id_student
GROUP BY st.id, st.name, st.surname, st.score, sh.id_hobby
HAVING st.score = (SELECT MAX(st.score) FROM student st)) t ON t.name = st.name and t.surname = st.surname
JOIN hobby h ON t.id_hobby = h.id
;

--9. Найти все действующие хобби, которыми увлекаются троечники 2-го курса
SELECT h.name, st.name, st.surname FROM student st
JOIN (SELECT sh.date_finish, sh.id_hobby, st.id, st.name, st.surname, substr(CAST(st.n_group AS varchar), 1, 1) AS course, st.score
    FROM student st
    JOIN student_hobby sh ON sh.id_student = st.id
    WHERE st.score >=2.5 and st.score < 3.5) t ON t.id = st.id
JOIN hobby h ON h.id = t.id_hobby
WHERE t.date_finish IS NULL
;

--10. Найти номера курсов, на которых более 50% 
--студентов имеют более одного действующего хобби.
SELECT q.course FROM (SELECT st.name, st.surname, COUNT(t.id_hobby), t.course FROM student st
    JOIN (SELECT sh.date_start, sh.id_hobby, s.name, s.surname, substr(CAST(s.n_group AS varchar), 1, 1) AS course FROM
        student s
        JOIN student_hobby sh ON s.id = sh.id_student
        GROUP BY s.n_group, sh.date_start, sh.id_hobby, s.name, s.surname, sh.date_finish
        HAVING sh.date_finish IS NULL) t 
    ON t.name = st.name and t.surname = st.surname
    GROUP BY st.name, st.surname, t.course
    HAVING COUNT(t.id_hobby) = 1 ) q
GROUP BY q.course
HAVING (SELECT SUM(q.count) FROM (SELECT st.name, st.surname, COUNT(t.id_hobby), t.course FROM student st
    JOIN (SELECT sh.date_start, sh.id_hobby, s.name, s.surname, substr(CAST(s.n_group AS varchar), 1, 1) AS course FROM
        student s
        JOIN student_hobby sh ON s.id = sh.id_student
        GROUP BY s.n_group, sh.date_start, sh.id_hobby, s.name, s.surname, sh.date_finish
        HAVING sh.date_finish IS NULL) t 
    ON t.name = st.name and t.surname = st.surname
    GROUP BY st.name, st.surname, t.course
    HAVING COUNT(t.id_hobby) = 1 ) q
GROUP BY q.count
HAVING q.count = 1 --т.к. таких студентов нет в принципе в таблице, то он выводит хотя бы на 1 действующее хобби
) / COUNT(q.name) * 100 > 50
;

--11.Вывести номера групп, в которых не менее 60% студентов имеют балл не ниже 4.
SELECT *
FROM (SELECT substr(st.n_group::varchar, 1,4) as NGROUP, count(*) as c_group
FROM student st
GROUP BY substr(st.n_group::varchar, 1,4)) as st_all
JOIN (
SELECT substr(st.n_group::varchar, 1,4) as NGROUP, count(*) as c_good
FROM student st
WHERE st.score>=4
GROUP BY substr(st.n_group::varchar, 1,4)
HAVING count (*)>1) as st_gd
ON st_all.NGROUP = st_gd.NGROUP
WHERE st_all.NGROUP::integer/st_gd.NGROUP::integer>=0.6
;

--12.Для каждого курса подсчитать количество различных действующих хобби на курсе.
SELECT substr(st.n_group::varchar, 1,1) as course, substr(sh.date_finish::varchar, 1,10) as finish, count(*) as c_good
From student st
JOIN student_hobby sh ON st.id=sh.id_student 
JOIN hobby h ON h.id=sh.id_student  
GROUP BY substr(sh.date_finish::varchar, 1,10),substr(st.n_group::varchar, 1,1)
HAVING count (*)>1
;

--13.Вывести номер зачётки, фамилию и имя, дату рождения и номер курса для всех отличников,
-- не имеющих хобби. Отсортировать данные по возрастанию в пределах курса по убыванию даты рождения.
SELECT st.id, st.name, st.surname, st.data_birth, substr(st.n_group::varchar, 1,1) as course, sh.date_finish
FROM student st
FULL JOIN student_hobby sh ON st.id=sh.id_student
WHERE st.score >=4.5
GROUP BY st.id, st.name, st.surname, st.data_birth, substr(st.n_group::varchar, 1,1), sh.date_finish
HAVING sh.date_finish IS NOT NULL
;

--14. Создать представление, в котором отображается вся информация о студентах, 
--которые продолжают заниматься хобби в данный момент и занимаются им как минимум 5 лет.
CREATE VIEW student_hobby1 AS
SELECT st.id, st.surname, st.name, st.n_group, st.data_birth FROM student st
JOIN student_hobby sh ON sh.id_student = st.id
WHERE sh.date_finish IS NULL AND EXTRACT(YEAR FROM age(sh.date_start))>=5
;
SELECT *FROM student_hobby1;
DROP VIEW student_hobby1;

--15. Для каждого хобби вывести количество людей, которые им занимаются.
SELECT h.name, COUNT(sh.id_student) FROM hobby h
JOIN student_hobby sh ON sh.id_hobby = h.id
GROUP BY h.name
;

--16. Вывести ИД самого популярного хобби
SELECT h.name, COUNT(sh.id_student) FROM hobby h
JOIN student_hobby sh ON sh.id_hobby = h.id
GROUP BY  h.name
HAVING COUNT(sh.id_student) = (SELECT MAX(t.count) FROM (SELECT h.name, COUNT(sh.id_student) FROM hobby h
JOIN student_hobby sh ON sh.id_hobby = h.id
GROUP BY  h.name
) t)
;

--17.Вывести всю информацию о студентах, занимающихся самым популярным хобби.
SELECT * FROM hobby h
JOIN (SELECT h.name, COUNT(sh.id_student) FROM hobby h
JOIN student_hobby sh ON sh.id_hobby = h.id
GROUP BY  h.name
HAVING COUNT(sh.id_student) = (SELECT MAX(t.count) FROM (SELECT h.name, COUNT(sh.id_student) FROM hobby h
JOIN student_hobby sh ON sh.id_hobby = h.id
GROUP BY  h.name
) t))q ON q.name = h.name
JOIN student_hobby sh ON h.id = sh.id_hobby
JOIN student st ON st.id = sh.id_student
;

--18.Вывести ИД 3х хобби с максимальным риском.
SELECT h.id, h.risk FROM hobby h
ORDER BY h.risk DESC LIMIT(3)
;

--19.Вывести 10 студентов, которые занимаются одним (или несколькими) хобби самое продолжительно время.
SELECT st.name, st.surname, (sh.date_finish-sh.date_start) as prom FROM student st
JOIN student_hobby sh ON sh.id_student = st.id
ORDER BY prom DESC LIMIT(10)
;

--20.Вывести номера групп (без повторений), в которых учатся студенты из предыдущего запроса.
SELECT DISTINCT t.n_group FROM (
    SELECT st.id, st.name, st.surname, st.n_group, (sh.date_finish-sh.date_start) as prom FROM student st
    JOIN student_hobby sh ON sh.id_student = st.id
ORDER BY prom DESC LIMIT(10)) t
;

--21.Создать представление, которое выводит номер зачетки, имя и фамилию студентов, 
--отсортированных по убыванию среднего балла.
CREATE VIEW student1 AS
SELECT st.n_zachet, st.name, st.surname, st.score FROM student st
ORDER BY st.score DESC;
SELECT *FROM student1;

--22.Представление: найти каждое популярное хобби на каждом курсе.
CREATE OR REPLACE VIEW student_hobby1 AS
with c_hobby as(
			select substr(st.n_group::varchar,1,1) as course, sh.id_hobby, count(*) as c
			from student st
			join student_hobby sh on st.id=sh.id_student
			group by substr(st.n_group::varchar,1,1), sh.id_hobby), 
			max_for_course as(
							select c_h.course, max(c) as max_c
							from c_hobby c_h
							group by c_h.course)
							
select *
from max_for_course m_f_c
join c_hobby c_h on c_h.course = m_f_c.course and m_f_c.max_c= c_h.c;
select *from student_hobby1;
--23.Представление: найти хобби с максимальным риском среди самых популярных хобби на 2 курсе.
CREATE OR REPLACE VIEW student_hobby1 AS
with c_hobby as(
			select substr(st.n_group::varchar,1,1) as course, sh.id_hobby, count(*) as c
			from student st
			inner join student_hobby sh on st.id=sh.id_hobby
			where substr(st.n_group::varchar,1,1) = '2'
			group by substr(st.n_group::varchar,1,1), sh.id_hobby), 
			max_for_course as(
							select c_h.course, max(c) as max_c
							from c_hobby c_h
							group by c_h.course)

select *
from max_for_course m_f_c
inner join c_hobby c_h on c_h.course = m_f_c.course and m_f_c.max_c= c_h.c
;

--24.Представление: для каждого курса подсчитать количество студентов на курсе и количество отличников.
CREATE OR REPLACE VIEW student_hobby1 AS
with all_students as(
			select substr(st.n_group::varchar,1,1) as course, count(distinct(st.name)) as all_course
			from student st
			group by substr(st.n_group::varchar,1,1)), 
			good_student as(
							select substr(st.n_group::varchar,1,1) as course, count(distinct(st.name)) as g_s
							from student st
							where st.score>4.5
							group by substr(st.n_group::varchar,1,1))

select *
from all_students a_s
full join good_students gs on a_s.course = gs.course
;

--25.Представление: самое популярное хобби среди всех студентов.
CREATE OR REPLACE VIEW popular_hobby AS
SELECT h.*
from hobby h
JOIN student_hobby sh ON h.id=sh.id_hobby 
JOIN student st ON st.id=sh.id_student
WHERE sh.date_finish IS NULL
GROUP BY h.id, h.name
ORDER BY count(st.name) DESC
LIMIT (1);
SELECT *FROM popular_hobby;
--26.Создать обновляемое представление.
CREATE OR REPLACE VIEW View_update AS
SELECT st.id, st.surname, st.name, st.n_group 
FROM students st
;

--27.Для каждой буквы алфавита из имени найти максимальный, средний и минимальный балл. 
--(Т.е. среди всех студентов, чьё имя начинается на А (Алексей, Алина, Артур, Анджела) найти то, 
--что указано в задании. Вывести на экран тех, максимальный балл которых больше 3.6
SELECT substr(st.name::varchar, 1,1) as alfavit, Max(st.score), avg(st.score), min(st.score)
FROM student st
WHERE st.score>3.6
GROUP BY alfavit
;

--28.Для каждой фамилии на курсе вывести максимальный и минимальный средний балл. 
--(Например, в университете учатся 4 Иванова (1-2-3-4). 1-2-3 учатся на 2 курсе и имеют средний балл 
--4.1, 4, 3.8 соответственно, а 4 Иванов учится на 3 курсе и имеет балл 4.5. 
--На экране должно быть следующее: 2 Иванов 4.1 3.8 3 Иванов 4.5 4.5
SELECT substr(st.n_group::varchar, 1,1) as course, st.surname, max(st.score), min(st.score), avg(st.score)
FROM student st
GROUP BY course, st.surname
;

--29.Для каждого года рождения подсчитать количество хобби, которыми занимаются или занимались студенты.
SELECT substr(st.data_birth::varchar, 1,4) as year, count(h.name)
FROM student st
JOIN student_hobby sh ON st.id=sh.id_student
JOIN hobby h ON h.id=sh.id_hobby 
GROUP BY year
;

--30.Для каждой буквы алфавита в имени найти максимальный и минимальный риск хобби.
SELECT substr(st.name::varchar, 1,1) as alfavit, Max(h.risk), min(h.risk)
FROM student st
JOIN student_hobby sh ON st.id=sh.id_student 
JOIN hobby h ON h.id=sh.id_hobby
GROUP BY alfavit
;

--31.Для каждого месяца из даты рождения вывести средний балл студентов, 
--которые занимаются хобби с названием «Футбол»
SELECT extract(month from st.data_birth), avg(st.score)
FROM student st
JOIN student_hobby sh ON st.id = sh.id_student
JOIN hobby h ON h.id = sh.id_hobby
WHERE h.name = 'Футбол'
GROUP BY extract(month from st.data_birth)
;

--32.Вывести информацию о студентах, которые занимались или 
--занимаются хотя бы 1 хобби в следующем формате: Имя: Иван, фамилия: Иванов, группа: 1234
SELECT ' Имя: ' || st.name || ' Фамилия: ' || st.surname || ' Группа:' || st.n_group as students
FROM student st
FULL JOIN student_hobby sh ON st.id = sh.id_student
WHERE sh.date_start is not null
;

--33.Найдите в фамилии в каком по счёту символа встречается «ов». 
--Если 0 (т.е. не встречается, то выведите на экран «не найдено».
SELECT st.surname,
		case when position('ов' IN st.surname) = 0 then 'не найдено'
				else position('ов' IN st.surname)::varchar end
from student st
;

--34.Дополните фамилию справа символом # до 10 символов.
SELECT rpad(st.surname,10,'#') 
FROM student st
;

--35.При помощи функции удалите все символы # из предыдущего запроса.
SELECT trim('#' FROM n_surname) 
FROM (SELECT rpad(st.surname,10,'#') as n_surname
		FROM student st) as all_surname
;

--36.Выведите на экран сколько дней в апреле 2018 года.
SELECT '2018-05-01'::date -'2018-04-01'::date
;

--37.Выведите на экран какого числа будет ближайшая суббота.
SELECT EXTRACT(DOW FROM now ()) as goodday,
		CASE WHEN (EXTRACT(DOW FROM now ())::integer) = 1 THEN (now()::date+5)
		  WHEN (EXTRACT(DOW FROM now ())::integer) = 2 THEN (now()::date+4)
		   WHEN (EXTRACT(DOW FROM now ())::integer) = 3 THEN (now()::date+3)
		    WHEN (EXTRACT(DOW FROM now ())::integer) = 4 THEN (now()::date+2)
			 WHEN (EXTRACT(DOW FROM now ())::integer) = 5 THEN (now()::date+1)
			  WHEN (EXTRACT(DOW FROM now ())::integer) = 6 THEN (now()::date)
			   WHEN (EXTRACT(DOW FROM now ())::integer) = 7 THEN (now()::date+6)
		END 
;

--38.Выведите на экран век, а также какая сейчас неделя года и день года.
SELECT EXTRACT(CENTURY FROM now ()) as century, EXTRACT(WEEK FROM now ()) as week, EXTRACT(DOY FROM now ()) as day
;

--39.Выведите всех студентов, которые занимались или занимаются хотя бы 1 хобби. 
--Выведите на экран Имя, Фамилию, Названию хобби, а также надпись «занимается», 
--если студент продолжает заниматься хобби в данный момент или «закончил», если уже не занимает.
SELECT st.name || ' ' || st.surname || ' ' || h.name || ' ' || CASE WHEN sh.date_finish IS NULL THEN 'занимается'
																	WHEN sh.date_finish IS NOT NULL THEN 'закончил'
																	END
FROM student st
JOIN student_hobby sh on sh.id_student=st.id
JOIN hobby h on h.id=sh.id_hobby
WHERE sh.date_start IS NOT NULL
;

--40.Для каждой группы вывести сколько студентов учится на 5,4,3,2. Использовать обычное математическое округление. 
--Итоговый результат должен выглядеть примерно в таком виде:
SELECT n_group as groups, 
count(score) filter(WHERE round(score) = '2') as "2",
count(score) filter(WHERE round(score) = '3') as "3",
count(score)filter(WHERE round(score) = '4') as "4",
count(score) filter(WHERE round(score) = '5') as "5"
FROM student 
GROUP BY n_group
ORDER BY n_group ASC