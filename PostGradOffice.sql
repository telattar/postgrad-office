CREATE DATABASE PostGradOffice;
go

use PostGradOffice;
CREATE TABLE PostGradUser(
id int primary key identity(1,1),
email varchar(50) not null unique,
password varchar(30) not null
)


CREATE TABLE Admin(
id int primary key foreign key references PostGradUser on delete cascade on update cascade
)
CREATE TABLE GucianStudent(
id int primary key foreign key references PostGradUser on delete cascade on update cascade,
firstName varchar(20),
lastName varchar(20),
type varchar(3),
faculty varchar(30),
address varchar(50),
GPA decimal(3,2),
undergradID int
)
CREATE TABLE NonGucianStudent(
id int primary key foreign key references PostGradUser on delete cascade on update cascade,
firstName varchar(20),
lastName varchar(20),
type varchar(3),
faculty varchar(30),
address varchar(50),
GPA decimal(3,2),
)

/*	I ONLY CHANGED THE PRIMARY KEY HERE -TARTEEL */
CREATE TABLE GUCStudentPhoneNumber(
id int foreign key references GucianStudent on delete cascade on update cascade,
phone int
primary key(id,phone)
)
CREATE TABLE NonGUCStudentPhoneNumber(
id int foreign key references NonGucianStudent on delete cascade on update cascade,
phone int
primary key(id,phone)
)

-------------------------------------------------------------
CREATE TABLE Course(
id int primary key identity(1,1),
fees int,
creditHours int,
code varchar(10)
)
CREATE TABLE Supervisor(
id int primary key foreign key references PostGradUser,
name varchar(20),
faculty varchar(30)
);
CREATE TABLE Examiner(
id int primary key foreign key references PostGradUser on delete cascade on update cascade,
name varchar(20),
fieldOfWork varchar(100),
isNational BIT
)
CREATE TABLE Payment(
id int primary key identity(1,1),
amount decimal(7,2),
noOfInstallments int,
fundPercentage decimal(4,2)
)
CREATE TABLE Thesis(
serialNumber int primary key identity(1,1),
field varchar(20),
type varchar(3) not null,
title varchar(100) not null,
startDate date not null,
endDate date not null,
defenseDate date,
years as (year(endDate)- year(startDate)),
grade decimal(4,2),
payment_id int foreign key references payment on delete cascade on update cascade,
noOfExtensions int
)
CREATE TABLE Publication(
id int primary key identity(1,1),
title varchar(100) not null,
dateOfPublication date,
place varchar(100),
accepted BIT,
host varchar(100)
);
Create table Defense (serialNumber int,
date datetime,
location varchar(15),
grade decimal(4,2),
primary key (serialNumber, date),
foreign key (serialNumber) references Thesis on delete cascade on update cascade)
Create table GUCianProgressReport (
sid int foreign key references GUCianStudent on delete cascade on update cascade
, no int
, date datetime
, eval int
, state int
, description varchar(200)
, thesisSerialNumber int foreign key references Thesis on delete cascade on update cascade
, supid int foreign key references Supervisor
, primary key (sid, no) )
Create table NonGUCianProgressReport (sid int foreign key references NonGUCianStudent on delete cascade on update cascade,
no int
, date datetime
, eval int
, state int
, description varchar(200)
, thesisSerialNumber int foreign key references Thesis on delete cascade on update cascade
, supid int foreign key references Supervisor
, primary key (sid, no) )
Create table Installment (date datetime,
paymentId int foreign key references Payment on delete cascade on update cascade
, amount decimal(8,2)
, done bit
, primary key (date, paymentId))
Create table NonGucianStudentPayForCourse(sid int foreign key references NonGucianStudent on delete cascade on update cascade,
paymentNo int foreign key references Payment on delete cascade on update cascade,
cid int foreign key references Course on delete cascade on update cascade,
primary key (sid, paymentNo, cid))
Create table NonGucianStudentTakeCourse (sid int foreign key references NonGUCianStudent on delete cascade on update cascade
, cid int foreign key references Course on delete cascade on update cascade
, grade decimal (4,2)
, primary key (sid, cid) )
Create table GUCianStudentRegisterThesis (sid int foreign key references GUCianStudent on delete cascade on update cascade,
supid int foreign key references Supervisor
, serial_no int foreign key references Thesis on delete cascade on update cascade
, primary key(sid, supid, serial_no))
Create table NonGUCianStudentRegisterThesis (sid int foreign key references NonGUCianStudent on delete cascade on update cascade,
supid int foreign key references Supervisor,
serial_no int foreign key references Thesis on delete cascade on update cascade,
primary key (sid, supid, serial_no))
Create table ExaminerEvaluateDefense(date datetime,
serialNo int,
examinerId int foreign key references Examiner on delete cascade on update cascade,
comment varchar(300),
primary key(date, serialNo, examinerId),
foreign key (serialNo, date) references Defense (serialNumber, date) on delete cascade on update cascade)
Create table ThesisHasPublication(serialNo int foreign key references Thesis on delete cascade on update cascade,
pubid int foreign key references Publication on delete cascade on update cascade,
primary key(serialNo,pubid))
go
create proc studentRegister
@first_name varchar(20),
@last_name varchar(20),
@password varchar(20),
@faculty varchar(20),
@Gucian bit,
@email varchar(50),
@address varchar(50)
as
begin
insert into PostGradUser(email,password)
values(@email,@password)
declare @id int
SELECT @id=SCOPE_IDENTITY()
if(@Gucian=1)
insert into GucianStudent(id,firstName,lastName,faculty,address) values(@id,@first_name,@last_name,@faculty,@address)
else
insert into NonGucianStudent(id,firstName,lastName,faculty,address) values(@id,@first_name,@last_name,@faculty,@address)
end
go
create proc supervisorRegister
@first_name varchar(20),
@last_name varchar(20),
@password varchar(20),
@faculty varchar(20),
@email varchar(50)
as
begin
insert into PostGradUser(email,password)
values(@email,@password)
declare @id int
SELECT @id=SCOPE_IDENTITY()
declare @name varchar(50)
set @name = CONCAT(@first_name,@last_name)
insert into Supervisor(id,name,faculty) values(@id,@name,@faculty)
end

go
Create proc userLogin
@email varchar(30),
@password varchar(20),
@success bit output,
@id int output
as
begin
if exists(
select email,password
from PostGradUser
where email=@email and password=@password)
begin
set @success =1
select @id = id from PostGradUser where email=@email
end
else
set @success=0
end

----------------------- JUST TO MAKE SURE THE EMAIL IS UNIQUE ------------------------------
go
create proc emailExists
@email varchar(30),
@success bit output
as
if (exists(select * from PostGradUser where email= @email))
set @success = '1'
else
set @success ='0'
--------------------------------------------------------------------------------------




/* CHANGED THE PROC TO HANDLE THE EXCEPTIONS */
go
create proc addMobile
@ID varchar(20),
@mobile_number varchar(20),
@success bit output
as
begin
if @ID is not null and @mobile_number is not null
begin
--check Gucian student or not
if(exists(select * from GucianStudent where id=@ID))
begin
--if the number already exists!
if (exists(select * from GUCStudentPhoneNumber where id = @ID and phone = @mobile_number))
begin
set @success = '0'
return
end
else
begin
insert into GUCStudentPhoneNumber values(@ID,@mobile_number)
set @success='1'
end
end

--if the guy was a nongucian
else if(exists(select * from NonGucianStudent where id=@ID))
if (exists(select * from NonGUCStudentPhoneNumber where id = @ID and phone = @mobile_number))
begin
set @success = '0'
return
end
else
insert into NonGUCStudentPhoneNumber values(@ID,@mobile_number)
set @success ='1'
end
end


---------------------------------------------------------------------------------------

go
CREATE Proc AdminListSup
As
Select u.id,u.email,u.password,s.name, s.faculty
from PostGradUser u inner join Supervisor s on u.id = s.id
go
CREATE Proc AdminViewSupervisorProfile
@supId int
As
Select u.id,u.email,u.password,s.name, s.faculty
from PostGradUser u inner join Supervisor s on u.id = s.id
WHERE @supId = s.id
go

go
CREATE Proc AdminViewAllTheses
As
Select serialNumber,field,type,title,startDate,endDate,defenseDate,years,grade,payment_id,noOfExtensions
From Thesis
go
--drop proc AdminViewOnGoingTheses
go
CREATE Proc AdminViewOnGoingTheses
@thesesCount int output
As
Select @thesesCount=Count(*)
From Thesis
where endDate >= Convert(Date,CURRENT_TIMESTAMP) and startDate<= Convert(Date,CURRENT_TIMESTAMP)
go
CREATE Proc AdminViewStudentThesisBySupervisor
As
Select s.name,t.title,gs.firstName
From Thesis t inner join GUCianStudentRegisterThesis sr on t.serialNumber=sr.serial_no
inner join Supervisor s on s.id=sr.supid inner join GucianStudent gs on sr.sid=gs.id
where t.endDate > Convert(Date,CURRENT_TIMESTAMP)
union
Select s.name,t.title,gs.firstName
From Thesis t inner join NonGUCianStudentRegisterThesis sr on t.serialNumber=sr.serial_no
inner join Supervisor s on s.id=sr.supid inner join NonGucianStudent gs on sr.sid=gs.id
where t.endDate > Convert(Date,CURRENT_TIMESTAMP)
go
go
CREATE Proc AdminListNonGucianCourse
@courseID int
As
if(exists(select * from Course where id=@courseID))
Select ng.firstName,ng.lastName,c.code,n.grade
From NonGucianStudentTakeCourse n inner join Course c on n.cid=c.id inner join NonGucianStudent ng on ng.id=n.sid
where n.cid=@courseID
go
--drop proc AdminUpdateExtension
--declare @o bit
--exec AdminUpdateExtension '1', @o output
--print @o
--select* from Thesis
--drop proc AdminUpdateExtension
go
CREATE Proc AdminUpdateExtension
@ThesisSerialNo int,
@sucess bit output
As
if(exists(select * from Thesis where serialNumber=@ThesisSerialNo))
begin
set @sucess = '1'
declare @noOfExtensions int
select @noOfExtensions=noOfExtensions from Thesis where serialNumber=@ThesisSerialNo
if ( @noOfExtensions != NULL )
BEGIN
update Thesis
set noOfExtensions=@noOfExtensions+1
where serialNumber=@ThesisSerialNo
end
else
update Thesis
set noOfExtensions=1
where serialNumber=@ThesisSerialNo
end
else
set @sucess = '0'
go
--drop proc AdminIssueThesisPayment
--go
--declare @so bit
--exec AdminIssueThesisPayment '8','340000','3','3',@so output
go
CREATE Proc AdminIssueThesisPayment
@ThesisSerialNo int,
@amount decimal,
@noOfInstallments int,
@fundPercentage decimal,
@sucess bit output
As
if(exists(select * from Thesis where serialNumber=@ThesisSerialNo))
begin
set @sucess = '1'
insert into Payment(amount,noOfInstallments,fundPercentage) values(@amount,@noOfInstallments,@fundPercentage)
declare @id int
SELECT @id=SCOPE_IDENTITY()
update Thesis
set payment_id=@id
where serialNumber=@ThesisSerialNo
end
else 
set @sucess = '0'
go
CREATE Proc AdminViewStudentProfile
@sid int
As
if(exists(select * from GucianStudent where id=@sid))
Select u.id,u.email,u.password,s.firstName,s.lastName,s.type,s.faculty,s.address,s.address,s.GPA
from PostGradUser u inner join GucianStudent s on u.id=s.id
WHERE @sid = s.id
else if(exists(select * from NonGucianStudent where id=@sid))
Select u.id,u.email,u.password,s.firstName,s.lastName,s.type,s.faculty,s.address,s.address,s.GPA
from PostGradUser u inner join NonGucianStudent s on u.id=s.id
WHERE @sid = s.id
go


go
CREATE Proc AdminIssueInstallPayment

@paymentID int,
@InstallStartDate date,
@sucess int output
As
if(exists(select * from Payment where id=@paymentID) )
begin
if(not exists (select * from Installment where paymentId=@paymentID))
begin
set @sucess = '0'
declare @numOfInst int
select @numOfInst=noOfInstallments
from Payment
where id=@paymentID
declare @payAmount int
select @payAmount=amount
from Payment
where id=@paymentID
DECLARE @Counter INT
SET @Counter=1
declare @instdate date
set @instdate=@InstallStartDate
WHILE (@counter<=@numOfInst)
BEGIN

declare @instAmount int
set @instAmount=@payAmount/@numOfInst
if(@counter=1)
insert into Installment(date,paymentId,amount,done)values(@InstallStartDate,@paymentID,@instAmount,0)
else
begin
set @instdate=DATEADD(MM, 6, @instdate);
insert into Installment(date,paymentId,amount,done)values(@instdate,@paymentID,@instAmount,0)
end
SET @counter=@counter+1
END
end
else
set @sucess='2'
end
else
set @sucess='1'
go
CREATE Proc AdminListAcceptPublication
As
select t.serialNumber,p.title
from ThesisHasPublication tp inner join Thesis t on tp.serialNo=t.serialNumber
inner join Publication p on p.id=tp.pubid
where p.accepted=1
go
CREATE Proc AddCourse
@courseCode varchar(10),
@creditHrs int,
@fees decimal
As
insert into Course values(@fees,@creditHrs,@courseCode)
go
CREATE Proc linkCourseStudent
@courseID int,
@studentID int
As
if(exists(select * from Course ) and exists(select * from NonGucianStudent where id=@studentID))
insert into NonGucianStudentTakeCourse(sid,cid,grade)values(@studentID,@courseID,null)
go
CREATE Proc addStudentCourseGrade
@courseID int,
@studentID int,
@grade decimal
As
if(exists(select * from NonGucianStudentTakeCourse where sid=@studentID and cid=@courseID))
update NonGucianStudentTakeCourse
set grade =@grade
where cid=@courseID and sid=@studentID
go
CREATE Proc ViewExamSupDefense
@defenseDate datetime
As
select s.serial_no,ee.date,e.name,sup.name
from ExaminerEvaluateDefense ee inner join examiner e on ee.examinerId=e.id
inner join GUCianStudentRegisterThesis s on ee.serialNo=s.serial_no
inner join Supervisor sup on sup.id=s.supid
go
CREATE Proc EvaluateProgressReport
@supervisorID int,
@thesisSerialNo int,
@progressReportNo int,
@evaluation int,
@exists bit output,
@Success bit output,
@existspr bit output
As
if(exists(select * from Thesis where serialNumber=@thesisSerialNo ) and @evaluation in(0,1,2,3) )
begin
if(exists(select * from GUCianStudentRegisterThesis where serial_no=@thesisSerialNo and supid=@supervisorID))
begin
declare @gucSid int
select @gucSid=sid
from GUCianStudentRegisterThesis
where serial_no=@thesisSerialNo
update GUCianProgressReport
set eval=@evaluation
where sid=@gucSid and thesisSerialNumber=@thesisSerialNo and no=@progressReportNo
set @exists='1'
end
else if(exists(select * from NonGUCianStudentRegisterThesis where serial_no=@thesisSerialNo and supid=@supervisorID))
begin
declare @nonGucSid int
select @nonGucSid=sid
from NonGUCianStudentRegisterThesis
where serial_no=@thesisSerialNo
update NonGUCianProgressReport
set eval=@evaluation
where sid=@nonGucSid and thesisSerialNumber=@thesisSerialNo and no=@progressReportNo
set @exists='1'
end
else
begin
set @exists='0'
end
end
if(exists(select * from Thesis where @thesisSerialNo=serialNumber))
set @Success='1'
else 
set @Success='0'

if(exists(select * from GUCianProgressReport where @thesisSerialNo=thesisSerialNumber and @progressReportNo=no))
set @existspr='1'
else if(exists(select * from NonGUCianProgressReport where @thesisSerialNo=thesisSerialNumber and @progressReportNo=no))
set @existspr='1'
else 
set @existspr='0'
go
CREATE Proc ViewSupStudentsYears
@supervisorID int,
@Success bit output
As
if(exists(select * from Supervisor where id=@supervisorID))
begin
select s.firstName,s.lastName,t.years
from GUCianStudentRegisterThesis sr inner join GucianStudent s on sr.sid=s.id
inner join Thesis t on t.serialNumber=sr.serial_no
union
select s.firstName,s.lastName,t.years
from NonGUCianStudentRegisterThesis sr inner join NonGucianStudent s on sr.sid=s.id
inner join Thesis t on t.serialNumber=sr.serial_no
end
if(exists(select * from GUCianStudentRegisterThesis sr inner join GucianStudent s on sr.sid=s.id))
set @Success='1'
else if(exists(select * from NonGUCianStudentRegisterThesis sr inner join NonGucianStudent s on sr.sid=s.id))
set @Success='1'
else 
set @Success='0'
go
go
create proc thesistypee
@ThesisSerialNO int,
@Success bit output
as
begin
if(exists(select * from GUCianStudentRegisterThesis where serial_no=@ThesisSerialNO))
set @Success='1'

else
set @Success='0'
end
go
CREATE Proc SupViewProfile
@supervisorID int
As
if(exists(select * from Supervisor where id=@supervisorID))
begin
select u.id,u.email,u.password,s.name,s.faculty
from PostGradUser u inner join Supervisor s on u.id=s.id
end
go
---------------------------------------
create proc UpdateSupProfile
@supervisorID int, @name varchar(20), @faculty varchar(20)
as
update Supervisor
set name = @name, faculty = @faculty
where id = @supervisorID
go
create proc ViewAStudentPublications
@StudentID int,
@Exists bit output
as
if (exists(select * from GUCianStudentRegisterThesis Guc inner join Thesis t on t.serialNumber=Guc.serial_no where GUC.sid=@StudentID ))
set @Exists='1'
else if (exists(select * from NonGUCianStudentRegisterThesis nGuc inner join Thesis t on t.serialNumber=nGuc.serial_no where nGuc.sid=@StudentID))
set @Exists='1'
else 
set @Exists='0'
select P.*
from GUCianStudentRegisterThesis GUC
inner join Thesis T
on GUC.serial_no = T.serialNumber
inner join ThesisHasPublication TP
on T.serialNumber = TP.serialNo
inner join Publication P
on P.id = TP.pubid
where GUC.sid = @StudentID
union all
select P.*
from NonGUCianStudentRegisterThesis NON
inner join Thesis T
on NON.serial_no = T.serialNumber
inner join ThesisHasPublication TP
on T.serialNumber = TP.serialNo
inner join Publication P
on P.id = TP.pubid
where NON.sid = @StudentID
go

create proc AddDefenseGucian
@ThesisSerialNo int , @DefenseDate Datetime , @DefenseLocation varchar(15),
@Success bit output,
@exists bit output
as
if(exists(select * from Defense where serialNumber=@ThesisSerialNo))
set @exists='1'
else if(exists(select * from Thesis where serialNumber=@ThesisSerialNo))
begin
set @Success='1'
insert into Defense values(@ThesisSerialNo,@DefenseDate,@DefenseLocation,null)
end
else 
begin
set @Success='0'
set @exists='0'
end
go

create proc AddDefenseNonGucian
@ThesisSerialNo int , @DefenseDate Datetime , @DefenseLocation varchar(15),
@exists bit output,
@Success bit output,
@grade bit output
as
if(exists(select * from Defense where serialNumber=@ThesisSerialNo))
set @exists='1'
else 
begin
set @exists='0'
if(not exists(select * from Thesis where serialNumber=@ThesisSerialNo))
set @Success='0'
else 
begin
set @Success='1'
declare @idOfStudent int
select @idOfStudent = sid
from NonGUCianStudentRegisterThesis
where serial_no = @ThesisSerialNo
if(not exists(select grade
from NonGucianStudentTakeCourse
where sid = @idOfStudent and grade < 50))
begin
set @grade='1'
insert into Defense values(@ThesisSerialNo,@DefenseDate,@DefenseLocation,null)
end
else set @grade='0'
end
end
go

create proc AddExaminer
@ThesisSerialNo int , @DefenseDate Datetime , @ExaminerName varchar(20),@Password varchar(30), @National bit, @fieldOfWork varchar(20)
as
insert into PostGradUser values(@ExaminerName,@Password)
declare @id int
set @id = SCOPE_IDENTITY()
insert into Examiner values(@id,@ExaminerName,@fieldOfWork,@National)
insert into ExaminerEvaluateDefense values(@DefenseDate,@ThesisSerialNo,@id,null)
go
create proc CancelThesis
@ThesisSerialNo int,
@Success bit output,
@Exists bit output
as
if(exists(
select *
from GUCianProgressReport
where thesisSerialNumber = @ThesisSerialNo
))
set @Exists='1'
else if(exists(
select *
from NonGUCianProgressReport
where thesisSerialNumber = @ThesisSerialNo
))
set @Exists='1'
else 
set @Exists='0'
if(exists(
select *
from GUCianProgressReport
where thesisSerialNumber = @ThesisSerialNo
))
begin
declare @gucianEval int
set @gucianEval = (
select top 1 eval
from GUCianProgressReport
where thesisSerialNumber = @ThesisSerialNo
order by no desc
)
if(@gucianEval = 0)
begin
delete from Thesis where serialNumber = @ThesisSerialNo
set @Success='1'
end
else set @Success='0'
end
else
begin
declare @nonGucianEval int
set @nonGucianEval = (
select top 1 eval
from NonGUCianProgressReport
where thesisSerialNumber = @ThesisSerialNo
order by no desc
)
if(@nonGucianEval = 0)
begin
set @Success='1'
delete from Thesis where serialNumber = @ThesisSerialNo
end
else
set @Success='0'
end
go
create proc AddGrade
@ThesisSerialNo int
as
declare @grade decimal(4,2)
select @grade = grade
from Defense
where serialNumber = @ThesisSerialNo
update Thesis
set grade = @grade
where serialNumber = @ThesisSerialNo
go
create proc AddDefenseGrade
@ThesisSerialNo int , @DefenseDate Datetime , @grade decimal(4,2)
as
update Defense
set grade = @grade
where serialNumber = @ThesisSerialNo and date = @DefenseDate
go
create proc AddCommentsGrade
@ThesisSerialNo int , @DefenseDate Datetime , @comments varchar(300)
as
update ExaminerEvaluateDefense
set comment = @comments
where serialNo = @ThesisSerialNo and date = @DefenseDate
go
create proc viewMyProfile
@studentId int
as
if(exists(
select * from GucianStudent where id = @studentId
))
begin
select G.*,P.email
from GucianStudent G
inner join PostGradUser P
on G.id = P.id
where G.id = @studentId
end
else
begin
select N.*,P.email
from NonGucianStudent N
inner join PostGradUser P
on N.id = P.id
where N.id = @studentId
end
go
create proc editMyProfile
@studentID int, @firstName varchar(20), @lastName varchar(20), @password varchar(30), @email varchar(50)
, @address varchar(50), @type varchar(3)
as
update GucianStudent
set firstName = @firstName, lastName = @lastName, address = @address, type = @type
where id = @studentID
update NonGucianStudent
set firstName = @firstName, lastName = @lastName, address = @address, type = @type
where id = @studentID
update PostGradUser
set email = @email, password = @password
where id = @studentID
go
create proc addUndergradID
@studentID int, @undergradID varchar(10)
as
update GucianStudent
set undergradID = @undergradID
where id = @studentID
go
create proc ViewCoursesGrades
@studentID int
as
select grade
from NonGucianStudentTakeCourse
where sid = @studentID
go
create proc ViewCoursePaymentsInstall
@studentID int
as
select P.id as 'Payment Number', P.amount as 'Amount of Payment',P.fundPercentage as 'Percentage of fund for payment', P.noOfInstallments as 'Number of installments',
I.amount as 'Installment Amount',I.date as 'Installment date', I.done as 'Installment done or not'
from NonGucianStudentPayForCourse NPC
inner join Payment P
on NPC.paymentNo = P.id and NPC.sid = @studentID
inner join Installment I
on I.paymentId = P.id
go
create proc ViewThesisPaymentsInstall
@studentID int
as
select P.id as 'Payment Number', P.amount as 'Amount of Payment', P.fundPercentage as 'Fund',P.noOfInstallments as 'Number of installments',
I.amount as 'Installment amount',I.date as 'Installment date', I.done as 'Installment done or not'
from GUCianStudentRegisterThesis G
inner join Thesis T
on G.serial_no = T.serialNumber and G.sid = @studentID
inner join Payment P
on T.payment_id = P.id
inner join Installment I
on I.paymentId = P.id
union
select P.id as 'Payment Number',P.amount as 'Amount of Payment', P.fundPercentage as 'Fund',P.noOfInstallments as 'Number of installments',
I.amount as 'Installment amount',I.date as 'Installment date', I.done as 'Installment done or not'
from NonGUCianStudentRegisterThesis NG
inner join Thesis T
on NG.serial_no = T.serialNumber and NG.sid = @studentID
inner join Payment P
on T.payment_id = P.id
inner join Installment I
on I.paymentId = P.id
go
create proc ViewUpcomingInstallments
@studentID int
as
select I.date as 'Date of Installment' ,I.amount as 'Amount'
from Installment I
inner join NonGucianStudentPayForCourse NPC
on I.paymentId = NPC.paymentNo and NPC.sid = @studentID and I.date > CURRENT_TIMESTAMP
union
select I.date as 'Date of Installment' ,I.amount as 'Amount'
from Thesis T
inner join Payment P
on T.payment_id = P.id
inner join Installment I
on I.paymentId = P.id
inner join GUCianStudentRegisterThesis G
on G.serial_no = T.serialNumber and G.sid = @studentID
where I.date > CURRENT_TIMESTAMP
union
select I.date as 'Date of Installment' ,I.amount as 'Amount'
from Thesis T
inner join Payment P
on T.payment_id = P.id
inner join Installment I
on I.paymentId = P.id
inner join NonGUCianStudentRegisterThesis G
on G.serial_no = T.serialNumber and G.sid = @studentID
where I.date > CURRENT_TIMESTAMP
go
create proc ViewMissedInstallments
@studentID int
as
select I.date as 'Date of Installment' ,I.amount as 'Amount'
from Installment I
inner join NonGucianStudentPayForCourse NPC
on I.paymentId = NPC.paymentNo and NPC.sid = @studentID and I.date < CURRENT_TIMESTAMP and I.done = '0'
union
select I.date as 'Date of Installment' ,I.amount as 'Amount'
from Thesis T
inner join Payment P
on T.payment_id = P.id
inner join Installment I
on I.paymentId = P.id
inner join GUCianStudentRegisterThesis G
on G.serial_no = T.serialNumber and G.sid = @studentID
where I.date < CURRENT_TIMESTAMP and I.done = '0'
union
select I.date as 'Date of Installment' ,I.amount as 'Amount'
from Thesis T
inner join Payment P
on T.payment_id = P.id
inner join Installment I
on I.paymentId = P.id
inner join NonGUCianStudentRegisterThesis G
on G.serial_no = T.serialNumber and G.sid = @studentID
where I.date < CURRENT_TIMESTAMP and I.done = '0'
go


/* ---------------------------- HERE ------------------------------------ */

--the only difference here is that i included a succcess bit as students should be allowed to add PRs for thesis that arent theirs.
--success will be 2 if we tried to add a PR number that already exists
go
create proc AddProgressReport
@thesisSerialNo int, @progressReportDate date, @studentID int,@progressReportNo int,
@success int output
as
--if the thesis has ended
if (exists (select * from Thesis where serialNumber = @thesisSerialNo 
and
endDate< CURRENT_TIMESTAMP))
begin
set @success ='4'
return
end

--if the thesis has not started
if (exists (select * from Thesis where serialNumber = @thesisSerialNo 
and
startDate > CURRENT_TIMESTAMP))
begin
set @success ='5'
return
end

if(
not exists(select * from Thesis where serialNumber = @thesisSerialNo)
)
begin
set @success = '0'
return
end

if (exists(select * from GUCianProgressReport where no = @progressReportNo)
or 
exists(select * from NonGUCianProgressReport where no = @progressReportNo)
)
begin
set @success='2'
return
end

declare @gucian int
if(exists(
select id
from GucianStudent
where id = @studentID
))
begin
set @gucian = '1'
end
else
begin
set @gucian = '0'
end

if(@gucian = '1')
begin
if (exists(select * from GUCianStudentRegisterThesis where serial_no=@thesisSerialNo and sid=@studentID))
begin
set @success ='1'
insert into GUCianProgressReport values(@studentID,@progressReportNo,@progressReportDate,null,null,null,@thesisSerialNo,null)
end
else
set @success='0'
end

else
begin
if (exists(select * from NonGUCianStudentRegisterThesis where serial_no=@thesisSerialNo and sid=@studentID))
begin
set @success ='1'
insert into NonGUCianProgressReport values(@studentID,@progressReportNo,@progressReportDate,null,null,null,@thesisSerialNo,null)
end
else
set @success ='0'
end
go

-----------------------------------------------------------------------------------------------------------


--the only difference here is that i included a succcess bit as students should be allowed to fill PRs for thesis that arent theirs.
go
create proc FillProgressReport
@thesisSerialNo int, @progressReportNo int, @state int, @description varchar(200),@studentID int,
@success int output
as
--if the thesis has ended
if (exists (select * from Thesis where serialNumber = @thesisSerialNo 
and
endDate< CURRENT_TIMESTAMP))
begin
set @success ='4'
return
end

--if the thesis has not started
if (exists (select * from Thesis where serialNumber = @thesisSerialNo 
and
startDate > CURRENT_TIMESTAMP))
begin
set @success ='5'
return
end
--you cant also fill a pr that doesnt exist
--you also cant fill a progress report for a thesis that dosnt exist

if (not exists(select * from GUCianProgressReport where no = @progressReportNo)
and 
not exists(select * from NonGUCianProgressReport where no = @progressReportNo))
begin
set @success='2'
return
end

declare @gucian bit
if(exists(select * from GucianStudent where id = @studentID))
set @gucian = '1'

else
set @gucian = '0'

--if he is a gucian
if(@gucian = '1')
begin
--he has to be inserting in his thesis and filling this thesis pr
if (exists(select * from GUCianStudentRegisterThesis where serial_no=@thesisSerialNo and sid=@studentID)
and
exists(select * from GUCianProgressReport where thesisSerialNumber= @thesisSerialNo and no = @progressReportNo and sid = @studentID))
begin
update GUCianProgressReport
set state = @state, description = @description, date = CURRENT_TIMESTAMP
where thesisSerialNumber = @thesisSerialNo and sid = @studentID and no = @progressReportNo
set @success = '1'
end

else
set @success = '0'
end

--if he is nongucian
else
begin
if (exists(select * from NonGUCianStudentRegisterThesis where serial_no=@thesisSerialNo and sid=@studentID)
and
exists(select * from NonGUCianProgressReport where thesisSerialNumber= @thesisSerialNo and no = @progressReportNo and sid = @studentID))
begin
update NonGUCianProgressReport
set state = @state, description = @description, date = CURRENT_TIMESTAMP
where thesisSerialNumber = @thesisSerialNo and sid = @studentID and no = @progressReportNo
set @success ='1'
end

else
set @success='0'
end

go




--------------------------------------------------------------------------------------------------------------

create proc ViewEvalProgressReport
@thesisSerialNo int, @progressReportNo int,@studentID int
as
select eval
from GUCianProgressReport
where sid = @studentID and thesisSerialNumber = @thesisSerialNo and no = @progressReportNo
union
select eval
from NonGUCianProgressReport
where sid = @studentID and thesisSerialNumber = @thesisSerialNo and no = @progressReportNo
go

----------------------------------------------------------------------------------------------------------
--i added the publication id as an output to display it to the user
create proc addPublication
@title varchar(50), @pubDate datetime, @host varchar(50), @place varchar(50), @accepted bit,
@publid int output
as
insert into Publication values(@title,@pubDate,@place,@accepted,@host)
select @publid = id from Publication where id=(select max(id) from Publication)
go
-----------------------------------------------------------------------------------------------

go
create proc linkPubThesis
@PubID int, @thesisSerialNo int, @studentid int,
@success int output
as

--if the thesis has ended
if (exists (select * from Thesis where serialNumber = @thesisSerialNo 
and
endDate< CURRENT_TIMESTAMP))
begin
set @success ='4'
return
end

--if the thesis has not started
if (exists (select * from Thesis where serialNumber = @thesisSerialNo 
and
startDate > CURRENT_TIMESTAMP))
begin
set @success ='5'
return
end

--if the publication is already link to the thesis
if(exists(select * from ThesisHasPublication where serialNo=@thesisSerialNo and pubid = @PubID))
begin
set @success='3'
return
end



--you also cant link a publication that doesnt exist. or to a thesis that doesnt exist.
if (not exists(select * from Publication where id = @PubID)
or
not exists(select * from Thesis where serialNumber = @thesisSerialNo))
begin
set @success='2'
return
end

declare @gucian bit
if(exists(select * from GucianStudent where id = @studentID))
set @gucian = '1'

else
set @gucian = '0'
--this checks if student is gucian

if @gucian = '1' begin
if (exists( select * from GUCianStudentRegisterThesis where sid = @studentid and serial_no=@thesisSerialNo)) begin
insert into ThesisHasPublication values(@thesisSerialNo,@PubID)
set @success ='1'
end
else set @success ='0'
end
--you cant link a publication to a thesis that isnt yours! :D
else if @gucian = '0' begin
if (exists( select * from NonGUCianStudentRegisterThesis where sid = @studentid and serial_no=@thesisSerialNo)) begin
insert into ThesisHasPublication values(@thesisSerialNo,@PubID)
set @success ='1'
end
else set @success ='0'
end
go


---------------------------------------------------------------------------------------------



create trigger deleteSupervisor
on Supervisor
instead of delete
as
delete from GUCianProgressReport where supid in (select id from deleted)
delete from NonGUCianProgressReport where supid in (select id from deleted)
delete from GUCianStudentRegisterThesis where supid in (select id from deleted)
delete from NonGUCianStudentRegisterThesis where supid in (select id from deleted)
delete from Supervisor where id in (select id from deleted)
delete from PostGradUser where id in (select id from deleted)


go
create proc checkType
@ID int,
@usertype varchar(20) output
as
begin
if (exists (select * from GucianStudent where id = @ID))
set @usertype = 'GucianStudent'
else if (exists (select * from NonGucianStudent where id = @ID))
set @usertype = 'NonGucianStudent'
else if (exists (select * from Supervisor where id = @ID))
set @usertype = 'Supervisor'
else if (exists (select * from Examiner where id = @ID))
set @usertype = 'Examiner'
else if (exists (select * from Admin where id = @ID))
set @usertype = 'Admin'
else
set @usertype = 'error'
end
go

-------------------------------------------------------------------------------------
go
create proc studentThesis
@ID int
as
if (exists (select * from GucianStudent where id = @ID))
begin
select T.* from Thesis T inner join GUCianStudentRegisterThesis GU on T.serialNumber = GU.serial_no
where GU.sid =@ID
end

else if (exists (select * from NonGucianStudent where id = @ID))
begin
select T.* from Thesis T inner join NonGUCianStudentRegisterThesis NGU on T.serialNumber = NGU.serial_no
where NGU.sid =@ID
end


--exec studentThesis '1'

---------------------------------------------------------------------------------------
--show ALLLLLLLL course details for non gucians
go
create proc showAllCourseDetails
@studentid int
as
select C.*, NGTC.grade from Course C inner join NonGucianStudentTakeCourse NGTC on C.id = NGTC.cid
where NGTC.sid = @studentid


-----------------------------------------------------------------------------------------


go
create proc examinerResister
@fullname varchar(20),
@email varchar(30),
@password varchar(20),
@fieldofwork varchar(20),
@isnational bit
as
insert into PostGradUser(email,password) values (@email,@password)
declare @id int
SELECT @id=SCOPE_IDENTITY()
insert into Examiner(id,name,fieldOfWork,isNational) values(@id,@fullname,@fieldofwork,@isnational)
go
------------------------------------my procss examiner------------------------------------
go
--b) Add comments for a defense
create proc AddCommentsGrade66
@ThesisSerialNo int , 
@DefenseDate Datetime , 
@comments varchar(300),
@examinerId int,
@success bit output
as

set @success = 0
if(exists(select * from Defense D inner join ExaminerEvaluateDefense EE 
on D.serialNumber = EE.serialNo and EE.date = D.date
inner join GUCianStudentRegisterThesis GT on GT.serial_no = D.serialNumber
where D.serialNumber = @ThesisSerialNo and D.date = @DefenseDate
and EE.examinerId = @examinerId) or exists(select * from Defense D inner join ExaminerEvaluateDefense EE 
on D.serialNumber = EE.serialNo and EE.date = D.date
inner join NonGUCianStudentRegisterThesis NGT on NGT.serial_no = D.serialNumber
where D.serialNumber = @ThesisSerialNo and D.date = @DefenseDate
and EE.examinerId = @examinerId))
Begin
update ExaminerEvaluateDefense set comment=@comments
where ExaminerEvaluateDefense.serialNo=@ThesisSerialNo and 
ExaminerEvaluateDefense.date=@DefenseDate 
and ExaminerEvaluateDefense.examinerId = @examinerId
set @success = 1

end

go

create proc  AddDefenseGrade66
@ThesisSerialNo int , 
@DefenseDate Datetime , 
@grade decimal,
@examinerId int,
@success bit output
as

set @success = 0
if(exists(
select * from Defense D inner join ExaminerEvaluateDefense EE 
on D.serialNumber = EE.serialNo and EE.date = D.date
inner join GUCianStudentRegisterThesis GT on GT.serial_no = D.serialNumber
where D.serialNumber = @ThesisSerialNo and D.date = @DefenseDate
and EE.examinerId = @examinerId) or exists(select * from Defense D inner join ExaminerEvaluateDefense EE 
on D.serialNumber = EE.serialNo and EE.date = D.date
inner join NonGUCianStudentRegisterThesis NGT on NGT.serial_no = D.serialNumber
where D.serialNumber = @ThesisSerialNo and D.date = @DefenseDate
and EE.examinerId = @examinerId))
Begin

update Defense set Defense.grade=@grade
where Defense.serialNumber=@ThesisSerialNo and Defense.date=@DefenseDate


set @success = 1
end
go





--SEARCHING PROC
go
create proc Search1
@key varchar(10),
@examinerId int
as
select * from Thesis T inner join ExaminerEvaluateDefense EE
on T.serialNumber = EE.serialNo and T.defenseDate = EE.date
where title like '%' + @key + '%' and EE.examinerId = @examinerId
go


--exec SearchByKeyword 'mat'

go
create proc ListDefense123
@examinerId int
as
select T.title AS ThesisTitle, sup.name AS SupervisorName, GS.firstName + ' '+ GS.lastName AS 'StudentName' from
Thesis T inner join ExaminerEvaluateDefense EE on EE.serialNo = T.serialNumber
inner join GUCianStudentRegisterThesis GRT on GRT.serial_no = EE.serialNo
inner join GUCianStudent GS on GS.id = GRT.sid
inner join Supervisor sup on GRT.supid = sup.id
where EE.examinerId = @examinerId and
(year(T.defenseDate)<year(Current_TIMESTAMP) 
or (year(T.defenseDate)=year(Current_TIMESTAMP) 
and month(T.defenseDate)<month(Current_TIMESTAMP)) 
or( 
year(T.defenseDate)=year(Current_TIMESTAMP) 
and month(T.defenseDate)=month(Current_TIMESTAMP)
and day(T.defenseDate)<day(Current_TIMESTAMP)))
UNION
select T.title AS ThesisTitle, sup.name AS SupervisorName, NS.firstName + ' '+ NS.lastName AS 'StudentName' from
Thesis T inner join ExaminerEvaluateDefense EE on EE.serialNo = T.serialNumber
inner join NonGUCianStudentRegisterThesis NGRT on NGRT.serial_no = EE.serialNo
inner join NonGUCianStudent NS on NS.id = NGRT.sid
inner join Supervisor sup on NGRT.supid = sup.id
where EE.examinerId = @examinerId 
and
(year(T.defenseDate)<year(Current_TIMESTAMP) 
or (year(T.defenseDate)=year(Current_TIMESTAMP) 
and month(T.defenseDate)<month(Current_TIMESTAMP)) 
or( 
year(T.defenseDate)=year(Current_TIMESTAMP) 
and month(T.defenseDate)=month(Current_TIMESTAMP)
and day(T.defenseDate)<day(Current_TIMESTAMP)))
--Changed name of this Proc and did a corresponding change in C# file
go

go
create proc EditMyPersonalInfo1
@id int,
@name varchar(20) ,
@fieldOfWork varchar(100),
@mail varchar(20),
@password varchar(20),
@success bit output
as
set @success = 0
if(exists(select * from Examiner where id= @id))
begin
update Examiner set name = @name, fieldOfWork = @fieldOfWork
where id = @id
update PostGradUser set email = @mail, password = @password
where id = @id
set @success = 1
--Changed name of this Proc and did a corresponding change in C# file
end

go
create proc ViewAllMyDetails
@examinerID int --eli 3amal be login fel awal
as
select *  from Examiner E inner join PostGradUser U on E.id = U.id 
where E.id = @examinerID
go
---------------------------------------------------------------------------------------
--END OF MY EXAMINER COMPONENT PROCS 


--exec viewMyProfile '1'

-----------------------------------------------------------------------------------------------------

--dina insertions-----------------------------------------------------------------------------------

							/* SUPERVISORS */
go
INSERT INTO PostGradUser(email,password) VALUES('gamalsaad@yahoo.com','gseee333');
declare @id int
set @id = SCOPE_IDENTITY()
INSERT INTO Supervisor(id,name,faculty) VALUES(@id,'Gamal Saad','Engineering');
go

INSERT INTO PostGradUser(email,password) VALUES('ismailyassin@gmail.com','isyass322');
declare @id int
set @id = SCOPE_IDENTITY()
INSERT INTO Supervisor(id,name,faculty) VALUES(@id,'Ismail Yassin','BI');
go

INSERT INTO PostGradUser(email,password) VALUES('ahmedziad@gmail.com','ahmed11');
declare @id int
set @id = SCOPE_IDENTITY()
INSERT INTO Supervisor(id,name) VALUES(@id,'Ahmed Mahmoud');
go


--insert into Payment (amount,noOfInstallments,fundPercentage) values ('300','3','1');
--insert into Installment (date,paymentId,amount,done) values ('2020-10-22','1','10','0');




---finish dina insertions------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------
select * from Payment
INSERT INTO Payment(amount, noOfInstallments, fundPercentage) VALUES('35000','3','10');
INSERT INTO Installment(date, paymentId, amount, done)
VALUES('2021-12-31', '1','12000','0');
INSERT INTO Installment(date, paymentId, amount, done)
VALUES('2022-2-28', '1','12000','0');
INSERT INTO Installment(date, paymentId, amount, done)
VALUES('2022-4-28', '1','11000','0');


INSERT INTO Payment(amount, noOfInstallments, fundPercentage) VALUES('40000','3','10');
--no install yet

/*Thesis */

INSERT INTO Thesis (field, type, title, startDate, endDate, defenseDate, grade, noOfExtensions)
VALUES('Engineering','Phd','Solar Cities in Egypt', '2010-1-1','2023-1-1','2022-6-1','1','2');

INSERT INTO Thesis (field, type, title, startDate, endDate, defenseDate, grade)
VALUES('Management','Phd','Current Stocks', '2025-2-1','2027-9-1','2026-4-12','3');

INSERT INTO Thesis (field, type, title, startDate, endDate, defenseDate, grade, noOfExtensions)
VALUES('Pharmacy','Phd','Dermatology', '2021-12-1','2024-11-10','2023-3-3','2','0');

INSERT INTO Thesis (field, type, title, startDate, endDate, defenseDate)
VALUES('Management','MA','Economical Science', '2021-3-1','2021-9-1','2021-8-12');



/* SOME ENDED THESIS */


INSERT INTO Thesis (field, type, title, startDate, endDate, defenseDate, grade,
payment_id, noOfExtensions)
VALUES('CSEN','Phd','AI Future', '2019-6-16','2021-11-10','2020-12-30', '98',null,'0');

INSERT INTO Thesis (field, type, title, startDate, endDate, defenseDate, grade,
payment_id, noOfExtensions)
VALUES('CSEN','MST','Web Development', '2015-1-1','2018-9-1','2017-8-12', '85',null,'1');

INSERT INTO Thesis (field, type, title, startDate, endDate, defenseDate, grade,
payment_id, noOfExtensions)
VALUES('Applied Arts','Phd','Creative Coloring', '2010-12-16','2012-11-10','2011-6-30', '80',null,'0');

INSERT INTO Thesis (field, type, title, startDate, endDate, defenseDate, grade,
payment_id, noOfExtensions)
VALUES('Applied Arts','MST','Drawing', '2008-1-1','2010-9-1','2009-8-2', '72',null,'1');




/* THESIS THAT DID NOT START */



INSERT INTO Thesis (field, type, title, startDate, endDate, defenseDate, grade,
payment_id, noOfExtensions)
VALUES('Pharmacy','Phd','Dermatology', '2026-12-1','2028-11-10','2027-3-3', null,null,null);

INSERT INTO Thesis (field, type, title, startDate, endDate, defenseDate, grade,
payment_id, noOfExtensions)
VALUES('Pharmacy','mST','Drug Management', '2030-1-1','2033-9-1','2032-8-8', null,null,null);




/* Admin */
insert into PostGradUser (email, password) values ('admin@gmail.com','admin');
declare @id int
set @id = SCOPE_IDENTITY()
insert into Admin (id) values (@id);
go


			/* SOME STUDENTS */
INSERT INTO PostGradUser(email,password) VALUES('ahmedmahmoud@gmail.com','amah123456');
declare @id int
set @id = SCOPE_IDENTITY()
INSERT INTO GucianStudent(id,firstName,lastName,type,faculty, address, GPA, undergradID)
values(@id,'Ahmed', 'Mahmoud', 'Phd', 'Engineering', '32B Maadi', '1.7', '402018');
select * from GucianStudent
go

INSERT INTO PostGradUser(email,password) VALUES('gameelasembel@yahoo.com','gameela9183');
declare @id int
set @id = SCOPE_IDENTITY()
INSERT INTO NonGucianStudent(id,firstName, lastName, type,faculty,address,GPA)
VALUES(@id,'Gamela','Sembel','Mst','Engineer','Mansy','1.8');
go

INSERT INTO PostGradUser(email,password) VALUES('kamiliasamy@gmail.com','kami123455');
declare @id int
set @id = SCOPE_IDENTITY()
INSERT INTO NonGucianStudent(id,firstName, lastName, type,faculty,address,GPA)
VALUES(@id,'Kamilia','Samy','Phd','CSEN','8A Zahraa','2.4');
go

INSERT INTO PostGradUser(email,password) VALUES('ameermaged@hotmail.com','amigo39273');
declare @id int
set @id = SCOPE_IDENTITY()
INSERT INTO NonGucianStudent(id,firstName, lastName, type,faculty,address,GPA)
VALUES(@id,'Ameer','Maged','Phd','Pharmacy','12 Nozha','1.1');
go

INSERT INTO PostGradUser(email,password) VALUES('amrfouadfathy@gmail.com','aff17654');
declare @id int
set @id = SCOPE_IDENTITY()
INSERT INTO NonGucianStudent(id,firstName, lastName, type,faculty,address,GPA)
VALUES(@id,'Amr','Fathy','Mst','Mechatronics','90 Street','3');
go

INSERT INTO PostGradUser(email,password) VALUES('gmeel@yahoo.com','g1234');
declare @id int
set @id = SCOPE_IDENTITY()
INSERT INTO Supervisor(id,name,faculty) VALUES(@id,'gameel ahmed','Engineering');
go




INSERT INTO Course (fees,creditHours, code)
VALUES('10000','4','BI101');
INSERT INTO Course (fees,creditHours, code)
VALUES('20000','4','BI201');
INSERT INTO Course (fees,creditHours, code)
VALUES('15000','2','BIO1002');
INSERT INTO Course (fees,creditHours, code)
VALUES('17000','1','BIO3002');
INSERT INTO Course (fees,creditHours, code)
VALUES('11000','3','PHARM1221');


insert into GUCianStudentRegisterThesis(serial_no,sid,supid) values('3','5','1')
insert into GUCianStudentRegisterThesis(serial_no,sid,supid) values('1','5','1')
insert into NonGUCianStudentRegisterThesis(serial_no,sid,supid) values('4','7','1')

insert into GUCianStudentRegisterThesis(serial_no,sid,supid) values('7','5','1')
insert into GUCianStudentRegisterThesis(serial_no,sid,supid) values('10','5','1')



insert into NonGucianStudentTakeCourse(sid,cid) values('9','1')


exec studentThesis '5'
/*select * from GUCianProgressReport
select * from NonGUCianProgressReport
select * from Publication
select * from ThesisHasPublication
select * from Thesis
select * from PostGradUser
select * from GucianStudent
select * from NonGucianStudent
select * from Supervisor
select * from Defense
select * from Examiner
select * from GucianStudent
select * from NonGucianStudent
select * from Payment*/
--------------------------------------------------------------------------------------------------------------

-----------------------//MY INSERTIONS FOR EXAMINER COMPONENT//----------------------------------


--All Users

INSERT INTO PostGradUser(email, password) values('will@yahoo.com','1234wwll00')  
INSERT INTO PostGradUser(email, password) values('walaa.wael@gmail.com','aaWl22nnn')
INSERT INTO PostGradUser(email, password) values('amira.hussein@hotmail.com','AMii199999')
INSERT INTO PostGradUser(email, password) values('Andyy@gmail.com','1234567And')
INSERT INTO PostGradUser(email, password) values('sashaBrouse@yahoo.com','PotatoeGirl00')

insert into PostGradUser (email, password)
values('elham.awad@yahoo.com','el123aw')
insert into PostGradUser (email, password)
values('mervat.aboelkheir@hotmail.com','123456mer')
insert into PostGradUser (email, password)
values('seif.hussein@gmail.com','sss123765')

insert into PostGradUser (email, password)
values('maryam.ahmed@hotmail.com','ma1234')
insert into PostGradUser (email, password)
values('awab.seleem@gmail.com','aws456')
insert into PostGradUser (email, password)
values('bassant.tarek@yahoo.com','bobo2001')

insert into PostGradUser (email, password)
values('noor.fahmy@hotmail.com','nn20062006')
insert into PostGradUser (email, password)
values('omar.osama@yahoo.com','123oms456')
insert into PostGradUser (email, password)
values('mohamed.emad@gmail.com','bbme123456')

--insert into PostGradUser (email, password)
--values('mohsen.kamal@gmail.com','momo123')
--insert into PostGradUser (email, password)
--values('karema.ali@yahoo.com','12koky34')
----------------------------------------------------All Users DONE

--Examiners

INSERT INTO Examiner(id,name, fieldOfWork, isNational) values('11','Will','arts','1')
INSERT INTO Examiner(id,name, fieldOfWork, isNational) values('12','Walaa','databases','0')
INSERT INTO Examiner(id,name, fieldOfWork, isNational) values('13','Amira','science','0')
INSERT INTO Examiner(id,name, fieldOfWork, isNational) values('14','Andrew','cs','1')
INSERT INTO Examiner(id,name, fieldOfWork, isNational) values('15','Sasha','physics','1')
--------------------------------------------Examiners DONE


--Supervisors
Insert into Supervisor(id, name, faculty)
values('16','Elham Awad','Medicine')
Insert into Supervisor(id, name, faculty)
values('17','Mervat Abo Elkheir','MET')
Insert into Supervisor(id, name, faculty)
values('18','Seif Hussein','EMS')
--------------------------------------------------------All Supervisors Done

--GUCian Students

insert into GucianStudent(id,firstName, lastName, type, faculty, address, GPA, undergradID)
values('19','maryam','ahmed','GUC','Medicine','Nasr City','1.21','1182')
insert into GucianStudent(id,firstName, lastName, type, faculty, address, GPA, undergradID)
values('20','awab','seleem','GUC','MET','Maadi','2.06','4456')
insert into GucianStudent(id,firstName, lastName, type, faculty, address, GPA, undergradID)
values('21','bassant','tarek','GUC','EMS','Tagamoo','1.01','1687')

--insert into GucianStudent(id,firstName, lastName, type, faculty, address, GPA, undergradID)
--values('25','mohsen','kamal','GUC','IET','Tagamoo','0.70','16879')

--insert into GucianStudent(id,firstName, lastName, type, faculty, address, GPA, undergradID)
--values('26','karema','ali','GUC','IET','Tagamoo','1.00','21687')

-------------------------------------------------Gucian Students DONE

--NONGUCian Students
insert into NonGucianStudent(id,firstName, lastName, type,faculty,address,GPA)
values('22','noor','fahmy','NON','Medicine','Mohandeseen','3.01')
insert into NonGucianStudent(id,firstName, lastName, type,faculty,address,GPA)
values('23','omar','osama','NON','Computer Science','Sheikh Zayed','2.20')
insert into NonGucianStudent(id,firstName, lastName, type,faculty,address,GPA)
values('24','mohamed','emad','NON','Medicine','Rehab','3.04')
-----------------------------------------------------NONGUCian Students

--Thesis Payments
INSERT INTO Payment (amount, noOfInstallments, fundPercentage) --3
values('15000','3','10')
INSERT INTO Payment (amount, noOfInstallments, fundPercentage) --4
values('20000','4','5')
INSERT INTO Payment (amount, noOfInstallments, fundPercentage) --5
values('35000','6','20')
INSERT INTO Payment (amount, noOfInstallments, fundPercentage) --6
values('35000','2','5')
INSERT INTO Payment (amount, noOfInstallments, fundPercentage) --7
values('60000','3','15')
INSERT INTO Payment (amount, noOfInstallments, fundPercentage) --8
values('20000','1','2')
---------------------------------------------------------------Thesis Payments Done


--Thesis Insertions
INSERT INTO Thesis(field, type, title, startDate, endDate, defenseDate, grade,payment_id, noOfExtensions)       ---11 
values('maths','phd', 'Mathematical Premenilaries','2017-12-12','2020-12-12','12-12-2022','60','3','2')

INSERT INTO Thesis(field, type, title, startDate, endDate, defenseDate, grade,payment_id, noOfExtensions)       ---12
values('bio','msc', 'Cells and Systems','2019-11-23','2021-12-31','2022-1-6','97','4','1')

INSERT INTO Thesis(field, type, title, startDate, endDate, defenseDate, grade,payment_id, noOfExtensions)       ---13
values('sociology','phd', 'Social effect on population growth','2016-12-12','2020-10-29','2021-12-28','80','5','4')

INSERT INTO Thesis(field, type, title, startDate, endDate, defenseDate, grade,payment_id, noOfExtensions)        ---14
values('bio','msc', 'Thyroid Gland','2019-11-23','2021-12-31','2022-3-15',null,null,null)

INSERT INTO Thesis(field, type, title, startDate, endDate, defenseDate, grade,payment_id, noOfExtensions)        ----15 
values('manufacturing','phd', 'Motors and Thermal Energy','2017-11-23','2020-12-31','2021-03-17',null,null,null)

INSERT INTO Thesis(field, type, title, startDate, endDate, defenseDate, grade,payment_id, noOfExtensions)        ----16
values('psychology','msc', 'Pandemic psychological effects on uni Students','2016-12-10','2020-8-16','2021-1-28','90','7','3')

INSERT INTO Thesis(field, type, title, startDate, endDate, defenseDate, grade,payment_id, noOfExtensions)          ---17
values('Computer Science','phd', 'Efficient Algorithims and Complexity Calculations','2017-12-29','2020-12-30','2021-2-15','75','6','2')

INSERT INTO Thesis(field, type, title, startDate, endDate, defenseDate, grade,payment_id, noOfExtensions)            ----18
values('Mechatronics','phd', 'Mechanical Power Efficiency','2018-10-12','2020-12-29','2021-4-20','82','8','1')

---------------------------------------------Thesis Donee


--Defenes
Insert into Defense(serialNumber, date, location)values('11','12-12-2022','H14')
Insert into Defense(serialNumber, date, location)values('13','2021-12-28','H12')
Insert into Defense(serialNumber, date, location)values('12','2022-1-6','C7.301')
Insert into Defense(serialNumber, date, location)values('16','2021-1-28','H18')
Insert into Defense(serialNumber, date, location)values('17','2021-2-15','H19')
Insert into Defense(serialNumber, date, location)values('18','2021-4-20','D4.303')
insert into Defense(serialNumber, date, location, grade) values('14','2022-03-15','H11',null)
insert into Defense(serialNumber, date, location, grade) values('15','2021-03-17','H12',null)
-----------------------------------------------Defenses Done


--Examiner Evaluate Defense
Insert into ExaminerEvaluateDefense(date, serialNo, examinerId)
values('12-12-2022','11','14')
Insert into ExaminerEvaluateDefense(date, serialNo, examinerId)
values('2021-12-28','13','14')
Insert into ExaminerEvaluateDefense(date, serialNo, examinerId)
values('2022-1-6','12','14')
Insert into ExaminerEvaluateDefense(date, serialNo, examinerId)
values('2021-1-28','16','12')
Insert into ExaminerEvaluateDefense(date, serialNo, examinerId)
values('2021-2-15','17','12')
Insert into ExaminerEvaluateDefense(date, serialNo, examinerId)
values('2021-4-20','18','12')
insert into ExaminerEvaluateDefense(date, serialNo, examinerId, comment)
values('2022-03-15','14','11',null)
insert into ExaminerEvaluateDefense(date, serialNo, examinerId, comment) 
values('2021-03-17','15','11',null)


----------------------------------------------------------Examiner Evaluate Defense Done

--Gucian & Non Gucian registerations
Insert into NonGUCianStudentRegisterThesis(sid, supid, serial_no) values('22','16','16')
Insert into GUCianStudentRegisterThesis(sid, supid, serial_no) values('20','18','18')
Insert into GUCianStudentRegisterThesis(sid, supid, serial_no) values('21','17','17')

Insert into GUCianStudentRegisterThesis(sid, supid, serial_no) values('19','17','13')
Insert into NonGUCianStudentRegisterThesis(sid, supid, serial_no) values('23','17','12')
Insert into NonGUCianStudentRegisterThesis(sid, supid, serial_no) values('24','16','11')

--Insert into GUCianStudentRegisterThesis(sid, supid, serial_no) values('25','18','14')
--Insert into GUCianStudentRegisterThesis(sid, supid, serial_no) values('26','18','15')


-------------------------------------------Registerations Done
--select * from ExaminerEvaluateDefense
--select * from Thesis
--select * from Defense
--select * from GucianStudent
--select * from NonGucianStudent
--select * from Examiner
--select * from Supervisor
--select * from PostGradUser
--select * from GUCianStudentRegisterThesis
--select * from NonGUCianStudentRegisterThesis

--------------------------------------------------------------------------
--Nora Insertions
select * from PostGradUser

--Gucian Students
insert into PostGradUser values ('Kareem@gmail.com','k1234')
insert into GucianStudent values (25,'Kareem','Mohamed','Mas','Engineering','Cairo',0.7,402019);
insert into PostGradUser values ('Maria@gmail.com','m1234')
insert into GucianStudent values (26,'Maria','George','Mas','Applied Arts','Nasr City',3.4,402020);
insert into PostGradUser values ('Ramadan@gmail.com','r1234')
insert into GucianStudent values (27,'Ramadan','Kareem','Mas','Medicine','Maadi',2.9,402021);

--NonGucian Students
insert into PostGradUser values ('Farah@gmail.com','f1234')
insert into NonGucianStudent values (28,'Farah','Mohamed','Mas','Engineering','Madinaty',2.7);
insert into PostGradUser values ('Jason@gmail.com','j1234')
insert into NonGucianStudent values (29,'Jason','Ahmed','Phd','Pharmacy','Tagmoaa',1.0);
insert into PostGradUser values ('Nora@gmail.com','n1234')
insert into NonGucianStudent values (30,'Nora','Osama','Mas','Engineering','Cairo',0.7);
insert into PostGradUser values ('Theo@gmail.com','t1234')
insert into NonGucianStudent values (31,'Theo','Masry','Phd','Business','Helioplis',2.4);

select * from Course
--Courses
insert into Course values(20000,8,'Math302');
insert into Course values(5000,4,'PHARMA202');
insert into Course values(10000,6,'Graph503');
insert into Course values(8000,5,'ECO703');

--Supervisors
select * from Supervisor
insert into PostGradUser values ('Rania@gmail.com','r1234')
insert into Supervisor values (32,'Rania','Engineering');
insert into PostGradUser values ('Laila@gmail.com','l1234')
insert into Supervisor values (33,'Laila','Pharmacy');
insert into PostGradUser values ('Alaa@gmail.com','a1234')
insert into Supervisor values (34,'Alaa','Engineering');

--Thesis
select * from Thesis
insert into thesis values('CSEN','MAS','Artifical Intelligence','12-12-2019','12-12-2022',null,null,null,null)
insert into thesis values('Business','MAS','International business','12-12-2018','12-12-2021',null,null,null,null)
insert into thesis values('Pharmacy','MAS','Modern Medicine','12-12-2021','12-12-2024',null,null,null,null)
insert into thesis values('Applied Arts','MAS','Art of painting','12-12-2017','12-12-2021',null,null,null,null)
insert into thesis values('Pharmcy','phd','Biotech','12-12-2019','12-12-2022',null,null,null,null)
insert into thesis values('Engineering','Mas','Modern Architecture','12-12-2021','12-12-2022',null,null,null,null)

--Gucian register thesis
select * from GUCianStudentRegisterThesis
insert into GUCianStudentRegisterThesis values(25,32,19)
insert into GUCianStudentRegisterThesis values(27,33,20)

--nonGucian register thesis
select * from NonGUCianStudentRegisterThesis
insert into NonGUCianStudentRegisterThesis values(29,33,23)
insert into NonGUCianStudentRegisterThesis values(31,32,21)
insert into NonGUCianStudentRegisterThesis values (30,32,24)

--publication insertion
select * from publication
insert into publication values('Machine Learning','01-02-2020','Egypt','1','GUC')
insert into publication values('Buisness Around the World','01-02-2021','Egypt','1','AUC')
insert into publication values('Machine Learning','01-02-2020','Egypt','1','GUC')
insert into publication values('Building Complexity','01-01-2022','Egypt','1','GUC')

--publication x thesis
--they are now fixed
select * from ThesisHasPublication
insert into ThesisHasPublication values(19,1)
insert into ThesisHasPublication values(21,2)
insert into ThesisHasPublication values(24,3)

--progress report gucian
select * from GUCianProgressReport
insert into GUCianProgressReport values(27,1,'01-01-2022',null,null,null,20,33)
insert into GUCianProgressReport values(27,2,'02-01-2022',null,null,null,20,33)

--progress report nonGucian
insert into NonGUCianProgressReport values(30,1,'01-01-2022',null,null,null,24,32)
insert into NonGUCianProgressReport values(30,2,'02-01-2022',null,null,null,24,32)

insert into NonGUCianProgressReport values(31,1,'01-01-2022',null,null,null,21,32)

--Register course
select * from NonGucianStudentTakeCourse
insert into NonGucianStudentTakeCourse values(31,6,51)
insert into NonGucianStudentTakeCourse values(31,7,49)

insert into NonGucianStudentTakeCourse values(30,6,70)

insert into PostGradUser (email, password)
values('mohsen.kamal@gmail.com','momo123')
insert into PostGradUser (email, password)
values('karema.ali@yahoo.com','12koky34')


insert into GucianStudent(id,firstName, lastName, type, faculty, address, GPA, undergradID)
values('35','mohsen','kamal','GUC','IET','Tagamoo','0.70','16879')

insert into GucianStudent(id,firstName, lastName, type, faculty, address, GPA, undergradID)
values('36','karema','ali','GUC','IET','Tagamoo','1.00','21687')

Insert into GUCianStudentRegisterThesis(sid, supid, serial_no) values('35','18','14')
Insert into GUCianStudentRegisterThesis(sid, supid, serial_no) values('36','18','15')


---------------------------------------------------------------------
select * from ExaminerEvaluateDefense
select * from Thesis
select * from Defense
select * from GucianStudent
select * from NonGucianStudent
select * from Examiner
select * from Supervisor
select * from PostGradUser
select * from GUCianStudentRegisterThesis
select * from NonGUCianStudentRegisterThesis
select * from Payment
select * from Installment