drop database if exists methodTest;
create database methodTest;
 use methodTest;
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
drop table if exists class1;
create table class1 (class1Id int   auto_increment primary key );

alter table class1
	add column att1 int     ;

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

drop procedure if exists class1_m1;
delimiter //
create procedure class1_m1 ( )
	begin
	declare exit handler for sqlwarning, sqlexception, not found 
	begin
	rollback;
	end; 
	start transaction;
  
  if true
  then update  class1
       set att1 = (select  att1  from class1
                    where this = class1Id
                    
                    
                    
                    
                    
                    
                    ) + 5
       where this = class1Id
       
        ;
       
  
  end if ;
  
  commit;
	end //
delimiter ;


insert  
into
_Meta_Classes
(className, tablename)
values
('class1','class1')
 ;
insert  
into
_Meta_Attributes
(class, attName, primType, typeMultiplicity, oppAttName, className, setName, direction, tableName, isId)
values
('class1','att1','Integer','Mandatory',null,'','','Uni','class1',0)
 ;
insert  
into
_Meta_Methods
(class, methodName, isObjectMethod)
values
('class1','m1',false)
 ;

