INSERT INTO PatientFile VALUES ('00001', 'jodoe00001', 'jodoe00001');
INSERT INTO PatientFile VALUES ('00002', 'jadoe00002', 'jadoe00002');
INSERT INTO PatientFile VALUES ('00003', 'mamil00003', 'mamil00003');
INSERT INTO PatientFile VALUES ('00004', 'bishe00004', 'bishe00004');
INSERT INTO PatientFile VALUES ('00005', 'momil00005', 'momil00005');
INSERT INTO PatientFile VALUES ('00006', 'scfie00006', 'scfie00006');

INSERT INTO PersonalInfo VALUES ('jodoe00001', '00001', 'John', 'Doe', '111', 'Maple Ave', 'Indianapolis', 'IN', '46260');
INSERT INTO PersonalInfo VALUES ('jadoe00002', '00002', 'Jane', 'Doe', '456', 'Wall Way', 'Indianapolis', 'IN', '46260');
INSERT INTO PersonalInfo VALUES ('mamil00003', '00003', 'Mary', 'Miller', '14556', 'Appleton Court', 'Indianapolis', 'IN', '46260');
INSERT INTO PersonalInfo VALUES ('bishe00004', '00004', 'Bill', 'Sheppard', '739', 'Delta Street', 'Indianapolis', 'IN', '46256');
INSERT INTO PersonalInfo VALUES ('momil00005', '00005', 'Monique', 'Miles', '300', 'South Way', 'Indianapolis', 'IN', '46231'); 
INSERT INTO PersonalInfo VALUES ('scfie00006', '00006', 'Scott', 'Fier', '7', 'Hullabaloo Court', 'Carmel', 'IN', '46033');

INSERT INTO ContactInfo VALUES ('00001', '317-677-0789', 'jrdoe@hotmail.com', 'Phone');
INSERT INTO ContactInfo VALUES ('00002', '317-709-1313', 'jane_d14@google.com', 'Phone');
INSERT INTO ContactInfo VALUES ('00003', '317-553-3535', 'miller_time@google.com', 'Email');
INSERT INTO ContactInfo VALUES ('00004', '812-688-5643', 'williamshep@yahoo.com', 'Phone');
INSERT INTO ContactInfo VALUES ('00005', '756-131-4456', 'mon4miles@google.com', 'Email');
INSERT INTO ContactInfo VALUES ('00006', '317-551-9812', 'fierfier@outlook.com', 'Phone');

INSERT INTO TreatmentPlan   VALUES('jodoe00001', '1', 'S13.4XXA', '00001', '00001');
INSERT INTO TreatmentPlan   VALUES('jadoe00002', '1', 'S23.3XXA', '00002', '00002');
INSERT INTO TreatmentPlan   VALUES('mamil00003', '1', 'S33.5XXA', '00003', '00003');
INSERT INTO TreatmentPlan   VALUES('bishe00004', '1', 'S29.012A', '00004', '00004');
INSERT INTO TreatmentPlan   VALUES('momil00005', '2', 'S13.4XXA', '00005', '00005');
INSERT INTO TreatmentPlan   VALUES('scfie00006', '2', 'S39.012A', '00006', '00006');

INSERT INTO ICD_10_Codes    VALUES('S13.4XXA', 'Sprain Cervical Spine');
INSERT INTO ICD_10_Codes    VALUES('S16.1XXA', 'Strain Neck Muscle');
INSERT INTO ICD_10_Codes    VALUES('S23.3XXA', 'Sprain Thoracic Spine');
INSERT INTO ICD_10_Codes    VALUES('S29.012A', 'Strain Thoracic Muscle');
INSERT INTO ICD_10_Codes    VALUES('S33.5XXA', 'Sprain Lumbar Spine');
INSERT INTO ICD_10_Codes    VALUES('S39.012A', 'Strain Lumbar Muscle');

INSERT INTO Appointment VALUES('00001', '9:15', 'AM', 'Mon', '1', 'May', '2018');
INSERT INTO Appointment VALUES('00002', '2:00', 'PM', 'Mon', '1', 'May', '2018');
INSERT INTO Appointment VALUES('00003', '5:00', 'PM', 'Mon', '1', 'May', '2018');
INSERT INTO Appointment VALUES('00004', '10:00', 'AM', 'Tue', '2', 'May', '2018');
INSERT INTO Appointment VALUES('00005', '11:00', 'AM', 'Tue', '2', 'May', '2018');
INSERT INTO Appointment VALUES('00006', '3:45', 'PM', 'Tue', '2', 'May', '2018');


INSERT INTO Chiropractor    VALUES('Branden', 'Coleman');
INSERT INTO Chiropractor    VALUES('Jacob', 'Roberts');
INSERT INTO Chiropractor    VALUES('Bryan', 'Walters');

INSERT INTO ReqTherapies    VALUES('00001', '0', '1', '1', '1', '0', '1')
INSERT INTO ReqTherapies    VALUES('00002', '1', '1', '1', '0', '1', '1')
INSERT INTO ReqTherapies    VALUES('00003', '1', '1', '1', '1', '0', '1')
INSERT INTO ReqTherapies    VALUES('00004', '1', '1', '1', '0', '1', '1')
INSERT INTO ReqTherapies    VALUES('00005', '1', '1', '1', '0', '0', '0')
INSERT INTO ReqTherapies    VALUES('00006', '0', '1', '1', '0', '0', '0')