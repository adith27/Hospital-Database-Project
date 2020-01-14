            -- CREATING DATABASE --

DROP DATABASE IF EXISTS Group6;
CREATE DATABASE Group6;
USE Group6;

            -- ENTITIES --

DROP TABLE IF EXISTS Employee;
-- Table for storing information about employees
CREATE TABLE Employee (
    employeeID INT NOT NULL,
    employeeName VARCHAR(32),
    salary INT NOT NULL,
    PRIMARY KEY (employeeID)
);

DROP TABLE IF EXISTS Doctor;
-- Table for storing specialties of doctors
CREATE TABLE Doctor (
    employeeID INT NOT NULL,
    specialty VARCHAR(25),
    FOREIGN KEY (employeeID) REFERENCES Employee (employeeID) ON DELETE CASCADE
);

DROP TABLE IF EXISTS Nurse;
-- Table for storing licenses of nurses
CREATE TABLE Nurse (
    employeeID INT NOT NULL,
    license VARCHAR(25),
    FOREIGN KEY (employeeID) REFERENCES Employee (employeeID) ON DELETE CASCADE
);

DROP TABLE IF EXISTS Appointment;
-- Table for storing information about the appointment
CREATE TABLE Appointment (
    appointmentID INT NOT NULL,
    location VARCHAR(30),
    ddate DATE,
    ttime TIME,
    attended BOOL,
    satisfactionLevel INT,
    PRIMARY KEY (appointmentID)
);

DROP TABLE IF EXISTS Patient;
-- Table for storing information about the patient
CREATE TABLE Patient (
    patientID INT NOT NULL,
    patientName VARCHAR(100),
    age INT NOT NULL,
    weight INT NOT NULL,
    inHomeCare BOOL,
    primaryPhysician INT NOT NULL,
    PRIMARY KEY (patientID)
);

DROP TABLE IF EXISTS Vehicle;
-- Table for storing information about hospital's transportation
CREATE TABLE Vehicle (
    VIN CHAR(17),
    vehicleType VARCHAR(20),
    PRIMARY KEY (VIN)
);

DROP TABLE IF EXISTS Medicine;
-- Table for storing prescription information
CREATE TABLE Medicine (
    medID INT NOT NULL,
    medCost INT NOT NULL,
    quantity INT NOT NULL,
    dosage VARCHAR(12),
    PRIMARY KEY (medID)
);

DROP TABLE IF EXISTS Ailment;
-- Table for storing information related to a certain ailment
CREATE TABLE Ailment (
    ailmentName VARCHAR(30),
    ailDescription VARCHAR(100),
    PRIMARY KEY (ailmentName)
);

DROP TABLE IF EXISTS Department;
-- Table for storing information about departments
CREATE TABLE Department (
    deptID INT NOT NULL,
    deptName VARCHAR(30),
    PRIMARY KEY (deptID)
);

DROP TABLE IF EXISTS Treatment;
-- Table for storing treatment costs (weak entity)
CREATE TABLE Treatment (
    treatmentCost INT NOT NULL
);

            -- RELATIONS --

DROP TABLE IF EXISTS doctorIsA;
-- Connects Doctor to Employee
CREATE TABLE doctorIsA (
    employeeID INT NOT NULL,
    employeeName VARCHAR(32),
    salary INT NOT NULL,
    specialty VARCHAR(25),
    PRIMARY KEY (employeeID),
    FOREIGN KEY (employeeID) REFERENCES Employee (employeeID) ON DELETE CASCADE
);

DROP TABLE IF EXISTS nurseIsA;
-- Connects Nurse to Employee
CREATE TABLE nurseIsA (
    employeeID INT NOT NULL,
    employeeName VARCHAR(32),
    salary INT NOT NULL,
    license VARCHAR(25),
    PRIMARY KEY (employeeID),
    FOREIGN KEY (employeeID) REFERENCES Employee (employeeID) ON DELETE CASCADE
);

DROP TABLE IF EXISTS assigned;
-- Table for storing data related to connection of appointment and patient
CREATE TABLE assigned (
    patientID INT NOT NULL,
    appointmentID INT NOT NULL,
    location VARCHAR(30),
    ddate DATE,
    ttime TIME,
    PRIMARY KEY (patientID, appointmentID),
    FOREIGN KEY (patientID) REFERENCES Patient (patientID) ON DELETE CASCADE,
    FOREIGN KEY (appointmentID) REFERENCES Appointment (appointmentID) ON DELETE CASCADE
);

DROP TABLE IF EXISTS patientHasA;
-- Table for keeping data related to connection of patient and ailment
CREATE TABLE patientHasA (
    patientID INT NOT NULL,
    ailmentName VARCHAR(30),
    PRIMARY KEY(patientID, ailmentName),
    FOREIGN KEY (patientID) REFERENCES Patient (patientID) ON DELETE CASCADE,
    FOREIGN KEY (ailmentName) REFERENCES Ailment (ailmentName) ON DELETE CASCADE  
);

DROP TABLE IF EXISTS attends;
-- Table for connecting employees to appointments
CREATE TABLE attends (
    employeeID INT NOT NULL,
    appointmentID INT NOT NULL,
    location VARCHAR(30),
    ttime TIME,
    ddate DATE,
    PRIMARY KEY (employeeID, appointmentID),
    FOREIGN KEY (employeeID) REFERENCES Employee (employeeID) ON DELETE CASCADE,
    FOREIGN KEY (appointmentID) REFERENCES Appointment (appointmentID) ON DELETE CASCADE
);

DROP TABLE IF EXISTS belongsTo;
-- Table for connecting employees to departments
CREATE TABLE belongsTo (
    employeeID INT NOT NULL,
    deptID INT NOT NULL,
    PRIMARY KEY (employeeID, deptID),
    FOREIGN KEY (employeeID) REFERENCES Employee (employeeID) ON DELETE CASCADE,
    FOREIGN KEY (deptID) REFERENCES Department (deptID) ON DELETE CASCADE
);

DROP TABLE IF EXISTS withinA;
-- Table for connecting departments to ailments
CREATE TABLE withinA (
    deptID INT NOT NULL,
    ailmentName VARCHAR(30),
    PRIMARY KEY (deptID, ailmentName),
    FOREIGN KEY (deptID) REFERENCES Department (deptID) ON DELETE CASCADE,
    FOREIGN KEY (ailmentName) REFERENCES Ailment (ailmentName) ON DELETE CASCADE
);

DROP TABLE IF EXISTS billed;
-- Table for connecting patients with medicines
CREATE TABLE billed (
    patientID INT NOT NULL,
    medID INT NOT NULL,
    PRIMARY KEY (patientID, medID),
    FOREIGN KEY (patientID) REFERENCES Patient (patientID) ON DELETE CASCADE,
    FOREIGN KEY (medID) REFERENCES Medicine (medID) ON DELETE CASCADE
);

DROP TABLE IF EXISTS owns;
-- Table for connecting departments wtih vehicles
CREATE TABLE owns (
    deptID INT NOT NULL,
    VIN CHAR(17),
    PRIMARY KEY (deptID, VIN),
    FOREIGN KEY (deptID) REFERENCES Department (deptID) ON DELETE CASCADE,
    FOREIGN KEY (VIN) REFERENCES Vehicle (VIN) ON DELETE CASCADE
);

DROP TABLE IF EXISTS ailmentRequires;
-- Table for connecting ailments with their respective medicines
CREATE TABLE ailmentRequires (
    ailmentName VARCHAR(30),
    medID INT NOT NULL,
    PRIMARY KEY (ailmentName, medID),
    FOREIGN KEY (ailmentName) REFERENCES Ailment (ailmentName) ON DELETE CASCADE,
    FOREIGN KEY (medID) REFERENCES Medicine (medID) ON DELETE CASCADE
);

DROP TABLE IF EXISTS vehicleRequires;
-- Table for connecting vehicles with appointments if needed
CREATE TABLE vehicleRequires (
    VIN CHAR(17),
    appointmentID INT NOT NULL,
    location VARCHAR(30),
    ddate DATE,
    ttime TIME,
    PRIMARY KEY (VIN, appointmentID),
    FOREIGN KEY (VIN) REFERENCES Vehicle (VIN) ON DELETE CASCADE,
    FOREIGN KEY (appointmentID) REFERENCES Appointment (appointmentID) ON DELETE CASCADE
);


            -- INSERT DATA FUNCTIONS --

INSERT INTO Employee (employeeID, employeeName, salary)
VALUES (122045, 'Jane Doe', 100000),
       (351813, 'Ismaeel Byers', 70000),
       (453542, 'Khadeejah Sutton', 120000),
       (357258, 'Robbie Solomon', 50000),
       (274839, 'Kim Smith', 58000);
       
INSERT INTO Nurse (employeeID, license)
VALUES (351813, 'LPN'),
       (357258, 'RN'),
       (274839, 'EVOC');

INSERT INTO Doctor (employeeID, specialty)
VALUES (122045, 'dermatology'),
       (453542, 'endocrinology');

INSERT INTO Appointment (appointmentID, location, ddate, ttime, attended, satisfactionLevel)
VALUES (975835, 'W110', '2019-04-01', '13:30:00', TRUE, 9),
       (938234, 'E430', '2019-03-28', '14:00:00', TRUE, 8),
       (234234, 'N120', '2019-04-06', '07:30:00', FALSE, 3),
       (223749, 'N330', '2019-03-30', '05:00:00', TRUE, 10),
       (129072, '310 E Market St', '2019-04-10', '12:00:00', TRUE, 9);
       
INSERT INTO Department (deptID, deptName)
VALUES (313, 'dermatology'),
       (412, 'anesthesiology'),
       (150, 'endocrinology'),
       (334, 'pharmacy');
       
INSERT INTO Ailment (ailmentName, ailDescription)
VALUES ('common cold', 'The common cold is a viral infection of your nose and throat (upper respiratory tract).'),
       ('diabetes type 1', 'In type 1 diabetes, the body does not produce insulin. The body breaks down carbohydrates.'),
       ('influenza', 'Influenza is a viral infection that attacks your respiratory system — your nose, throat and lungs.'),
       ('psoriasis', 'Psoriasis is a common skin condition that speeds up the life cycle of skin cells.');

INSERT INTO Medicine (medID, medCost, quantity, dosage)
VALUES (1200, 12, 30, '100mg'),
       (1350, 15, 20, '300mg'),
       (4500, 60, 7, '500mg'),
       (3620, 300, 5, '100ml');

INSERT INTO Vehicle (VIN, vehicleType)
VALUES ('JH4KA8160PC000949', 'van'),
       ('1FVNY5Y90HP312888', 'van'),
       ('3B7KF23Z91G223647', 'car');

INSERT INTO Treatment (treatmentCost)
VALUES (500),
       (1200),
       (300),
       (800);

INSERT INTO Patient (patientID, patientName, age, weight, inHomeCare, primaryPhysician)
VALUES (43320455, 'Lynn Hunter', 30, 150, FALSE, 122045),
       (12342358, 'Tate Frederick', 26, 211, FALSE, 453542),
       (60005100, 'Hajrah Griffith', 54, 182, FALSE, 453542),
       (65721028, 'Francisco Sanders', 83, 123, TRUE, 122045);

INSERT INTO attends (employeeID, appointmentID, location, ddate, ttime)
VALUES (122045, 975835, 'W110', '2019-04-01', '13:30:00'),
       (453542, 234234, 'N120', '2019-04-06', '07:30:00'),
       (351813, 938234, 'E430', '2019-03-28', '14:00:00'),
       (357258, 223749, 'N330', '2019-03-30', '05:00:00');

INSERT INTO doctorIsA (employeeID, employeeName, salary, specialty)
VALUES (122045, 'Jane Doe', 100000, 'dermatology'),
       (453542, 'Khadeejah Sutton', 120000, 'endocrinology');
       
INSERT INTO nurseIsA (employeeID, employeeName, salary, license)
VALUES (351813, 'Ismaeel Byers', 70000, 'LPN'),
       (357258, 'Robbie Soloman', 50000, 'RN'),
       (274839, 'Kim Smith', 51000, 'EVOC');

INSERT INTO belongsTo (employeeID, deptID)
VALUES (122045, 313),
       (351813, 412),
       (453542, 150),
       (357258, 150),
       (274839, 150);

INSERT INTO owns (deptID, VIN)
VALUES (313, 'JH4KA8160PC000949'),
       (150, '1FVNY5Y90HP312888'),
       (412, '3B7KF23Z91G223647');
       
INSERT INTO withinA (deptID, ailmentName)
VALUES (313, 'psoriasis'),
       (150, 'diabetes type 1');
       
INSERT INTO billed (patientID, medID)
VALUES (43320455, 1350),
       (12342358, 1200),
       (60005100, 4500),
       (65721028, 3620);

INSERT INTO ailmentRequires (ailmentName, medID)
VALUES ('diabetes type 1', 3620),
       ('common cold', 1200),
       ('psoriasis', 4500),
       ('influenza', 1350);

INSERT INTO vehicleRequires (VIN, appointmentID, location, ddate, ttime)
VALUES ('JH4KA8160PC000949', 129072, '310 E Market St', '2019-04-10', '12:00:00');

INSERT INTO patientHasA (patientID, ailmentName)
VALUES (43320455, 'influenza'),
       (12342358, 'common cold'),
       (60005100, 'diabetes type 1'),
       (65721028, 'psoriasis');

INSERT INTO assigned (patientID, appointmentID, location, ddate, ttime)
VALUES (65721028, 975835, 'W110', '2019-04-04', '13:30:00'),
       (12342358, 938234, 'E430', '2019-03-28', '14:00:00'),
       (43320455, 234234, 'N120', '2019-04-06', '07:30:00'),
       (60005100, 223749, 'N330', '2019-03-30', '05:00:00'),
       (65721028, 129072, '310 E Market St', '2019-04-10', '12:00:00');



