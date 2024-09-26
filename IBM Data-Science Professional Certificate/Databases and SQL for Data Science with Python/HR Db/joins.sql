/*
Retrieve employee ID, last name, and department ID for all employees but department names for only those born before 1980.
*/

SELECT E.EMP_ID, E.L_NAME, D.DEP_NAME
FROM 
EMPLOYEES AS E LEFT JOIN  DEPARTMENTS D 
ON E.DEP_ID = D.DEPT_ID_DEP
WHERE YEAR(E.B_DATE) < 1980;

/*
Retrieve the first name and last name of all employees but department ID and department names only for male employees.
*/
-- 1.
SELECT E.F_NAME, E.L_NAME, D.DEPT_ID_DEP,D.DEP_NAME
FROM
EMPLOYEES AS E 
LEFT OUTER JOIN 
DEPARTMENTS AS D 
ON E.DEP_ID = D.DEPT_ID_DEP AND E.SEX='M';
-- 2.
SELECT E.F_NAME, E.L_NAME, D.DEPT_ID_DEP, D.DEP_NAME
FROM EMPLOYEES AS E
LEFT OUTER JOIN DEPARTMENTS AS D
ON E.DEP_ID=D.DEPT_ID_DEP AND E.SEX = 'M'

UNION

SELECT E.F_NAME, E.L_NAME, D.DEPT_ID_DEP, D.DEP_NAME
from EMPLOYEES AS E
RIGHT OUTER JOIN DEPARTMENTS AS D
ON E.DEP_ID=D.DEPT_ID_DEP AND E.SEX = 'M';