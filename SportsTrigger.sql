--TRIGGERS FOR DML 
--1. WHEN DELETING INFORMATION FROM PLAYER TABLE
use dmdd_proj;
go
CREATE TABLE PlayerAudit (
    PlayerID INT IDENTITY(1,1) PRIMARY KEY,
    [Name] varchar(50) NOT NULL,
    TeamID varchar(10) NOT NULL FOREIGN KEY REFERENCES Team(TeamID),
    JerseyNbr int NOT NULL,
    TotalMatch int NOT NULL,
    PlayerType varchar(8) NOT NULL CHECK (PlayerType IN ('Bowler', 'Batter')),
    NbrofCatch int NOT NULL,
	[Action] char(1),
	[ActionDate] datetime
);

--Deletion
CREATE TRIGGER DeletePlayerTrigger
ON dbo.Player
AFTER DELETE
AS
BEGIN  --insert old values in the table
declare @action char(1)
SET @action = 'D'
    INSERT INTO PlayerAudit (PlayerID, [Name], TeamID, JerseyNbr, TotalMatch, PlayerType, NbrofCatch, [Action], [ActionDate])
    SELECT d.PlayerID, d.[Name], d.TeamID, d.JerseyNbr, d.TotalMatch, d.PlayerType, d.NbrofCatch, @action, GETDATE()
    FROM deleted d;
END;

--2. WHEN UPDATING INFORMATION IN PLAYER TABLE
CREATE TABLE PlayerOld (
    PlayerID INT IDENTITY(1,1) PRIMARY KEY,
    [Name] varchar(50) NOT NULL,
    TeamID varchar(10) NOT NULL FOREIGN KEY REFERENCES Team(TeamID),
    JerseyNbr int NOT NULL,
    TotalMatch int NOT NULL,
    PlayerType varchar(8) NOT NULL CHECK (PlayerType IN ('Bowler', 'Batter')),
    NbrofCatch int NOT NULL,
	[Action] char(1),
	[ActionDate] datetime
);

CREATE TRIGGER UpdatePlayerTrigger
ON dbo.Player
FOR UPDATE
AS
BEGIN  --insert old values in the table
declare @action char(1)
SET @action = 'U'
    INSERT INTO PlayerOld (PlayerID, [Name], TeamID, JerseyNbr, TotalMatch, PlayerType, NbrofCatch, [Action], [ActionDate])
    SELECT d.PlayerID, d.[Name], d.TeamID, d.JerseyNbr, d.TotalMatch, d.PlayerType, d.NbrofCatch, @action, GETDATE()
    FROM deleted d;
END;