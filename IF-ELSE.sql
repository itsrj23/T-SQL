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

    IF @Age >= 14 AND @Age <= 16
    BEGIN
        SET @Level = LOWER('Freshman');
    END
    ELSE IF @Age >= 17 AND @Age <= 19
    BEGIN
        SET @Level = LOWER('Sophomore');
    END
    ELSE IF @Age >= 20 AND @Age <= 22
    BEGIN
        SET @Level = LOWER('Junior');
    END
    ELSE IF @Age >= 23 AND @Age <= 25
    BEGIN
        SET @Level = LOWER('Senior');
    END
    ELSE
    BEGIN
        SET @Level = LOWER('Unknown');
    END

    PRINT CONCAT(CAST(@ID AS VARCHAR(10)), ' ', @LastName, ' ', @FirstName, 
                 ' ', CAST(@Age AS VARCHAR(3)), ' ', @Gender, ' ', @Level);

    SET @Counter += 1;
END;

-- Drop the temporary table
DROP TABLE #ID;
