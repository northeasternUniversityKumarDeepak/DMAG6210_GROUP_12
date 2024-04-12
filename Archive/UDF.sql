
--1. GET PLAYER INFO BASED ON PLAYER ID
--2. team stats based on team id
--3. coach details based on coad id
--4. 

--TRIGGER
--deleting player data
-- deleting team data
--deleting tournament data
 

 --VIEW
 --QUALIFY: TEAM AND TOURNAMENT
 --BASED ON PLAYER -> PLAYERNAME, TEAMNAME, COACHNAME, WICKETS, RUNS, 
 --TEAM ID, NO. OF MAT

 UDF
 --WINNING RATE 

-- Function to Calculate Win percentage of the Teams
ALTER FUNCTION WinRate
(
    @MatchesPlayed int,
    @MatchesWon int
)
RETURNS INT
AS
BEGIN
    DECLARE @TeamWinRate int;

    IF @MatchesPlayed > 0
    BEGIN
        SET @TeamWinRate = (@MatchesWon * 100) / @MatchesPlayed;
    END
    ELSE
    BEGIN
        SET @TeamWinRate = 0; -- Default to 0 if no matches played
    END

    RETURN CAST(@TeamWinRate AS INT);
END;

select dbo.WinRate(208,121);

--UDF to calculate Coach tenure
CREATE FUNCTION CoachTenure
(
    @InputDate date
)
RETURNS int
AS
BEGIN
    DECLARE @AgeInYears int;

    -- Calculate the age difference in years
    SELECT @AgeInYears = DATEDIFF(year, @InputDate, GETDATE());

    RETURN @AgeInYears;
END;



select dbo.CoachTenure('5/1/2024');
