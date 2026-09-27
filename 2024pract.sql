create database practicetest

create table Tutor(
TutorID varchar (30)
constraint PK_Tutor_TutorID primary key (TutorID),
TutorName varchar(50)
);
create table School(
SchoolID varchar(30)
constraint PK_School_SchoolID primary key (SchoolID),
SchoolName varchar(50),
SchoolAddress varchar(50)
);
create table Session(
TutorID varchar(30)
constraint FK_Tutor_TutorID foreign key (TutorID)references Tutor(TutorID),
SchoolID varchar(30)
constraint FK_School_SchoolID foreign key (SchoolID)references School(SchoolID),
Seats_Available int
constraint PK_Tutor_School_TutorID_SchoolID primary key (TutorID, SchoolID)
);

insert into Tutor(TutorID,TutorName)values 
('A001' ,'Mia Phillips'), 
('A002', 'Bam Mbombo' ),
('A003', 'Wendy Grootboom'), 
('A004', 'Henk Cloete' ),
('A005' ,'Sihle Nukani');
insert into School(SchoolID,SchoolName,SchoolAddress)values
('C001', 'Joburg High', '167 Pert Road, Johannesburg' ),
('C002', 'Gqeberha Secondary', '5 Second Avenue,Gqeberha'),
('C003', 'Mkhize Secondary', '33 Bertha Mkhize Street, Durban'), 
('C004', 'Durban High', '27 Bram Fischer Road, Durban' ),
('C005' ,'Tshwane High' ,'210 Du Toit Street, Tshwane');
insert into Session(TutorID,SchoolID,Seats_Available)values
('A002' ,'C001', 50 ),
('A002', 'C004', 30 ),
('A003' ,'C005', 15 ),
('A004', 'C003', 20 ),
('A004', 'C001', 40);

SELECT*FROM Tutor;
SELECT*FROM School;
SELECT*FROM Session;

alter table Session
add SeatsBooked int;

Update Session 
set SeatsBooked=35 where TutorID='A004' and SchoolID='C001';

SELECT t.TutorName FROM Tutor t
LEFT JOIN Session s ON t.TutorID=s.TutorID
WHERE s.TutorID IS NULL

SELECT t.TutorName, SUM (s.Seats_Available) AS TOTAL   FROM Tutor t
LEFT JOIN Session s ON t.TutorID =s.TutorID
GROUP BY t.TutorName
ORDER BY t.TutorName, SUM (s.Seats_Available) ASC

SELECT TOP (1)
    t.TutorName AS TUTOR_NAME,
    sc.SchoolName AS SCHOOL_NAME,
    s.Seats_Available AS SEATS_AVAILABLE
FROM Session AS s
JOIN Tutor AS t
    ON t.TutorID = s.TutorID
JOIN School AS sc
    ON sc.SchoolID = s.SchoolID
WHERE s.TutorID = 'A004'
ORDER BY s.Seats_Available DESC;