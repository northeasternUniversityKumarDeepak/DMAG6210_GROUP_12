create database sportmngmnt;
use sportmngmnt;

CREATE TABLE Coach (
    CoachID varchar(10) PRIMARY KEY,
    [Name] varchar(30) NOT NULL,
    StartDate date NOT NULL,
    CoachingTenure int NULL
);

CREATE TABLE Franchise (
    FranchiseID varchar(10) PRIMARY KEY,
    FranchiseName varchar(200) NOT NULL,
    FranchiseOwner varchar(200) NULL
);

CREATE TABLE Team (
    TeamID varchar(10) PRIMARY KEY,
    TeamName varchar(100) NOT NULL,
    CoachID varchar(10) FOREIGN KEY REFERENCES Coach(CoachID),
    FranchiseID varchar(10) NOT NULL FOREIGN KEY REFERENCES Franchise(FranchiseID)
);

CREATE TABLE Player (
    PlayerID INT  PRIMARY KEY,
    [Name] varchar(50) NOT NULL,
    TeamID varchar(10) NULL FOREIGN KEY REFERENCES Team(TeamID),
    JerseyNbr int  NULL,
    TotalMatch int  NULL,
    NbrofCatch int  NULL,
    DominantHand varchar(30) NULL CHECK (DominantHand IN ('Right_Hand', 'Left_Hand')),
    BattingAvg float NULL,
    Centuries int NULL,
    HalfCenturies int NULL,
    TotalRuns int NULL,
    BowlerType varchar(50) NULL CHECK (BowlerType IN ('Left-arm fast','Left-arm fast-medium','Left-arm medium','Left-arm medium-fast','Legbreak','Legbreak googly','Right-arm bowler','Right-arm fast','Right-arm fast-medium',
'Right-arm medium','Right-arm medium-fast','Right-arm offbreak','Slow left-arm chinaman' , 'Slow left-arm orthodox')), 
    Wickets int NULL
);

CREATE TABLE Company (
    CompanyID varchar(10) PRIMARY KEY,
    CompanyName varchar(100) NOT NULL,
    IndustryType varchar(100)  NULL
);

CREATE TABLE BrandAmbassador (
    AmbassadorID varchar(10) PRIMARY KEY,
    CompanyID VARCHAR(10) NOT NULL FOREIGN KEY REFERENCES Company(CompanyID),
    PlayerID INT NOT NULL FOREIGN KEY REFERENCES Player(PlayerID),
    StartDate date  NULL,
    EndDate date  NULL
);

CREATE TABLE Contract (
    ContractID varchar(5) PRIMARY KEY,
    CoachID varchar(10) NOT NULL FOREIGN KEY REFERENCES Coach(CoachID),
    PlayerID INT NOT NULL FOREIGN KEY REFERENCES Player(PlayerID),
    TeamID varchar(10) NOT NULL FOREIGN KEY REFERENCES Team(TeamID),
    StartDate date NOT NULL,
    EndDate date NOT NULL,
    Terms varchar(100) NOT NULL
);

CREATE TABLE TeamPerformance (
    TeamID varchar(10) PRIMARY KEY FOREIGN KEY REFERENCES Team(TeamID),
    MatchesPlayed int NULL,
    MatchesWon int NULL,
    MatchesLost int NULL,
    TournamentsWon int NULL
);

CREATE TABLE Venue (
    VenueID varchar(5) PRIMARY KEY,
    [Name] varchar(100) NOT NULL,
    Capacity int NOT NULL,
    City varchar(50) NOT NULL,
    [State] varchar(50) NULL,
    Country varchar(50) NULL
);

CREATE TABLE Tournament (
    TournamentID varchar(10) PRIMARY KEY,
    TournamentName varchar(50) NOT NULL,
    StartDate date NULL,
    EndDate date NULL
);


CREATE TABLE [Match] (
    MatchID varchar(5) PRIMARY KEY,
    TournamentID varchar(10) NOT NULL FOREIGN KEY REFERENCES Tournament(TournamentID),
    VenueID varchar(5) NOT NULL FOREIGN KEY REFERENCES Venue(VenueID),
    MatchDate date NULL,
    WinningTeamID varchar(5) NULL,
    LosingTeamID varchar(5) NULL
);


CREATE TABLE MatchStats (
    MatchID varchar(5) PRIMARY KEY FOREIGN KEY REFERENCES [Match](MatchID),
    TotalRuns int NULL,
    TotalWickets int NULL,
    HighestScore int NULL,
    BestBowler INT NULL FOREIGN KEY REFERENCES Player(PlayerID),
    BestBatter INT NULL FOREIGN KEY REFERENCES Player(PlayerID),
    Catches int NULL,
    Runout int NULL,
    PlayerofMatch INT NULL FOREIGN KEY REFERENCES Player(PlayerID)
);

CREATE TABLE InjuryDetail (
    PhysioID varchar(5) PRIMARY KEY,
    PlayerID INT NOT NULL FOREIGN KEY REFERENCES Player(PlayerID),
    InjuryType varchar(30) NOT NULL,
    InjuryDate date NOT NULL,
    RecoveryDuration varchar(50) null
	);




--Add foreign key constraint to Team table
ALTER TABLE Team
ADD CONSTRAINT FK_Team_Franchise
FOREIGN KEY (FranchiseID)
REFERENCES Franchise(FranchiseID);

--ALTERING TABLE 
ALTER TABLE Franchise
ALTER COLUMN FranchiseName VARCHAR(200);

ALTER TABLE Franchise
ALTER COLUMN FranchiseOwner VARCHAR(200);

--adding check constraint in InjuryDetail Table
ALTER TABLE InjuryDetail
ADD CONSTRAINT chk_injuryType 
CHECK (injuryType IN ('Musculoskeletal', 'Impact', 'Overuse', 'Spinal', 'Soft Tissue', 'Joint'));








