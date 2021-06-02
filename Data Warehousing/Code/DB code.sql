CREATE TABLE PatientFile
(
    PatientID   varchar(5)  NOT NULL,
    PersonID    varchar(10) NOT NULL,
    TreatmentID varchar(10) NOT NULL,
    PRIMARY KEY (PatientID),
    FOREIGN KEY (PersonID) REFERENCES PersonalInfo (PersonID),
    FOREIGN KEY (TreatmentID) REFERENCES TreatmentPlan (TreatmentID)
);

CREATE TABLE PersonalInfo
(
    PersonID varchar(10) NOT NULL,
    ContactID varchar(5) NOT NULL,
    FirstName varchar(25) NOT NULL,
    LastName varchar(25) NOT NULL,
    StreetNumber    varchar(10) NOT NULL,
    StreetName  varchar(50) NOT NULL,
    City    varchar(25) NOT NULL,
    State   varchar(2) NOT NULL,
    Zip     varchar(5) NOT NULL,
    PRIMARY KEY (PersonID),
    FOREIGN KEY (ContactID) REFERENCES ContactInfo (ContactID)
);

CREATE TABLE ContactInfo
(
    ContactID varchar(5) NOT NULL,
    PhoneNumber varchar(12) NOT NULL,
    Email   varchar(50) NOT NULL,
    Prefrence   varchar(10) NOT NULL,
    PRIMARY KEY (ContactID)
);

CREATE TABLE TreatmentPlan
(
    TreatmentID varchar(10) NOT NULL,
    ChiroID int NOT NULL,
    CodeID varchar(8) NOT NULL,
    TherapyID varchar(5) NOT NULL,
    ScheduleID varchar(5) NOT NULL,
    PRIMARY KEY (TreatmentID),
    FOREIGN KEY (ChiroID) REFERENCES Chiropractor (ChiroID),
    FOREIGN KEY (CodeID) REFERENCES ICD_10_Codes (CodeID),
    FOREIGN KEY (TherapyID) REFERENCES ReqTherapies (TherapyID),
    FOREIGN KEY (ScheduleID) REFERENCES Appointment (ScheduleID)
);

CREATE TABLE ICD_10_Codes
(
    CodeID varchar(8) NOT NULL,
    Code_Name varchar(30) NOT NULL
    PRIMARY KEY (CodeID)
);

CREATE TABLE Appointment
(
    ScheduleID varchar(5) NOT NULL,
    TimeOfDay time NOT NULL,
    AmPm char(2),
    Day varchar(3) NOT NULL,
    DayOfMonth int NOT NULL,
    Month varchar(15) NOT NULL,
    Year int NOT NULL,
    PRIMARY KEY (ScheduleID)
);

CREATE TABLE Chiropractor
(
    ChiroID int IDENTITY(1,1) NOT NULL PRIMARY KEY,
    FirstName varchar(25) NOT NULL,
    LastName varchar(25) NOT NULL
);

CREATE TABLE ReqTherapies
(
    TherapyID varchar(5) NOT NULL PRIMARY KEY,
    MechTrac bit,
    Adjustment bit NOT NULL,
    TE bit  NOT NULL,
    DryHydro bit,
    Massage bit,
    ElecStim bit
);
GO
   