drop database if exists Student;
create database Student;
 use Student;
 SET autocommit=0;
drop table if exists _Meta_Classes;
create table _Meta_Classes (id int   auto_increment primary key );
drop table if exists _Meta_Sets;
create table _Meta_Sets (id int   auto_increment primary key );
drop table if exists _Meta_Attributes;
create table _Meta_Attributes (id int   auto_increment primary key );
drop table if exists _Meta_Methods;
create table _Meta_Methods (id int   auto_increment primary key );
drop table if exists _Meta_Method_Params;
create table _Meta_Method_Params (id int   auto_increment primary key );
drop table if exists Status;
create table Status (Status varchar(100)  default "unassigned"  primary key );
drop table if exists Student;
create table Student (StudentId int   auto_increment primary key );
drop table if exists Staff;
create table Staff (StaffId int   auto_increment primary key );
drop table if exists Student_supervisors_Staff_supervisees;
create table Student_supervisors_Staff_supervisees (Student_supervisors_Staff_superviseesId int   auto_increment primary key );

alter table Student_supervisors_Staff_supervisees
	add column Student_supervisors int     , add foreign key (Student_supervisors) references Student ( StudentId);
alter table Student_supervisors_Staff_supervisees
	add column Staff_supervisees int     , add foreign key (Staff_supervisees) references Staff ( StaffId);

alter table Staff
	add column lastName varchar(1000)     ;
alter table Staff
	add column firstName varchar(1000)     ;

alter table Student
	add column lastName varchar(1000)     ;
alter table Student
	add column firstName varchar(1000)     ;
alter table Student
	add column status varchar(500)     , add foreign key (status) references Status ( Status);


alter table _Meta_Method_Params
	add column class varchar(500)     ;
alter table _Meta_Method_Params
	add column methodName varchar(500)     ;
alter table _Meta_Method_Params
	add column paramName varchar(500)     ;
alter table _Meta_Method_Params
	add column paramType varchar(500)     ;
alter table _Meta_Method_Params
	add column paramMultiplicity varchar(500)     ;
alter table _Meta_Method_Params
	add column paramInOut varchar(10)     ;
alter table _Meta_Method_Params
	add column paramClassName varchar(500)     ;
alter table _Meta_Method_Params
	add column paramSetName varchar(500)     ;

alter table _Meta_Methods
	add column class varchar(500)     ;
alter table _Meta_Methods
	add column methodName varchar(500)     ;
alter table _Meta_Methods
	add column isObjectMethod bit     ;

alter table _Meta_Attributes
	add column class varchar(500)     ;
alter table _Meta_Attributes
	add column attName varchar(500)     ;
alter table _Meta_Attributes
	add column primType varchar(500)     ;
alter table _Meta_Attributes
	add column typeMultiplicity varchar(500)     ;
alter table _Meta_Attributes
	add column className varchar(500)     ;
alter table _Meta_Attributes
	add column setName varchar(500)     ;
alter table _Meta_Attributes
	add column direction varchar(500)     ;
alter table _Meta_Attributes
	add column tableName varchar(500)     ;
alter table _Meta_Attributes
	add column oppAttName varchar(500)     ;
alter table _Meta_Attributes
	add column isId bit     ;

alter table _Meta_Sets
	add column setName varchar(500)     ;
alter table _Meta_Sets
	add column tableName varchar(500)     ;
alter table _Meta_Sets
	add column columnName varchar(500)     ;

alter table _Meta_Classes
	add column className varchar(500)     ;
alter table _Meta_Classes
	add column tableName varchar(500)     ;

drop procedure if exists Student_Create;
delimiter //
create procedure Student_Create ( in supervisor_in int, in status_in varchar(1000), in firstName_in varchar(1000), in lastName_in varchar(1000), out s_out int)
	begin
	declare exit handler for sqlwarning, sqlexception, not found 
	begin
	rollback;
	end; 
	start transaction;
  
  if true and true and true and true and true and true and true and true and true
  then begin
       
       insert  
       into
       Student
       ()
       values
       ()
        ;
       (select  LAST_INSERT_ID()  
       
       
       
       
       
       
       into s_out
       ) ;
       
       end ;
       begin
       
       begin
       
       begin
       
       insert  
       into
       Student_supervisors_Staff_supervisees
       (Staff_supervisees, Student_supervisors)
       values
       ()
        ;
       
       end ;
       begin
       
       insert  
       into
       Student_supervisors_Staff_supervisees
       (Student_supervisors, Staff_supervisees)
       values
       ()
        ;
       
       end ;
       
       end ;
       begin
       
       begin
       
       update  Student
       set status = status_in
       where s_out = StudentId
       
        ;
       
       end ;
       begin
       
       begin
       
       update  Student
       set firstName = firstName_in
       where s_out = StudentId
       
        ;
       
       end ;
       begin
       
       update  Student
       set lastName = lastName_in
       where s_out = StudentId
       
        ;
       
       end ;
       
       end ;
       
       end ;
       
       end ;
       
  
  end if ;
  
  commit;
	end //
delimiter ;

drop procedure if exists Staff_Create;
delimiter //
create procedure Staff_Create ( in firstName_in varchar(1000), in lastName_in varchar(1000), out s_out int)
	begin
	declare exit handler for sqlwarning, sqlexception, not found 
	begin
	rollback;
	end; 
	start transaction;
  
  if true and true
  then begin
       
       insert  
       into
       Staff
       ()
       values
       ()
        ;
       (select  LAST_INSERT_ID()  
       
       
       
       
       
       
       into s_out
       ) ;
       
       end ;
       begin
       
       begin
       
       update  Staff
       set firstName = firstName_in
       where s_out = StaffId
       
        ;
       
       end ;
       begin
       
       update  Staff
       set lastName = lastName_in
       where s_out = StaffId
       
        ;
       
       end ;
       
       end ;
       
  
  end if ;
  
  commit;
	end //
delimiter ;


insert  
into
_Meta_Sets
(setName, tablename, columnName)
values
('Status','Status','Status')
 ;
insert  
into
_Meta_Classes
(className, tablename)
values
('Student','Student')
 ;
insert  
into
_Meta_Attributes
(class, attName, primType, typeMultiplicity, oppAttName, className, setName, direction, tableName, isId)
values
('Student','lastName','String','Mandatory',null,'','','Uni','Student',1)
 ;
insert  
into
_Meta_Attributes
(class, attName, primType, typeMultiplicity, oppAttName, className, setName, direction, tableName, isId)
values
('Student','firstName','String','Mandatory',null,'','','Uni','Student',1)
 ;
insert  
into
_Meta_Attributes
(class, attName, primType, typeMultiplicity, oppAttName, className, setName, direction, tableName, isId)
values
('Student','status','SetValue','Mandatory',null,'','Status','Uni','Student',0)
 ;
insert  
into
_Meta_Attributes
(class, attName, primType, typeMultiplicity, oppAttName, className, setName, direction, tableName, isId)
values
('Student','supervisors','ClassRef','Set','supervisees','Staff','','Bi','Student_supervisors_Staff_supervisees',0)
 ;
insert  
into
_Meta_Methods
(class, methodName, isObjectMethod)
values
('Student','Create',false)
 ;
insert  
into
_Meta_Method_Params
(class, methodName, paramName, paramType, paramMultiplicity, paramInOut, paramClassName, paramSetName)
values
('Student','Create','supervisor','ClassRef','Mandatory','input','Staff','')
 ;
insert  
into
_Meta_Method_Params
(class, methodName, paramName, paramType, paramMultiplicity, paramInOut, paramClassName, paramSetName)
values
('Student','Create','status','SetValue','Mandatory','input','','Status')
 ;
insert  
into
_Meta_Method_Params
(class, methodName, paramName, paramType, paramMultiplicity, paramInOut, paramClassName, paramSetName)
values
('Student','Create','firstName','String','Mandatory','input','','')
 ;
insert  
into
_Meta_Method_Params
(class, methodName, paramName, paramType, paramMultiplicity, paramInOut, paramClassName, paramSetName)
values
('Student','Create','lastName','String','Mandatory','input','','')
 ;
insert  
into
_Meta_Method_Params
(class, methodName, paramName, paramType, paramMultiplicity, paramInOut, paramClassName, paramSetName)
values
('Student','Create','s','ClassRef','Mandatory','output','Student','')
 ;
insert  
into
_Meta_Classes
(className, tablename)
values
('Staff','Staff')
 ;
insert  
into
_Meta_Attributes
(class, attName, primType, typeMultiplicity, oppAttName, className, setName, direction, tableName, isId)
values
('Staff','lastName','String','Mandatory',null,'','','Uni','Staff',1)
 ;
insert  
into
_Meta_Attributes
(class, attName, primType, typeMultiplicity, oppAttName, className, setName, direction, tableName, isId)
values
('Staff','firstName','String','Mandatory',null,'','','Uni','Staff',1)
 ;
insert  
into
_Meta_Attributes
(class, attName, primType, typeMultiplicity, oppAttName, className, setName, direction, tableName, isId)
values
('Staff','supervisees','ClassRef','Set','supervisors','Student','','Bi','Student_supervisors_Staff_supervisees',0)
 ;
insert  
into
_Meta_Methods
(class, methodName, isObjectMethod)
values
('Staff','Create',false)
 ;
insert  
into
_Meta_Method_Params
(class, methodName, paramName, paramType, paramMultiplicity, paramInOut, paramClassName, paramSetName)
values
('Staff','Create','firstName','String','Mandatory','input','','')
 ;
insert  
into
_Meta_Method_Params
(class, methodName, paramName, paramType, paramMultiplicity, paramInOut, paramClassName, paramSetName)
values
('Staff','Create','lastName','String','Mandatory','input','','')
 ;
insert  
into
_Meta_Method_Params
(class, methodName, paramName, paramType, paramMultiplicity, paramInOut, paramClassName, paramSetName)
values
('Staff','Create','s','ClassRef','Mandatory','output','Staff','')
 ;
insert  
into
Status
(Status)
values
('Undergraduate')
 ;
insert  
into
Status
(Status)
values
('Staff')
 ;
insert  
into
Status
(Status)
values
('Chancellor')
 ;
insert  
into
Status
(Status)
values
('Postgraduate')
 ;
insert  
into
Status
(Status)
values
('Congregation')
 ;
insert  
into
Status
(Status)
values
('ViceChancellor')
 ;
insert  
into
Status
(Status)
values
('unassigned')
 ;

