drop database if exists methodTest;
create database methodTest;
 use methodTest;
drop table if exists _Meta_Classes;
create table _Meta_Classes (id int   auto_increment primary key );
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
alter table class1
	add column att2 varchar(1000)     ;
alter table class1
	add column att3 int     ;

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

drop procedure if exists class1_m1;
delimiter //
create procedure class1_m1 ( in this int)
  begin 
	declare exit handler for not found rollback;
	declare exit handler for sqlwarning rollback;
	declare exit handler for sqlexception rollback;
  start transaction;
  
  if true
  then update  class1
       set att1 = 5
       where this = class1Id
       
        ;
       
  
  end if ;
  
  commit;
	end //
delimiter ;

drop procedure if exists class1_m2;
delimiter //
create procedure class1_m2 ( in this int)
  begin 
	declare exit handler for not found rollback;
	declare exit handler for sqlwarning rollback;
	declare exit handler for sqlexception rollback;
  start transaction;
  
  if (select  att1  from class1
     where this = class1Id
     
     
     
     
     
     
     ) = 5
  then 
  
  end if ;
  
  commit;
	end //
delimiter ;

drop procedure if exists class1_m3;
delimiter //
create procedure class1_m3 ( in this int)
  begin 
	declare exit handler for not found rollback;
	declare exit handler for sqlwarning rollback;
	declare exit handler for sqlexception rollback;
  start transaction;
  
  if 5 = (select  att1  from class1
                           where this = class1Id
                           
                           
                           
                           
                           
                           
                           )
  then 
  
  end if ;
  
  commit;
	end //
delimiter ;

drop procedure if exists class1_m4;
delimiter //
create procedure class1_m4 ( in this int)
  begin 
	declare exit handler for not found rollback;
	declare exit handler for sqlwarning rollback;
	declare exit handler for sqlexception rollback;
  start transaction;
  
  if 5 = (select  att1  from class1
                           where this = class1Id
                           
                           
                           
                           
                           
                           
                           )
  then 
  
  end if ;
  
  commit;
	end //
delimiter ;

drop procedure if exists class1_m5;
delimiter //
create procedure class1_m5 ( in a int, in this int)
  begin 
	declare exit handler for not found rollback;
	declare exit handler for sqlwarning rollback;
	declare exit handler for sqlexception rollback;
  start transaction;
  
  if a = (select  att1  from class1
                           where this = class1Id
                           
                           
                           
                           
                           
                           
                           )
  then 
  
  end if ;
  
  commit;
	end //
delimiter ;

drop procedure if exists class1_m6;
delimiter //
create procedure class1_m6 ( in a int, in this int)
  begin 
	declare exit handler for not found rollback;
	declare exit handler for sqlwarning rollback;
	declare exit handler for sqlexception rollback;
  start transaction;
  
  if a = (select  att1  from class1
                           where this = class1Id
                           
                           
                           
                           
                           
                           
                           )
  then 
  
  end if ;
  
  commit;
	end //
delimiter ;

drop procedure if exists class1_m7;
delimiter //
create procedure class1_m7 ( in a int, in this int)
  begin 
	declare exit handler for not found rollback;
	declare exit handler for sqlwarning rollback;
	declare exit handler for sqlexception rollback;
  start transaction;
  
  if true
  then update  class1
       set att1 = a
       where this = class1Id
       
        ;
       
  
  end if ;
  
  commit;
	end //
delimiter ;

drop procedure if exists class1_m8;
delimiter //
create procedure class1_m8 ( in a int, in this int)
  begin 
	declare exit handler for not found rollback;
	declare exit handler for sqlwarning rollback;
	declare exit handler for sqlexception rollback;
  start transaction;
  
  if (select  att1  from class1
     where this = class1Id
     
     
     
     
     
     
     ) = a
  then 
  
  end if ;
  
  commit;
	end //
delimiter ;

drop procedure if exists class1_m9;
delimiter //
create procedure class1_m9 ( in this int)
  begin 
	declare exit handler for not found rollback;
	declare exit handler for sqlwarning rollback;
	declare exit handler for sqlexception rollback;
  start transaction;
  
  if true
  then update  class1
       set att1 = 7
       where this = class1Id
       
        ;
       
  
  end if ;
  
  commit;
	end //
delimiter ;

drop procedure if exists class1_m10;
delimiter //
create procedure class1_m10 ( in this int)
  begin 
	declare exit handler for not found rollback;
	declare exit handler for sqlwarning rollback;
	declare exit handler for sqlexception rollback;
  start transaction;
  
  if (select  att1  from class1
     where this = class1Id
     
     
     
     
     
     
     ) = 7
  then 
  
  end if ;
  
  commit;
	end //
delimiter ;

drop procedure if exists class1_m11;
delimiter //
create procedure class1_m11 ( in this int)
  begin 
	declare exit handler for not found rollback;
	declare exit handler for sqlwarning rollback;
	declare exit handler for sqlexception rollback;
  start transaction;
  
  if 7 = (select  att1  from class1
                           where this = class1Id
                           
                           
                           
                           
                           
                           
                           )
  then 
  
  end if ;
  
  commit;
	end //
delimiter ;

drop procedure if exists class1_m12;
delimiter //
create procedure class1_m12 ( in this int)
  begin 
	declare exit handler for not found rollback;
	declare exit handler for sqlwarning rollback;
	declare exit handler for sqlexception rollback;
  start transaction;
  
  if 7 = (select  att1  from class1
                           where this = class1Id
                           
                           
                           
                           
                           
                           
                           )
  then 
  
  end if ;
  
  commit;
	end //
delimiter ;

drop procedure if exists class1_m13;
delimiter //
create procedure class1_m13 ( in this int)
  begin 
	declare exit handler for not found rollback;
	declare exit handler for sqlwarning rollback;
	declare exit handler for sqlexception rollback;
  start transaction;
  
  if true
  then update  class1
       set att1 = 126
       where this = class1Id
       
        ;
       
  
  end if ;
  
  commit;
	end //
delimiter ;

drop procedure if exists class1_m14;
delimiter //
create procedure class1_m14 ( in a int)
  begin 
	declare exit handler for not found rollback;
	declare exit handler for sqlwarning rollback;
	declare exit handler for sqlexception rollback;
  start transaction;
  
  if a > 15
  then 
  
  end if ;
  
  commit;
	end //
delimiter ;

drop procedure if exists class1_m15;
delimiter //
create procedure class1_m15 ( in a int, in this int)
  begin 
	declare exit handler for not found rollback;
	declare exit handler for sqlwarning rollback;
	declare exit handler for sqlexception rollback;
  start transaction;
  
  if a > 5 and true
  then update  class1
       set att3 = a
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
_Meta_Attributes
(class, attName, primType, typeMultiplicity, oppAttName, className, setName, direction, tableName, isId)
values
('class1','att2','String','Mandatory',null,'','','Uni','class1',0)
 ;
insert  
into
_Meta_Attributes
(class, attName, primType, typeMultiplicity, oppAttName, className, setName, direction, tableName, isId)
values
('class1','att3','Integer','Mandatory',null,'','','Uni','class1',0)
 ;
insert  
into
_Meta_Methods
(class, methodName, isObjectMethod)
values
('class1','m1',true)
 ;
insert  
into
_Meta_Methods
(class, methodName, isObjectMethod)
values
('class1','m2',true)
 ;
insert  
into
_Meta_Methods
(class, methodName, isObjectMethod)
values
('class1','m3',true)
 ;
insert  
into
_Meta_Methods
(class, methodName, isObjectMethod)
values
('class1','m4',true)
 ;
insert  
into
_Meta_Methods
(class, methodName, isObjectMethod)
values
('class1','m5',true)
 ;
insert  
into
_Meta_Methods
(class, methodName, isObjectMethod)
values
('class1','m6',true)
 ;
insert  
into
_Meta_Methods
(class, methodName, isObjectMethod)
values
('class1','m7',true)
 ;
insert  
into
_Meta_Methods
(class, methodName, isObjectMethod)
values
('class1','m8',true)
 ;
insert  
into
_Meta_Methods
(class, methodName, isObjectMethod)
values
('class1','m9',true)
 ;
insert  
into
_Meta_Methods
(class, methodName, isObjectMethod)
values
('class1','m10',true)
 ;
insert  
into
_Meta_Methods
(class, methodName, isObjectMethod)
values
('class1','m11',true)
 ;
insert  
into
_Meta_Methods
(class, methodName, isObjectMethod)
values
('class1','m12',true)
 ;
insert  
into
_Meta_Methods
(class, methodName, isObjectMethod)
values
('class1','m13',true)
 ;
insert  
into
_Meta_Methods
(class, methodName, isObjectMethod)
values
('class1','m14',false)
 ;
insert  
into
_Meta_Methods
(class, methodName, isObjectMethod)
values
('class1','m15',true)
 ;
insert  
into
_Meta_Method_Params
(class, methodName, paramName, paramType, paramMultiplicity, paramInOut, paramClassName, paramSetName)
values
('class1','m1','this','ClassRef','Mandatory','input','class1','')
 ;
insert  
into
_Meta_Method_Params
(class, methodName, paramName, paramType, paramMultiplicity, paramInOut, paramClassName, paramSetName)
values
('class1','m2','this','ClassRef','Mandatory','input','class1','')
 ;
insert  
into
_Meta_Method_Params
(class, methodName, paramName, paramType, paramMultiplicity, paramInOut, paramClassName, paramSetName)
values
('class1','m3','this','ClassRef','Mandatory','input','class1','')
 ;
insert  
into
_Meta_Method_Params
(class, methodName, paramName, paramType, paramMultiplicity, paramInOut, paramClassName, paramSetName)
values
('class1','m4','this','ClassRef','Mandatory','input','class1','')
 ;
insert  
into
_Meta_Method_Params
(class, methodName, paramName, paramType, paramMultiplicity, paramInOut, paramClassName, paramSetName)
values
('class1','m5','a','Integer','Mandatory','input','','')
 ;
insert  
into
_Meta_Method_Params
(class, methodName, paramName, paramType, paramMultiplicity, paramInOut, paramClassName, paramSetName)
values
('class1','m5','this','ClassRef','Mandatory','input','class1','')
 ;
insert  
into
_Meta_Method_Params
(class, methodName, paramName, paramType, paramMultiplicity, paramInOut, paramClassName, paramSetName)
values
('class1','m6','a','Integer','Mandatory','input','','')
 ;
insert  
into
_Meta_Method_Params
(class, methodName, paramName, paramType, paramMultiplicity, paramInOut, paramClassName, paramSetName)
values
('class1','m6','this','ClassRef','Mandatory','input','class1','')
 ;
insert  
into
_Meta_Method_Params
(class, methodName, paramName, paramType, paramMultiplicity, paramInOut, paramClassName, paramSetName)
values
('class1','m7','a','Integer','Mandatory','input','','')
 ;
insert  
into
_Meta_Method_Params
(class, methodName, paramName, paramType, paramMultiplicity, paramInOut, paramClassName, paramSetName)
values
('class1','m7','this','ClassRef','Mandatory','input','class1','')
 ;
insert  
into
_Meta_Method_Params
(class, methodName, paramName, paramType, paramMultiplicity, paramInOut, paramClassName, paramSetName)
values
('class1','m8','a','Integer','Mandatory','input','','')
 ;
insert  
into
_Meta_Method_Params
(class, methodName, paramName, paramType, paramMultiplicity, paramInOut, paramClassName, paramSetName)
values
('class1','m8','this','ClassRef','Mandatory','input','class1','')
 ;
insert  
into
_Meta_Method_Params
(class, methodName, paramName, paramType, paramMultiplicity, paramInOut, paramClassName, paramSetName)
values
('class1','m9','this','ClassRef','Mandatory','input','class1','')
 ;
insert  
into
_Meta_Method_Params
(class, methodName, paramName, paramType, paramMultiplicity, paramInOut, paramClassName, paramSetName)
values
('class1','m10','this','ClassRef','Mandatory','input','class1','')
 ;
insert  
into
_Meta_Method_Params
(class, methodName, paramName, paramType, paramMultiplicity, paramInOut, paramClassName, paramSetName)
values
('class1','m11','this','ClassRef','Mandatory','input','class1','')
 ;
insert  
into
_Meta_Method_Params
(class, methodName, paramName, paramType, paramMultiplicity, paramInOut, paramClassName, paramSetName)
values
('class1','m12','this','ClassRef','Mandatory','input','class1','')
 ;
insert  
into
_Meta_Method_Params
(class, methodName, paramName, paramType, paramMultiplicity, paramInOut, paramClassName, paramSetName)
values
('class1','m13','this','ClassRef','Mandatory','input','class1','')
 ;
insert  
into
_Meta_Method_Params
(class, methodName, paramName, paramType, paramMultiplicity, paramInOut, paramClassName, paramSetName)
values
('class1','m14','a','Integer','Mandatory','input','','')
 ;
insert  
into
_Meta_Method_Params
(class, methodName, paramName, paramType, paramMultiplicity, paramInOut, paramClassName, paramSetName)
values
('class1','m15','a','Integer','Mandatory','input','','')
 ;
insert  
into
_Meta_Method_Params
(class, methodName, paramName, paramType, paramMultiplicity, paramInOut, paramClassName, paramSetName)
values
('class1','m15','this','ClassRef','Mandatory','input','class1','')
 ;

