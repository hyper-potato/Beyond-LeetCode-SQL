USE LeetCode;

-- Mysql my solution
SELECT America, Asia, Europe
  FROM (SELECT (@row1 := @row1 + 1) AS id,
               name AS America
          FROM student, (SELECT @row1 := 0) r
         WHERE continent = 'America'
         ORDER BY name) America
       LEFT OUTER JOIN
       (SELECT (@row2 := @row2 + 1) AS id, name AS Asia
          FROM student, (SELECT @row2 := 0) r
         WHERE continent = 'Asia'
         ORDER BY name) Asia USING (id) LEFT OUTER JOIN
       (SELECT (@row3 := @row3 + 1) AS id, name AS Europe
          FROM student, (SELECT @row3 := 0) r
         WHERE continent = 'Europe'
         ORDER BY name) Europe USING (id);



-- MS SQL
SELECT
  a.name AS America
  ,b.name AS Asia
  ,c.name AS Europe
FROM
(SELECT ROW_NUMBER() OVER (ORDER BY name) AS ID, name FROM student WHERE continent = 'America') a
FULL JOIN
(SELECT ROW_NUMBER() OVER (ORDER BY name) AS ID, name FROM student WHERE continent = 'Asia') b
ON a.ID = b.ID
FULL JOIN
(SELECT ROW_NUMBER() OVER (ORDER BY name) AS ID, name FROM student WHERE continent = 'Europe') c
ON c.ID = b.ID
OR c.ID = a.ID;