drop database if exists fstcsExample;
create database fstcsExample;
 use fstcsExample;
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
drop table if exists A;
create table A (AId int   auto_increment primary key );
drop table if exists B;
create table B (BId int   auto_increment primary key );
drop table if exists C;
create table C (CId int   auto_increment primary key );
drop table if exists A_b_B_a;
create table A_b_B_a (A_b_B_aId int   auto_increment primary key );
drop table if exists B_cp_C_bp;
create table B_cp_C_bp (B_cp_C_bpId int   auto_increment primary key );
drop table if exists B_cq_C_bq;
create table B_cq_C_bq (B_cq_C_bqId int   auto_increment primary key );

alter table B_cq_C_bq
	add column B_cq int     , add foreign key (B_cq) references B ( BId);
alter table B_cq_C_bq
	add column C_bq int     , add foreign key (C_bq) references C ( CId);

alter table B_cp_C_bp
	add column B_cp int     , add foreign key (B_cp) references B ( BId);
alter table B_cp_C_bp
	add column C_bp int     , add foreign key (C_bp) references C ( CId);

alter table A_b_B_a
	add column A_b int     , add foreign key (A_b) references A ( AId);
alter table A_b_B_a
	add column B_a int     , add foreign key (B_a) references B ( BId);

alter table C
	add column o int     ;

alter table B
	add column n int     ;

alter table A
	add column m int     ;

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

drop procedure if exists A_increment;
delimiter //
create procedure A_increment ( )
	begin
	declare exit handler for sqlwarning, sqlexception, not found 
	begin
	rollback;
	end; 
	start transaction;
  
  if (select  m  from A
     where this = AId
     
     
     
     
     
     
     ) + 1 < 10 and (select  m  from A
                             where this = AId
                             
                             
                             
                             
                             
                             
                             ) + 1 < (select  n  from A
                                                   where this = AId
                                                   
                                                   
                                                   
                                                   
                                                   
                                                   
                                                   ) or not (select  b  from A
                                                        where this = AId
                                                        
                                                        
                                                        
                                                        
                                                        
                                                        
                                                        ) != null and true and true
  then update  A
       set m = (select  m  from A
                    where this = AId
                    
                    
                    
                    
                    
                    
                    ) + 1
       where this = AId
       
        ;
       
  
  end if ;
  
  commit;
	end //
delimiter ;

drop procedure if exists B_increment;
delimiter //
create procedure B_increment ( )
	begin
	declare exit handler for sqlwarning, sqlexception, not found 
	begin
	rollback;
	end; 
	start transaction;
  
  if true and true
  then update  B
       set n = (select  n  from B
                    where this = BId
                    
                    
                    
                    
                    
                    
                    ) + 1
       where this = BId
       
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
('A','A')
 ;
insert  
into
_Meta_Attributes
(class, attName, primType, typeMultiplicity, oppAttName, className, setName, direction, tableName, isId)
values
('A','m','Integer','Mandatory',null,'','','Uni','A',0)
 ;
insert  
into
_Meta_Attributes
(class, attName, primType, typeMultiplicity, oppAttName, className, setName, direction, tableName, isId)
values
('A','b','ClassRef','Optional','a','B','','Bi','A_b_B_a',0)
 ;
insert  
into
_Meta_Methods
(class, methodName, isObjectMethod)
values
('A','increment',false)
 ;
insert  
into
_Meta_Classes
(className, tablename)
values
('B','B')
 ;
insert  
into
_Meta_Attributes
(class, attName, primType, typeMultiplicity, oppAttName, className, setName, direction, tableName, isId)
values
('B','a','ClassRef','Optional','b','A','','Bi','A_b_B_a',0)
 ;
insert  
into
_Meta_Attributes
(class, attName, primType, typeMultiplicity, oppAttName, className, setName, direction, tableName, isId)
values
('B','n','Integer','Mandatory',null,'','','Uni','B',0)
 ;
insert  
into
_Meta_Attributes
(class, attName, primType, typeMultiplicity, oppAttName, className, setName, direction, tableName, isId)
values
('B','cp','ClassRef','Set','bp','C','','Bi','B_cp_C_bp',0)
 ;
insert  
into
_Meta_Attributes
(class, attName, primType, typeMultiplicity, oppAttName, className, setName, direction, tableName, isId)
values
('B','cq','ClassRef','Set','bq','C','','Bi','B_cq_C_bq',0)
 ;
insert  
into
_Meta_Methods
(class, methodName, isObjectMethod)
values
('B','increment',false)
 ;
insert  
into
_Meta_Classes
(className, tablename)
values
('C','C')
 ;
insert  
into
_Meta_Attributes
(class, attName, primType, typeMultiplicity, oppAttName, className, setName, direction, tableName, isId)
values
('C','o','Integer','Mandatory',null,'','','Uni','C',0)
 ;
insert  
into
_Meta_Attributes
(class, attName, primType, typeMultiplicity, oppAttName, className, setName, direction, tableName, isId)
values
('C','bp','ClassRef','Mandatory','cp','B','','Bi','B_cp_C_bp',0)
 ;
insert  
into
_Meta_Attributes
(class, attName, primType, typeMultiplicity, oppAttName, className, setName, direction, tableName, isId)
values
('C','bq','ClassRef','Optional','cq','B','','Bi','B_cq_C_bq',0)
 ;

