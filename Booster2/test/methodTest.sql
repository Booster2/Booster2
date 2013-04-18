drop database if exists StudentSystem;
create database StudentSystem;
 use StudentSystem;
drop table if exists _Meta_Classes;
create table _Meta_Classes (id int   auto_increment primary key );
drop table if exists _Meta_Attributes;
create table _Meta_Attributes (id int   auto_increment primary key );
drop table if exists _Meta_Methods;
create table _Meta_Methods (id int   auto_increment primary key );
drop table if exists _Meta_Method_Params;
create table _Meta_Method_Params (id int   auto_increment primary key );
drop table if exists Staff;
create table Staff (StaffId int   auto_increment primary key );

alter table Staff
	add column id int     ;
alter table Staff
	add column firstName varchar(500)     ;
alter table Staff
	add column lastName varchar(500)     ;

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

alter table _Meta_Classes
	add column className varchar(500)     ;
alter table _Meta_Classes
	add column tableName varchar(500)     ;

drop procedure if exists Staff_create;
delimiter //
create procedure Staff_create ( in f varchar(100), out s int)
  begin 
	declare exit handler for not found rollback;
	declare exit handler for sqlwarning rollback;
	declare exit handler for sqlexception rollback;
  start transaction;
  
  if true and true and true and true and true and true and true and true and true and true and true
  then begin
       
       insert  
       into
       Staff
       ()
       values
       ()
        ;
       (select  LAST_INSERT_ID()  
       
       
       
       
       
       
       into s
       ) ;
       
       end ;
       begin
       
       begin
       
       update  Staff
       set firstName = f
       where s = StaffId
       
        ;
       
       end ;
       begin
       
       update  Staff
       set id = 3
       where s = StaffId
       
        ;
       
       end ;
       
       end ;
       
  
  end if ;
  
  commit;
	end //
delimiter ;


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
('Staff','id','Integer','Mandatory',null,'','','Uni','Staff',0)
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
('Staff','lastName','String','Mandatory',null,'','','Uni','Staff',1)
 ;
insert  
into
_Meta_Methods
(class, methodName, isObjectMethod)
values
('Staff','create',false)
 ;
insert  
into
_Meta_Method_Params
(class, methodName, paramName, paramType, paramMultiplicity, paramInOut, paramClassName, paramSetName)
values
('Staff','create','f','String','Mandatory','input','','')
 ;
insert  
into
_Meta_Method_Params
(class, methodName, paramName, paramType, paramMultiplicity, paramInOut, paramClassName, paramSetName)
values
('Staff','create','s','ClassRef','Mandatory','output','Staff','')
 ;

