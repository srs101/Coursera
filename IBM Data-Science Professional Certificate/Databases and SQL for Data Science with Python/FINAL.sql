-- 1.
-- Write and execute a SQL query to list the school names, community names and average attendance for communities with a hardship index of 98.
/*
SELECT SC.NAME_OF_SCHOOL, SC.COMMUNITY_AREA_NAME, SC.AVERAGE_STUDENT_ATTENDANCE, SB.HARDSHIP_INDEX
FROM chicago_public_schools AS SC LEFT JOIN chicago_socioeconomic_data AS SB 
ON SB.COMMUNITY_AREA_NUMBER = SC.COMMUNITY_AREA_NUMBER 
WHERE SB.HARDSHIP_INDEX=98;

-- FOR CROSS CHECKING MY ANS
SELECT *
FROM chicago_socioeconomic_data AS SB
WHERE SB.HARDSHIP_INDEX=98;

SELECT * 
FROM chicago_public_schools
WHERE chicago_public_schools.COMMUNITY_AREA_NAME='RIVERDALE';

-- 2.
-- Write and execute a SQL query to list all crimes that took place at a school. Include case number, crime type and community name.
SELECT * FROM
chicago_crime 
WHERE chicago_crime.LOCATION_DESCRIPTION LIKE '%SCHOOL%';


-- Write and execute a SQL query to list all crimes that took place at a school. Include case number, crime type and community name
SELECT * FROM
chicago_crime 
WHERE chicago_crime.LOCATION_DESCRIPTION LIKE '%SCHOOL%';

-- 3.
-- Write and execute a SQL statement to create a view showing the columns listed in the following table, with new column names as shown in the second column.
 

# CREATED VIEW SO THAT'S WHY COMMENTED 
CREATE VIEW CPS_INFO (School_Name, Safety_Rating, Family_Rating, Environment_Rating, 
                      Instructor_Rating, Leader_rating, Teacher_Rating)
AS SELECT CPS.NAME_OF_SCHOOL, CPS.Safety_Icon, CPS.Family_Involvement_Icon, CPS.Environment_Icon, CPS.Instruction_Icon, CPS.Leaders_Icon, CPS.Teachers_Icon
FROM
chicago_public_schools AS CPS; 

-- Write and execute a SQL statement that returns all of the columns from the view.

SELECT * FROM CPS_INFO;

-- Write and execute a SQL statement that returns just the school name and leaders rating from the view.
SELECT School_Name, Leader_Rating FROM CPS_INFO;
*/
-- 4.
-- Write the structure of a query to create or replace a stored procedure called UPDATE_LEADERS_SCORE that takes a in_School_ID parameter as an integer and a in_Leader_Score parameter as an integer.

DELIMITER ##
CREATE PROCEDURE UPDATE_LEADER_SCORE(in_School_ID int, in_Leader_Score varchar(3))
BEGIN
	-- UPDATING LEADER SCORE
	UPDATE chicago_public_schools
    SET Leaders_Score = in_Leader_Score
	WHERE School_ID = in_School_ID;
    
    -- UPDATING LEADER ICON
    IF in_Leader_Score > 0 AND in_Leader_Score < 20 THEN
		-- update icon for 0-19
        UPDATE chicago_public_schools
        SET Leaders_Icon = 'Very weak' 
        WHERE School_ID = in_School_ID;
        
	ELSEIF in_Leader_Score < 40 THEN
		-- update icon for 20-39
        UPDATE chicago_public_schools
        SET Leaders_Icon = 'Weak' 
        WHERE School_ID = in_School_ID;
        
	ELSEIF in_Leader_Score < 60 THEN
		-- update icon for 40-59
        UPDATE chicago_public_schools
        SET Leaders_Icon = 'Average' 
        WHERE School_ID = in_School_ID;
        
	ELSEIF in_Leader_Score < 80 THEN
        -- update icon for 60-79
        UPDATE chicago_public_schools
        SET Leaders_Icon = 'Strong' 
        WHERE School_ID = in_School_ID;
        
	ELSEIF in_Leader_Score < 100 THEN
        -- update icon for 80-99
        UPDATE chicago_public_schools
        SET Leaders_Icon = 'Very strong' 
        WHERE School_ID = in_School_ID;
	END IF;
END ##
DELIMITER ;


-- 610212, 610209, 610316

SELECT CPS.School_ID, CPS.Leaders_Icon, CPS.Leaders_Score
FROM chicago_public_schools CPS
WHERE CPS.School_ID IN (610212, 610209, 610316);

CALL UPDATE_LEADER_SCORE(610212,'69');
CALL UPDATE_LEADER_SCORE(610209,'50');
CALL UPDATE_LEADER_SCORE(610316,'0');

SELECT CPS.School_ID, CPS.Leaders_Icon, CPS.Leaders_Score
FROM chicago_public_schools CPS
WHERE CPS.School_ID IN (610212, 610209, 610316);
CALL