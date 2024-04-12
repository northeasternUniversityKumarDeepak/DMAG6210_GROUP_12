--STORED PROCEDURES
use dmdd_proj;

--1. RETRIEVE PLAYER INFORMATION
ALTER PROCEDURE GetPlayerInfo
    @PlayerID INT
AS
BEGIN
    SET NOCOUNT ON;
	--player name, team name, franchise name, totalmatch, totalRuns, brand ambassador, company
    SELECT p.[Name], t.TeamName, p.TotalRuns, f.FranchiseName, CompanyName
    FROM Player p 
	left join team t on p.TeamID = t.TeamID
	left join Franchise f on t.FranchiseID = f.FranchiseID
	left join BrandAmbassador b on p.PlayerID = b.PlayerID
	left join Company c on c.CompanyID = b.CompanyID
    WHERE P.PlayerID = @PlayerID;
END;

EXEC GetPlayerInfo @PlayerID =4400;

--2. TEAM STATISTICS
select*from TeamPerformance

CREATE PROCEDURE TeamInfo
    @TeamID INT
AS
BEGIN
    SET NOCOUNT ON;
	--player name, team name, franchise name, coach name, owner
    SELECT t.TeamName, f.FranchiseName, C.[Name] as CoachName, tp.MatchesPlayed, tp.MatchesWon, tp.TournamentsWon, f.FranchiseOwner
    FROM Team t 
	left join TeamPerformance tp on t.TeamID = tp.TeamID
	left join Coach c on t.CoachID = c.CoachID
	left join Franchise f on t.FranchiseID = f.FranchiseID
    WHERE t.TeamID = @TeamID;
END

--3. STORED PROCEDURE FOR MATCH
CREATE PROCEDURE MatchInfo
    @MatchID INT
AS
BEGIN
    SET NOCOUNT ON;
	--player name, team name, franchise name, coach name, owner
    SELECT m.MatchID, t.TeamName as WinningTeam, v.[Name] as VenueName, ms.PlayerofMatch
    FROM [Match] m 
	left join Venue v on m.VenueID = v.VenueID
	left join Team t on t.TeamID = m.WinningTeamID
	left join MatchStats ms on m.MatchID = ms.MatchID
    WHERE m.MatchID = @MatchID;
END

