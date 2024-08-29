USE LabDb;

SELECT ROW_NUMBER() OVER (ORDER BY ID) AS Rn, * 
INTO #ID 
FROM Record;

DECLARE @TotalCount INT, @Counter INT, @ID INT, 
        @LastName VARCHAR(99), @FirstName VARCHAR(99), 
        @Age INT, @Gender VARCHAR(99), @Level VARCHAR(99);

SELECT @TotalCount = COUNT(1) FROM #ID;
SET @Counter = 1;

WHILE @Counter <= @TotalCount
BEGIN
    SELECT @ID = ID, @LastName = LastName, @FirstName = FirstName, 
           @Age = Age, @Gender = Gender, @Level = Level 
    FROM #ID 
    WHERE Rn = @Counter;

	SET @Level = 
	CASE 
		WHEN @Age >= 14 AND @Age <= 16 THEN UPPER('Freshmen')
		 WHEN @Age >= 17 AND @Age <= 19 THEN UPPER('Sophomore')
        WHEN @Age >= 20 AND @Age <= 22 THEN UPPER('Junior')
        WHEN @Age >= 23 AND @Age <= 25 THEN UPPER('Senior')
        ELSE UPPER('Unknown')
    END;

	--PRINT CONCAT(CAST(@ID AS VARCHAR(10)), ' ', @LastName, ' ', @FirstName, 
              --   ' ', CAST(@Age AS VARCHAR(3)), ' ', @Gender, ' ', @Level);
	 PRINT 'Id: ' + CAST(@ID AS VARCHAR(10)) + 
          ' | Name: ' + @FirstName + ' ' + @LastName + 
          ' | Age: ' + CAST(@Age AS VARCHAR(3)) + 
          ' | Gender: ' + @Gender + 
          ' | Level: ' + @Level;

    SET @Counter += 1;
END;

DROP TABLE #ID