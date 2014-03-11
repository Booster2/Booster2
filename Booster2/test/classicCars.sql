drop database if exists ClassicCars;
create database ClassicCars;
 use ClassicCars;
 SET autocommit=0;
drop table if exists _Meta_Classes;
create table _Meta_Classes (id int   auto_increment primary key );
alter table _Meta_Classes
	add column className varchar(500)     ;
alter table _Meta_Classes
	add column tableName varchar(500)     ;
drop table if exists _Meta_Sets;
create table _Meta_Sets (id int   auto_increment primary key );
alter table _Meta_Sets
	add column setName varchar(500)     ;
alter table _Meta_Sets
	add column tableName varchar(500)     ;
alter table _Meta_Sets
	add column columnName varchar(500)     ;
drop table if exists _Meta_Attributes;
create table _Meta_Attributes (id int   auto_increment primary key );
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
drop table if exists _Meta_Methods;
create table _Meta_Methods (id int   auto_increment primary key );
alter table _Meta_Methods
	add column class varchar(500)     ;
alter table _Meta_Methods
	add column methodName varchar(500)     ;
alter table _Meta_Methods
	add column isObjectMethod bit     ;
drop table if exists _Meta_Method_Params;
create table _Meta_Method_Params (id int   auto_increment primary key );
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
drop table if exists ProductLine;
create table ProductLine (ProductLineId int   auto_increment primary key );
alter table ProductLine
	add column productLine varchar(1000)     ;
alter table ProductLine
	add column textDescription varchar(1000)     ;
alter table ProductLine
	add column htmlDescription varchar(1000)     ;
alter table ProductLine
	add column image varchar(1000)     ;
drop table if exists Product;
create table Product (ProductId int   auto_increment primary key );
alter table Product
	add column productName varchar(1000)     ;
alter table Product
	add column productCode varchar(1000)     ;
alter table Product
	add column productScale varchar(1000)     ;
alter table Product
	add column productVendor varchar(1000)     ;
alter table Product
	add column productDescription varchar(1000)     ;
alter table Product
	add column quantityInStock int     ;
alter table Product
	add column buyPrice varchar(1000)     ;
alter table Product
	add column MSRP varchar(1000)     ;
drop table if exists PurchaseOrderDetails;
create table PurchaseOrderDetails (PurchaseOrderDetailsId int   auto_increment primary key );
alter table PurchaseOrderDetails
	add column quantityOrdered int     ;
alter table PurchaseOrderDetails
	add column priceEach varchar(1000)     ;
alter table PurchaseOrderDetails
	add column orderLineNumber int     ;
drop table if exists PurchaseOrder;
create table PurchaseOrder (PurchaseOrderId int   auto_increment primary key );
alter table PurchaseOrder
	add column orderNumber int     ;
alter table PurchaseOrder
	add column orderDate varchar(1000)     ;
alter table PurchaseOrder
	add column requiredDate varchar(1000)     ;
alter table PurchaseOrder
	add column shippedDate varchar(1000)     ;
alter table PurchaseOrder
	add column status varchar(1000)     ;
alter table PurchaseOrder
	add column comments varchar(1000)     ;
drop table if exists Customer;
create table Customer (CustomerId int   auto_increment primary key );
alter table Customer
	add column customerNumber int     ;
alter table Customer
	add column customerName varchar(1000)     ;
alter table Customer
	add column contactLastName varchar(1000)     ;
alter table Customer
	add column contactFirstName varchar(1000)     ;
alter table Customer
	add column phone varchar(1000)     ;
alter table Customer
	add column addressLine1 varchar(1000)     ;
alter table Customer
	add column addressLine2 varchar(1000)     ;
alter table Customer
	add column city varchar(1000)     ;
alter table Customer
	add column state varchar(1000)     ;
alter table Customer
	add column postalCode varchar(1000)     ;
alter table Customer
	add column country varchar(1000)     ;
alter table Customer
	add column creditLimit varchar(1000)     ;
drop table if exists Payment;
create table Payment (PaymentId int   auto_increment primary key );
alter table Payment
	add column checkNumber varchar(1000)     ;
alter table Payment
	add column paymentDate varchar(1000)     ;
alter table Payment
	add column amount varchar(1000)     ;
drop table if exists Employee;
create table Employee (EmployeeId int   auto_increment primary key );
alter table Employee
	add column employeeNumber int     ;
alter table Employee
	add column lastName varchar(1000)     ;
alter table Employee
	add column firstName varchar(1000)     ;
alter table Employee
	add column extension varchar(1000)     ;
alter table Employee
	add column email varchar(1000)     ;
alter table Employee
	add column jobTitle varchar(1000)     ;
drop table if exists Office;
create table Office (OfficeId int   auto_increment primary key );
alter table Office
	add column officeCode int     ;
alter table Office
	add column city varchar(1000)     ;
alter table Office
	add column phone varchar(1000)     ;
alter table Office
	add column addressLine1 varchar(1000)     ;
alter table Office
	add column addressLine2 varchar(1000)     ;
alter table Office
	add column state varchar(1000)     ;
alter table Office
	add column country varchar(1000)     ;
alter table Office
	add column postalCode varchar(1000)     ;
alter table Office
	add column territory varchar(1000)     ;
drop table if exists ProductLine_products;
create table ProductLine_products (ProductLine_productsId int   auto_increment primary key );
alter table ProductLine_products
	add column ProductLine_products int     , add foreign key (ProductLine_products) references ProductLine ( ProductLineId);
alter table ProductLine_products
	add column Product_productLine int     , add foreign key (Product_productLine) references Product ( ProductId);
drop table if exists Product_productLine;
create table Product_productLine (Product_productLineId int   auto_increment primary key );
alter table Product_productLine
	add column Product_productLine int     , add foreign key (Product_productLine) references Product ( ProductId);
alter table Product_productLine
	add column ProductLine_products int     , add foreign key (ProductLine_products) references ProductLine ( ProductLineId);
drop table if exists Product_forPurchaseOrders;
create table Product_forPurchaseOrders (Product_forPurchaseOrdersId int   auto_increment primary key );
alter table Product_forPurchaseOrders
	add column Product_forPurchaseOrders int     , add foreign key (Product_forPurchaseOrders) references Product ( ProductId);
alter table Product_forPurchaseOrders
	add column PurchaseOrderDetails_product int     , add foreign key (PurchaseOrderDetails_product) references PurchaseOrderDetails ( PurchaseOrderDetailsId);
drop table if exists PurchaseOrderDetails_purchaseOrder;
create table PurchaseOrderDetails_purchaseOrder (PurchaseOrderDetails_purchaseOrderId int   auto_increment primary key );
alter table PurchaseOrderDetails_purchaseOrder
	add column PurchaseOrderDetails_purchaseOrder int     , add foreign key (PurchaseOrderDetails_purchaseOrder) references PurchaseOrderDetails ( PurchaseOrderDetailsId);
alter table PurchaseOrderDetails_purchaseOrder
	add column PurchaseOrder_details int     , add foreign key (PurchaseOrder_details) references PurchaseOrder ( PurchaseOrderId);
drop table if exists PurchaseOrderDetails_product;
create table PurchaseOrderDetails_product (PurchaseOrderDetails_productId int   auto_increment primary key );
alter table PurchaseOrderDetails_product
	add column PurchaseOrderDetails_product int     , add foreign key (PurchaseOrderDetails_product) references PurchaseOrderDetails ( PurchaseOrderDetailsId);
alter table PurchaseOrderDetails_product
	add column Product_forPurchaseOrders int     , add foreign key (Product_forPurchaseOrders) references Product ( ProductId);
drop table if exists PurchaseOrder_details;
create table PurchaseOrder_details (PurchaseOrder_detailsId int   auto_increment primary key );
alter table PurchaseOrder_details
	add column PurchaseOrder_details int     , add foreign key (PurchaseOrder_details) references PurchaseOrder ( PurchaseOrderId);
alter table PurchaseOrder_details
	add column PurchaseOrderDetails_purchaseOrder int     , add foreign key (PurchaseOrderDetails_purchaseOrder) references PurchaseOrderDetails ( PurchaseOrderDetailsId);
drop table if exists PurchaseOrder_customer;
create table PurchaseOrder_customer (PurchaseOrder_customerId int   auto_increment primary key );
alter table PurchaseOrder_customer
	add column PurchaseOrder_customer int     , add foreign key (PurchaseOrder_customer) references PurchaseOrder ( PurchaseOrderId);
alter table PurchaseOrder_customer
	add column Customer_orders int     , add foreign key (Customer_orders) references Customer ( CustomerId);
drop table if exists Customer_salesRepEmployee;
create table Customer_salesRepEmployee (Customer_salesRepEmployeeId int   auto_increment primary key );
alter table Customer_salesRepEmployee
	add column Customer_salesRepEmployee int     , add foreign key (Customer_salesRepEmployee) references Customer ( CustomerId);
alter table Customer_salesRepEmployee
	add column Employee_salesRepFor int     , add foreign key (Employee_salesRepFor) references Employee ( EmployeeId);
drop table if exists Customer_orders;
create table Customer_orders (Customer_ordersId int   auto_increment primary key );
alter table Customer_orders
	add column Customer_orders int     , add foreign key (Customer_orders) references Customer ( CustomerId);
alter table Customer_orders
	add column PurchaseOrder_customer int     , add foreign key (PurchaseOrder_customer) references PurchaseOrder ( PurchaseOrderId);
drop table if exists Customer_payments;
create table Customer_payments (Customer_paymentsId int   auto_increment primary key );
alter table Customer_payments
	add column Customer_payments int     , add foreign key (Customer_payments) references Customer ( CustomerId);
alter table Customer_payments
	add column Payment_customer int     , add foreign key (Payment_customer) references Payment ( PaymentId);
drop table if exists Payment_customer;
create table Payment_customer (Payment_customerId int   auto_increment primary key );
alter table Payment_customer
	add column Payment_customer int     , add foreign key (Payment_customer) references Payment ( PaymentId);
alter table Payment_customer
	add column Customer_payments int     , add foreign key (Customer_payments) references Customer ( CustomerId);
drop table if exists Employee_office;
create table Employee_office (Employee_officeId int   auto_increment primary key );
alter table Employee_office
	add column Employee_office int     , add foreign key (Employee_office) references Employee ( EmployeeId);
alter table Employee_office
	add column Office_employees int     , add foreign key (Office_employees) references Office ( OfficeId);
drop table if exists Employee_reportsTo;
create table Employee_reportsTo (Employee_reportsToId int   auto_increment primary key );
alter table Employee_reportsTo
	add column Employee_reportsTo int     , add foreign key (Employee_reportsTo) references Employee ( EmployeeId);
alter table Employee_reportsTo
	add column Employee_inChargeOf int     , add foreign key (Employee_inChargeOf) references Employee ( EmployeeId);
drop table if exists Employee_inChargeOf;
create table Employee_inChargeOf (Employee_inChargeOfId int   auto_increment primary key );
alter table Employee_inChargeOf
	add column Employee_inChargeOf int     , add foreign key (Employee_inChargeOf) references Employee ( EmployeeId);
alter table Employee_inChargeOf
	add column Employee_reportsTo int     , add foreign key (Employee_reportsTo) references Employee ( EmployeeId);
drop table if exists Employee_salesRepFor;
create table Employee_salesRepFor (Employee_salesRepForId int   auto_increment primary key );
alter table Employee_salesRepFor
	add column Employee_salesRepFor int     , add foreign key (Employee_salesRepFor) references Employee ( EmployeeId);
alter table Employee_salesRepFor
	add column Customer_salesRepEmployee int     , add foreign key (Customer_salesRepEmployee) references Customer ( CustomerId);
drop table if exists Office_employees;
create table Office_employees (Office_employeesId int   auto_increment primary key );
alter table Office_employees
	add column Office_employees int     , add foreign key (Office_employees) references Office ( OfficeId);
alter table Office_employees
	add column Employee_office int     , add foreign key (Employee_office) references Employee ( EmployeeId);

drop procedure if exists ProductLine_updateText;
delimiter //
create procedure ProductLine_updateText ( in t_in varchar(1000),in this int)
	begin
	declare exit handler for sqlwarning, sqlexception, not found 
	begin
	rollback;
	end; 
	start transaction;
  
  if true
  then update  ProductLine
       set textDescription = t_in
       where this = ProductLineId
       
       ;
  
  end if;
  commit;
	end //
delimiter ;
insert  
into
_Meta_Classes
(className, tablename)
values
('ProductLine', 'ProductLine')
;insert  
into
_Meta_Attributes
(class, attName, primType, typeMultiplicity, oppAttName, className, setName, direction, tableName, isId)
values
('ProductLine', 'productLine', 'String', 'Mandatory', null, '', '', 'Uni', 'ProductLine', 1)
;insert  
into
_Meta_Attributes
(class, attName, primType, typeMultiplicity, oppAttName, className, setName, direction, tableName, isId)
values
('ProductLine', 'textDescription', 'String', 'Mandatory', null, '', '', 'Uni', 'ProductLine', 0)
;insert  
into
_Meta_Attributes
(class, attName, primType, typeMultiplicity, oppAttName, className, setName, direction, tableName, isId)
values
('ProductLine', 'htmlDescription', 'String', 'Mandatory', null, '', '', 'Uni', 'ProductLine', 0)
;insert  
into
_Meta_Attributes
(class, attName, primType, typeMultiplicity, oppAttName, className, setName, direction, tableName, isId)
values
('ProductLine', 'image', 'String', 'Mandatory', null, '', '', 'Uni', 'ProductLine', 0)
;insert  
into
_Meta_Attributes
(class, attName, primType, typeMultiplicity, oppAttName, className, setName, direction, tableName, isId)
values
('ProductLine', 'products', 'ClassRef', 'Set', 'productLine', 'Product', '', 'Bi', 'ProductLine_products', 0)
;insert  
into
_Meta_Methods
(class, methodName, isObjectMethod)
values
('ProductLine', 'updateText', true)
;insert  
into
_Meta_Method_Params
(class, methodName, paramName, paramType, paramMultiplicity, paramInOut, paramClassName, paramSetName)
values
('ProductLine', 'updateText', 't', 'String', 'Mandatory', 'input', '', '')
;insert  
into
_Meta_Method_Params
(class, methodName, paramName, paramType, paramMultiplicity, paramInOut, paramClassName, paramSetName)
values
('ProductLine', 'updateText', 'this', 'ClassRef', 'Mandatory', 'input', 'ProductLine', '')
;insert  
into
_Meta_Classes
(className, tablename)
values
('Product', 'Product')
;insert  
into
_Meta_Attributes
(class, attName, primType, typeMultiplicity, oppAttName, className, setName, direction, tableName, isId)
values
('Product', 'productName', 'String', 'Mandatory', null, '', '', 'Uni', 'Product', 1)
;insert  
into
_Meta_Attributes
(class, attName, primType, typeMultiplicity, oppAttName, className, setName, direction, tableName, isId)
values
('Product', 'productCode', 'String', 'Mandatory', null, '', '', 'Uni', 'Product', 1)
;insert  
into
_Meta_Attributes
(class, attName, primType, typeMultiplicity, oppAttName, className, setName, direction, tableName, isId)
values
('Product', 'productScale', 'String', 'Mandatory', null, '', '', 'Uni', 'Product', 0)
;insert  
into
_Meta_Attributes
(class, attName, primType, typeMultiplicity, oppAttName, className, setName, direction, tableName, isId)
values
('Product', 'productVendor', 'String', 'Mandatory', null, '', '', 'Uni', 'Product', 0)
;insert  
into
_Meta_Attributes
(class, attName, primType, typeMultiplicity, oppAttName, className, setName, direction, tableName, isId)
values
('Product', 'productDescription', 'String', 'Mandatory', null, '', '', 'Uni', 'Product', 0)
;insert  
into
_Meta_Attributes
(class, attName, primType, typeMultiplicity, oppAttName, className, setName, direction, tableName, isId)
values
('Product', 'quantityInStock', 'Integer', 'Mandatory', null, '', '', 'Uni', 'Product', 0)
;insert  
into
_Meta_Attributes
(class, attName, primType, typeMultiplicity, oppAttName, className, setName, direction, tableName, isId)
values
('Product', 'buyPrice', 'String', 'Mandatory', null, '', '', 'Uni', 'Product', 0)
;insert  
into
_Meta_Attributes
(class, attName, primType, typeMultiplicity, oppAttName, className, setName, direction, tableName, isId)
values
('Product', 'MSRP', 'String', 'Mandatory', null, '', '', 'Uni', 'Product', 0)
;insert  
into
_Meta_Attributes
(class, attName, primType, typeMultiplicity, oppAttName, className, setName, direction, tableName, isId)
values
('Product', 'productLine', 'ClassRef', 'Mandatory', 'products', 'ProductLine', '', 'Bi', 'Product_productLine', 0)
;insert  
into
_Meta_Attributes
(class, attName, primType, typeMultiplicity, oppAttName, className, setName, direction, tableName, isId)
values
('Product', 'forPurchaseOrders', 'ClassRef', 'Set', 'product', 'PurchaseOrderDetails', '', 'Bi', 'Product_forPurchaseOrders', 0)
;insert  
into
_Meta_Classes
(className, tablename)
values
('PurchaseOrderDetails', 'PurchaseOrderDetails')
;insert  
into
_Meta_Attributes
(class, attName, primType, typeMultiplicity, oppAttName, className, setName, direction, tableName, isId)
values
('PurchaseOrderDetails', 'quantityOrdered', 'Integer', 'Mandatory', null, '', '', 'Uni', 'PurchaseOrderDetails', 1)
;insert  
into
_Meta_Attributes
(class, attName, primType, typeMultiplicity, oppAttName, className, setName, direction, tableName, isId)
values
('PurchaseOrderDetails', 'priceEach', 'String', 'Mandatory', null, '', '', 'Uni', 'PurchaseOrderDetails', 0)
;insert  
into
_Meta_Attributes
(class, attName, primType, typeMultiplicity, oppAttName, className, setName, direction, tableName, isId)
values
('PurchaseOrderDetails', 'orderLineNumber', 'Integer', 'Mandatory', null, '', '', 'Uni', 'PurchaseOrderDetails', 0)
;insert  
into
_Meta_Attributes
(class, attName, primType, typeMultiplicity, oppAttName, className, setName, direction, tableName, isId)
values
('PurchaseOrderDetails', 'purchaseOrder', 'ClassRef', 'Mandatory', 'details', 'PurchaseOrder', '', 'Bi', 'PurchaseOrderDetails_purchaseOrder', 0)
;insert  
into
_Meta_Attributes
(class, attName, primType, typeMultiplicity, oppAttName, className, setName, direction, tableName, isId)
values
('PurchaseOrderDetails', 'product', 'ClassRef', 'Mandatory', 'forPurchaseOrders', 'Product', '', 'Bi', 'PurchaseOrderDetails_product', 1)
;insert  
into
_Meta_Classes
(className, tablename)
values
('PurchaseOrder', 'PurchaseOrder')
;insert  
into
_Meta_Attributes
(class, attName, primType, typeMultiplicity, oppAttName, className, setName, direction, tableName, isId)
values
('PurchaseOrder', 'orderNumber', 'Integer', 'Mandatory', null, '', '', 'Uni', 'PurchaseOrder', 1)
;insert  
into
_Meta_Attributes
(class, attName, primType, typeMultiplicity, oppAttName, className, setName, direction, tableName, isId)
values
('PurchaseOrder', 'orderDate', 'String', 'Mandatory', null, '', '', 'Uni', 'PurchaseOrder', 1)
;insert  
into
_Meta_Attributes
(class, attName, primType, typeMultiplicity, oppAttName, className, setName, direction, tableName, isId)
values
('PurchaseOrder', 'requiredDate', 'String', 'Mandatory', null, '', '', 'Uni', 'PurchaseOrder', 0)
;insert  
into
_Meta_Attributes
(class, attName, primType, typeMultiplicity, oppAttName, className, setName, direction, tableName, isId)
values
('PurchaseOrder', 'shippedDate', 'String', 'Mandatory', null, '', '', 'Uni', 'PurchaseOrder', 0)
;insert  
into
_Meta_Attributes
(class, attName, primType, typeMultiplicity, oppAttName, className, setName, direction, tableName, isId)
values
('PurchaseOrder', 'status', 'String', 'Mandatory', null, '', '', 'Uni', 'PurchaseOrder', 0)
;insert  
into
_Meta_Attributes
(class, attName, primType, typeMultiplicity, oppAttName, className, setName, direction, tableName, isId)
values
('PurchaseOrder', 'comments', 'String', 'Mandatory', null, '', '', 'Uni', 'PurchaseOrder', 0)
;insert  
into
_Meta_Attributes
(class, attName, primType, typeMultiplicity, oppAttName, className, setName, direction, tableName, isId)
values
('PurchaseOrder', 'details', 'ClassRef', 'Set', 'purchaseOrder', 'PurchaseOrderDetails', '', 'Bi', 'PurchaseOrder_details', 0)
;insert  
into
_Meta_Attributes
(class, attName, primType, typeMultiplicity, oppAttName, className, setName, direction, tableName, isId)
values
('PurchaseOrder', 'customer', 'ClassRef', 'Mandatory', 'orders', 'Customer', '', 'Bi', 'PurchaseOrder_customer', 0)
;insert  
into
_Meta_Classes
(className, tablename)
values
('Customer', 'Customer')
;insert  
into
_Meta_Attributes
(class, attName, primType, typeMultiplicity, oppAttName, className, setName, direction, tableName, isId)
values
('Customer', 'customerNumber', 'Integer', 'Mandatory', null, '', '', 'Uni', 'Customer', 1)
;insert  
into
_Meta_Attributes
(class, attName, primType, typeMultiplicity, oppAttName, className, setName, direction, tableName, isId)
values
('Customer', 'customerName', 'String', 'Mandatory', null, '', '', 'Uni', 'Customer', 1)
;insert  
into
_Meta_Attributes
(class, attName, primType, typeMultiplicity, oppAttName, className, setName, direction, tableName, isId)
values
('Customer', 'contactLastName', 'String', 'Mandatory', null, '', '', 'Uni', 'Customer', 0)
;insert  
into
_Meta_Attributes
(class, attName, primType, typeMultiplicity, oppAttName, className, setName, direction, tableName, isId)
values
('Customer', 'contactFirstName', 'String', 'Mandatory', null, '', '', 'Uni', 'Customer', 0)
;insert  
into
_Meta_Attributes
(class, attName, primType, typeMultiplicity, oppAttName, className, setName, direction, tableName, isId)
values
('Customer', 'phone', 'String', 'Mandatory', null, '', '', 'Uni', 'Customer', 0)
;insert  
into
_Meta_Attributes
(class, attName, primType, typeMultiplicity, oppAttName, className, setName, direction, tableName, isId)
values
('Customer', 'addressLine1', 'String', 'Mandatory', null, '', '', 'Uni', 'Customer', 0)
;insert  
into
_Meta_Attributes
(class, attName, primType, typeMultiplicity, oppAttName, className, setName, direction, tableName, isId)
values
('Customer', 'addressLine2', 'String', 'Mandatory', null, '', '', 'Uni', 'Customer', 0)
;insert  
into
_Meta_Attributes
(class, attName, primType, typeMultiplicity, oppAttName, className, setName, direction, tableName, isId)
values
('Customer', 'city', 'String', 'Mandatory', null, '', '', 'Uni', 'Customer', 0)
;insert  
into
_Meta_Attributes
(class, attName, primType, typeMultiplicity, oppAttName, className, setName, direction, tableName, isId)
values
('Customer', 'state', 'String', 'Mandatory', null, '', '', 'Uni', 'Customer', 0)
;insert  
into
_Meta_Attributes
(class, attName, primType, typeMultiplicity, oppAttName, className, setName, direction, tableName, isId)
values
('Customer', 'postalCode', 'String', 'Mandatory', null, '', '', 'Uni', 'Customer', 0)
;insert  
into
_Meta_Attributes
(class, attName, primType, typeMultiplicity, oppAttName, className, setName, direction, tableName, isId)
values
('Customer', 'country', 'String', 'Mandatory', null, '', '', 'Uni', 'Customer', 0)
;insert  
into
_Meta_Attributes
(class, attName, primType, typeMultiplicity, oppAttName, className, setName, direction, tableName, isId)
values
('Customer', 'creditLimit', 'String', 'Mandatory', null, '', '', 'Uni', 'Customer', 0)
;insert  
into
_Meta_Attributes
(class, attName, primType, typeMultiplicity, oppAttName, className, setName, direction, tableName, isId)
values
('Customer', 'salesRepEmployee', 'ClassRef', 'Mandatory', 'salesRepFor', 'Employee', '', 'Bi', 'Customer_salesRepEmployee', 0)
;insert  
into
_Meta_Attributes
(class, attName, primType, typeMultiplicity, oppAttName, className, setName, direction, tableName, isId)
values
('Customer', 'orders', 'ClassRef', 'Set', 'customer', 'PurchaseOrder', '', 'Bi', 'Customer_orders', 0)
;insert  
into
_Meta_Attributes
(class, attName, primType, typeMultiplicity, oppAttName, className, setName, direction, tableName, isId)
values
('Customer', 'payments', 'ClassRef', 'Set', 'customer', 'Payment', '', 'Bi', 'Customer_payments', 0)
;insert  
into
_Meta_Classes
(className, tablename)
values
('Payment', 'Payment')
;insert  
into
_Meta_Attributes
(class, attName, primType, typeMultiplicity, oppAttName, className, setName, direction, tableName, isId)
values
('Payment', 'checkNumber', 'String', 'Mandatory', null, '', '', 'Uni', 'Payment', 1)
;insert  
into
_Meta_Attributes
(class, attName, primType, typeMultiplicity, oppAttName, className, setName, direction, tableName, isId)
values
('Payment', 'paymentDate', 'String', 'Mandatory', null, '', '', 'Uni', 'Payment', 0)
;insert  
into
_Meta_Attributes
(class, attName, primType, typeMultiplicity, oppAttName, className, setName, direction, tableName, isId)
values
('Payment', 'amount', 'String', 'Mandatory', null, '', '', 'Uni', 'Payment', 0)
;insert  
into
_Meta_Attributes
(class, attName, primType, typeMultiplicity, oppAttName, className, setName, direction, tableName, isId)
values
('Payment', 'customer', 'ClassRef', 'Mandatory', 'payments', 'Customer', '', 'Bi', 'Payment_customer', 1)
;insert  
into
_Meta_Classes
(className, tablename)
values
('Employee', 'Employee')
;insert  
into
_Meta_Attributes
(class, attName, primType, typeMultiplicity, oppAttName, className, setName, direction, tableName, isId)
values
('Employee', 'employeeNumber', 'Integer', 'Mandatory', null, '', '', 'Uni', 'Employee', 1)
;insert  
into
_Meta_Attributes
(class, attName, primType, typeMultiplicity, oppAttName, className, setName, direction, tableName, isId)
values
('Employee', 'lastName', 'String', 'Mandatory', null, '', '', 'Uni', 'Employee', 1)
;insert  
into
_Meta_Attributes
(class, attName, primType, typeMultiplicity, oppAttName, className, setName, direction, tableName, isId)
values
('Employee', 'firstName', 'String', 'Mandatory', null, '', '', 'Uni', 'Employee', 1)
;insert  
into
_Meta_Attributes
(class, attName, primType, typeMultiplicity, oppAttName, className, setName, direction, tableName, isId)
values
('Employee', 'extension', 'String', 'Mandatory', null, '', '', 'Uni', 'Employee', 0)
;insert  
into
_Meta_Attributes
(class, attName, primType, typeMultiplicity, oppAttName, className, setName, direction, tableName, isId)
values
('Employee', 'email', 'String', 'Mandatory', null, '', '', 'Uni', 'Employee', 0)
;insert  
into
_Meta_Attributes
(class, attName, primType, typeMultiplicity, oppAttName, className, setName, direction, tableName, isId)
values
('Employee', 'jobTitle', 'String', 'Mandatory', null, '', '', 'Uni', 'Employee', 0)
;insert  
into
_Meta_Attributes
(class, attName, primType, typeMultiplicity, oppAttName, className, setName, direction, tableName, isId)
values
('Employee', 'office', 'ClassRef', 'Mandatory', 'employees', 'Office', '', 'Bi', 'Employee_office', 0)
;insert  
into
_Meta_Attributes
(class, attName, primType, typeMultiplicity, oppAttName, className, setName, direction, tableName, isId)
values
('Employee', 'reportsTo', 'ClassRef', 'Optional', 'inChargeOf', 'Employee', '', 'Bi', 'Employee_reportsTo', 0)
;insert  
into
_Meta_Attributes
(class, attName, primType, typeMultiplicity, oppAttName, className, setName, direction, tableName, isId)
values
('Employee', 'inChargeOf', 'ClassRef', 'Set', 'reportsTo', 'Employee', '', 'Bi', 'Employee_inChargeOf', 0)
;insert  
into
_Meta_Attributes
(class, attName, primType, typeMultiplicity, oppAttName, className, setName, direction, tableName, isId)
values
('Employee', 'salesRepFor', 'ClassRef', 'Set', 'salesRepEmployee', 'Customer', '', 'Bi', 'Employee_salesRepFor', 0)
;insert  
into
_Meta_Classes
(className, tablename)
values
('Office', 'Office')
;insert  
into
_Meta_Attributes
(class, attName, primType, typeMultiplicity, oppAttName, className, setName, direction, tableName, isId)
values
('Office', 'officeCode', 'Integer', 'Mandatory', null, '', '', 'Uni', 'Office', 1)
;insert  
into
_Meta_Attributes
(class, attName, primType, typeMultiplicity, oppAttName, className, setName, direction, tableName, isId)
values
('Office', 'city', 'String', 'Mandatory', null, '', '', 'Uni', 'Office', 1)
;insert  
into
_Meta_Attributes
(class, attName, primType, typeMultiplicity, oppAttName, className, setName, direction, tableName, isId)
values
('Office', 'phone', 'String', 'Mandatory', null, '', '', 'Uni', 'Office', 0)
;insert  
into
_Meta_Attributes
(class, attName, primType, typeMultiplicity, oppAttName, className, setName, direction, tableName, isId)
values
('Office', 'addressLine1', 'String', 'Mandatory', null, '', '', 'Uni', 'Office', 0)
;insert  
into
_Meta_Attributes
(class, attName, primType, typeMultiplicity, oppAttName, className, setName, direction, tableName, isId)
values
('Office', 'addressLine2', 'String', 'Mandatory', null, '', '', 'Uni', 'Office', 0)
;insert  
into
_Meta_Attributes
(class, attName, primType, typeMultiplicity, oppAttName, className, setName, direction, tableName, isId)
values
('Office', 'state', 'String', 'Mandatory', null, '', '', 'Uni', 'Office', 0)
;insert  
into
_Meta_Attributes
(class, attName, primType, typeMultiplicity, oppAttName, className, setName, direction, tableName, isId)
values
('Office', 'country', 'String', 'Mandatory', null, '', '', 'Uni', 'Office', 0)
;insert  
into
_Meta_Attributes
(class, attName, primType, typeMultiplicity, oppAttName, className, setName, direction, tableName, isId)
values
('Office', 'postalCode', 'String', 'Mandatory', null, '', '', 'Uni', 'Office', 0)
;insert  
into
_Meta_Attributes
(class, attName, primType, typeMultiplicity, oppAttName, className, setName, direction, tableName, isId)
values
('Office', 'territory', 'String', 'Mandatory', null, '', '', 'Uni', 'Office', 0)
;insert  
into
_Meta_Attributes
(class, attName, primType, typeMultiplicity, oppAttName, className, setName, direction, tableName, isId)
values
('Office', 'employees', 'ClassRef', 'Set', 'office', 'Employee', '', 'Bi', 'Office_employees', 0)
;
SET @@GLOBAL.max_sp_recursion_depth = 255;
SET @@session.max_sp_recursion_depth = 255; 

DELIMITER $$

CREATE PROCEDURE `COUNT_ALL_RECORDS_BY_TABLE`()
BEGIN
DECLARE done INT DEFAULT 0;
DECLARE TNAME CHAR(255);

DECLARE table_names CURSOR for 
    SELECT tableName FROM _Meta_Classes;

DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

OPEN table_names;   

DROP TABLE IF EXISTS TCOUNTS;
CREATE TEMPORARY TABLE TCOUNTS 
  (
    TABLE_NAME CHAR(255),
    RECORD_COUNT INT,
	MIN_ID INT
  ) ENGINE = MEMORY; 


WHILE done = 0 DO

  FETCH NEXT FROM table_names INTO TNAME;

   IF done = 0 THEN
    SET @SQL_TXT = CONCAT("INSERT INTO TCOUNTS(SELECT '" , TNAME  , "' AS TABLE_NAME, COUNT(*) AS RECORD_COUNT, MIN(",TNAME,"Id) AS MIN_ID FROM ", TNAME, ")");

    PREPARE stmt_name FROM @SQL_TXT;
    EXECUTE stmt_name;
    DEALLOCATE PREPARE stmt_name;  
  END IF;

END WHILE;

CLOSE table_names;

SELECT * FROM TCOUNTS;

END
$$

CREATE PROCEDURE `GET_OBJECT_DESCRIPTION`( className_in VARCHAR(500), objectID INT, out objectDesc VARCHAR(100))
BEGIN

DROP TABLE IF EXISTS ATTRIBUTES_FOR_DESC;
CREATE TEMPORARY TABLE ATTRIBUTES_FOR_DESC 
  (
    ID INT PRIMARY KEY AUTO_INCREMENT,
	CALL_CLASS VARCHAR(500),
	CALL_OID INT,
    ATT_NAME VARCHAR(500),
    ATT_PRIM_TYPE VARCHAR(500),
    TYPE_MULT VARCHAR(500),
    INT_VALUE INT,
    STRING_VALUE VARCHAR(500),
    DATETIME_VALUE TIMESTAMP,
    SET_VALUE VARCHAR(500),
    OID_VALUE INT,
    CLASS_NAME VARCHAR(100)
  ) ENGINE = MEMORY; 

CALL `GET_OBJECT_DESCRIPTION_RECURSE`( className_in, objectID, objectDesc);

/*SELECT * FROM ATTRIBUTES_FOR_DESC; */
END
$$


DELIMITER $$

CREATE PROCEDURE `GET_OBJECT_DESCRIPTION_RECURSE`( className_in VARCHAR(500), objectID INT, out objectDesc VARCHAR(100))
BEGIN
DECLARE done INT DEFAULT 0;
DECLARE ANAME CHAR(255);

DECLARE attribute_names CURSOR for 
    SELECT attName FROM _Meta_Attributes WHERE class = className_in and isId = 1;

DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

OPEN attribute_names;   



WHILE done = 0 DO

  FETCH NEXT FROM attribute_names INTO ANAME;
  SET @SQL_TXT = null;
   IF done = 0 THEN
    SET @primType = (SELECT primType FROM _Meta_Attributes WHERE attName = ANAME AND class = className_in);
    SET @typeMult = (SELECT typeMultiplicity FROM _Meta_Attributes WHERE attName = ANAME AND class = className_in);
    SET @direction = (SELECT direction FROM _Meta_Attributes WHERE attName = ANAME AND class = className_in);
    SET @className = (SELECT _Meta_Attributes.className FROM _Meta_Attributes WHERE attName = ANAME AND class = className_in);
    SET @tableName = (SELECT _Meta_Attributes.tableName FROM _Meta_Attributes WHERE attName = ANAME AND class = className_in);
    SET @oppAttName = (SELECT _Meta_Attributes.oppAttName FROM _Meta_Attributes WHERE attName = ANAME AND class = className_in);
    
    IF @primType = 'String' and @typeMult != 'Set' THEN
        SET @SQL_TXT = CONCAT("INSERT INTO ATTRIBUTES_FOR_DESC 
                                    (CALL_CLASS, CALL_OID, ATT_NAME, ATT_PRIM_TYPE, TYPE_MULT, STRING_VALUE) 
                                    (SELECT '", className_in, "','",objectID,"','" , ANAME  , "' AS ATT_NAME, '",@primType,"' AS ATT_PRIM_TYPE, '",@typeMult,"' AS TYPE_MULT, ",ANAME," AS STRING_VALUE FROM ", @tableName," WHERE ",@tableName,"Id = ", objectID, ")");
    ELSEIF @primType = 'Integer' and @typeMult != 'Set' THEN
        SET @SQL_TXT = CONCAT("INSERT INTO ATTRIBUTES_FOR_DESC
                                    (CALL_CLASS, CALL_OID, ATT_NAME, ATT_PRIM_TYPE, TYPE_MULT, STRING_VALUE)
                                    (SELECT '", className_in, "','",objectID,"','" , ANAME  , "' AS ATT_NAME, '",@primType,"' AS ATT_PRIM_TYPE, '",@typeMult,"' AS TYPE_MULT, ",ANAME," AS STRING_VALUE FROM ", @tableName," WHERE ",@tableName,"Id = ", objectID, ")");
    ELSEIF @primType = 'DateTime' and @typeMult != 'Set' THEN
        SET @SQL_TXT = CONCAT("INSERT INTO ATTRIBUTES_FOR_DESC
                                    (CALL_CLASS, CALL_OID, ATT_NAME, ATT_PRIM_TYPE, TYPE_MULT, DATETIME_VALUE)
                                    (SELECT '", className_in, "','",objectID,"','" , ANAME  , "' AS ATT_NAME, '",@primType,"' AS ATT_PRIM_TYPE, '",@typeMult,"' AS TYPE_MULT, ",ANAME," AS DATETIME_VALUE FROM ", @tableName," WHERE ",@tableName,"Id = ", objectID, ")");
    ELSEIF @primType = 'SetValue' and @typeMult != 'Set' THEN
        SET @SQL_TXT = CONCAT("INSERT INTO ATTRIBUTES_FOR_DESC
                                    (CALL_CLASS, CALL_OID, ATT_NAME, ATT_PRIM_TYPE, TYPE_MULT, STRING_VALUE)
                                    (SELECT '", className_in, "','",objectID,"','" , ANAME  , "' AS ATT_NAME, '",@primType,"' AS ATT_PRIM_TYPE, '",@typeMult,"' AS TYPE_MULT, ",ANAME," AS STRING_VALUE FROM ", @tableName," WHERE ",@tableName,"Id = ", objectID, ")");
    ELSEIF @primType = 'ClassRef' and @typeMult != 'Set' and @direction = 'Uni' THEN
        SET @SQL_TXT = CONCAT("INSERT INTO ATTRIBUTES_FOR_DESC
                                    (CALL_CLASS, CALL_OID, ATT_NAME, ATT_PRIM_TYPE, TYPE_MULT, OID_VALUE, CLASS_NAME)
                                    (SELECT '", className_in, "','",objectID,"','" , ANAME  , "' AS ATT_NAME, '",@primType,"' AS ATT_PRIM_TYPE, '",@typeMult,"' AS TYPE_MULT, ",ANAME," AS OID_VALUE,'",@className,"' AS CLASS_NAME FROM ", @tableName," WHERE ",@tableName,"Id = ", objectID, ")");
    ELSEIF @primType = 'ClassRef' and @typeMult != 'Set' and @direction = 'Bi' THEN
        SET @SQL_TXT = CONCAT("INSERT INTO ATTRIBUTES_FOR_DESC
                                    (CALL_CLASS, CALL_OID, ATT_NAME, ATT_PRIM_TYPE, TYPE_MULT, OID_VALUE, CLASS_NAME)
                                    (SELECT '", className_in, "','",objectID,"','" , ANAME  , "' AS ATT_NAME, '",@primType,"' AS ATT_PRIM_TYPE, '",@typeMult,"' AS TYPE_MULT, ",@className,"_",@oppAttName," AS OID_VALUE,'",@className,"' AS CLASS_NAME FROM ", @tableName," WHERE ",@tableName,"Id = ", objectID, ")");

    

    END IF;

    IF(@SQL_TXT is not null ) THEN
        PREPARE stmt_name FROM @SQL_TXT;
        EXECUTE stmt_name;
        DEALLOCATE PREPARE stmt_name;
    END IF;
  END IF;

END WHILE;

CLOSE attribute_names;


BEGIN
DECLARE AID INT;
DECLARE OBJID INT;
DECLARE CNAME VARCHAR(500);

DECLARE attribute_values CURSOR for 
    SELECT ID, OID_VALUE, CLASS_NAME FROM ATTRIBUTES_FOR_DESC 
	WHERE OID_VALUE is not null
	AND CALL_CLASS = className_in
	AND CALL_OID = objectID;

SET done = 0;
OPEN attribute_values;  

WHILE done = 0 DO

  FETCH NEXT FROM attribute_values INTO AID, OBJID, CNAME;
   IF done = 0 THEN
    CALL `GET_OBJECT_DESCRIPTION_RECURSE`(CNAME, OBJID, @objDesc);
    UPDATE ATTRIBUTES_FOR_DESC SET STRING_VALUE = @objDesc WHERE ID = AID;
    
   END IF;

END WHILE;

CLOSE attribute_values;
END;

SET objectDesc = (SELECT group_concat(STRING_VALUE separator ', ') 
	FROM ATTRIBUTES_FOR_DESC 
	WHERE CALL_CLASS = className_in
	AND CALL_OID = objectID);

END
$$
DELIMITER $$

CREATE PROCEDURE `GET_OBJECT`( className_in VARCHAR(500), objectID INT)
BEGIN
DECLARE done INT DEFAULT 0;
DECLARE ANAME CHAR(255);


DECLARE attribute_names CURSOR for 
    SELECT attName FROM _Meta_Attributes WHERE class = className_in;


DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

OPEN attribute_names;   

DROP TABLE IF EXISTS ATTRIBUTES;
CREATE TEMPORARY TABLE ATTRIBUTES 
  (
    ID INT PRIMARY KEY AUTO_INCREMENT,
    ATT_NAME VARCHAR(500),
    ATT_PRIM_TYPE VARCHAR(500),
    TYPE_MULT VARCHAR(500),
    INT_VALUE INT,
    STRING_VALUE VARCHAR(500),
    DATETIME_VALUE TIMESTAMP,
    SET_VALUE VARCHAR(500),
    OID_VALUE INT,
    CLASS_NAME VARCHAR(100),
    OBJ_DESC VARCHAR(500)
  ) ENGINE = MEMORY; 


WHILE done = 0 DO

  FETCH NEXT FROM attribute_names INTO ANAME;
  SET @SQL_TXT = null;
   IF done = 0 THEN
    SET @primType = (SELECT primType FROM _Meta_Attributes WHERE attName = ANAME AND class = className_in);
    SET @typeMult = (SELECT typeMultiplicity FROM _Meta_Attributes WHERE attName = ANAME AND class = className_in);
    SET @direction = (SELECT direction FROM _Meta_Attributes WHERE attName = ANAME AND class = className_in);
    SET @className = (SELECT _Meta_Attributes.className FROM _Meta_Attributes WHERE attName = ANAME AND class = className_in);
    SET @oppAttName = (SELECT _Meta_Attributes.oppAttName FROM _Meta_Attributes WHERE attName = ANAME AND class = className_in);
    SET @tableName = (SELECT _Meta_Attributes.tableName FROM _Meta_Attributes WHERE attName = ANAME AND class = className_in);
    
    IF @primType = 'String' and @typeMult != 'Set' THEN
        SET @SQL_TXT = CONCAT("INSERT INTO ATTRIBUTES 
                                    (ATT_NAME, ATT_PRIM_TYPE, TYPE_MULT, STRING_VALUE) 
                                    (SELECT '" , ANAME  , "' AS ATT_NAME, '",@primType,"' AS ATT_PRIM_TYPE, '",@typeMult,"' AS TYPE_MULT, ",ANAME," AS STRING_VALUE FROM ", @tableName," WHERE ",@tableName,"Id = ", objectID, ")");
    ELSEIF @primType = 'Integer' and @typeMult != 'Set' THEN
        SET @SQL_TXT = CONCAT("INSERT INTO ATTRIBUTES
                                    (ATT_NAME, ATT_PRIM_TYPE, TYPE_MULT, INT_VALUE)
                                    (SELECT '" , ANAME  , "' AS ATT_NAME, '",@primType,"' AS ATT_PRIM_TYPE, '",@typeMult,"' AS TYPE_MULT, ",ANAME," AS INT_VALUE FROM ", @tableName," WHERE ",@tableName,"Id = ", objectID, ")");
    ELSEIF @primType = 'DateTime' and @typeMult != 'Set' THEN
        SET @SQL_TXT = CONCAT("INSERT INTO ATTRIBUTES
                                    (ATT_NAME, ATT_PRIM_TYPE, TYPE_MULT, DATETIME_VALUE)
                                    (SELECT '" , ANAME  , "' AS ATT_NAME, '",@primType,"' AS ATT_PRIM_TYPE, '",@typeMult,"' AS TYPE_MULT, ",ANAME," AS DATETIME_VALUE FROM ", @tableName," WHERE ",@tableName,"Id = ", objectID, ")");
    ELSEIF @primType = 'SetValue' and @typeMult != 'Set' THEN
        SET @SQL_TXT = CONCAT("INSERT INTO ATTRIBUTES
                                    (ATT_NAME, ATT_PRIM_TYPE, TYPE_MULT, SET_VALUE)
                                    (SELECT '" , ANAME  , "' AS ATT_NAME, '",@primType,"' AS ATT_PRIM_TYPE, '",@typeMult,"' AS TYPE_MULT, ",ANAME," AS SET_VALUE FROM ", @tableName," WHERE ",@tableName,"Id = ", objectID, ")");
    ELSEIF @primType = 'ClassRef' and @typeMult != 'Set' and @direction = 'Uni' THEN
        SET @SQL_TXT = CONCAT("INSERT INTO ATTRIBUTES
                                    (ATT_NAME, ATT_PRIM_TYPE, TYPE_MULT, OID_VALUE, CLASS_NAME)
                                    (SELECT '" , ANAME  , "' AS ATT_NAME, '",@primType,"' AS ATT_PRIM_TYPE, '",@typeMult,"' AS TYPE_MULT, ",ANAME," AS OID_VALUE,'",@className,"' AS CLASS_NAME FROM ", @tableName," WHERE ",@tableName,"Id = ", objectID, ")");
    ELSEIF @primType = 'ClassRef' and @typeMult != 'Set' and @direction = 'Bi' THEN
        SET @SQL_TXT = CONCAT("INSERT INTO ATTRIBUTES
                                    (ATT_NAME, ATT_PRIM_TYPE, TYPE_MULT, OID_VALUE, CLASS_NAME)
                                    (SELECT '" , ANAME  , "' AS ATT_NAME, '",@primType,"' AS ATT_PRIM_TYPE, '",@typeMult,"' AS TYPE_MULT, ",@className,"_",@oppAttName," AS OID_VALUE,'",@className,"' AS CLASS_NAME FROM ", @tableName," WHERE ",className_in,"_",ANAME," = ", objectID, ")");

    ELSEIF @primType = 'String' and @typeMult = 'Set' THEN
        SET @SQL_TXT = CONCAT("INSERT INTO ATTRIBUTES 
                                    (ATT_NAME, ATT_PRIM_TYPE, TYPE_MULT, STRING_VALUE) 
                                    (SELECT '" , ANAME  , "' AS ATT_NAME, '",@primType,"' AS ATT_PRIM_TYPE, '",@typeMult,"' AS TYPE_MULT, ",ANAME," AS STRING_VALUE FROM ", @tableName," WHERE ",className_in,"Id = ", objectID, ")");
    ELSEIF @primType = 'Integer' and @typeMult = 'Set' THEN
        SET @SQL_TXT = CONCAT("INSERT INTO ATTRIBUTES 
                                    (ATT_NAME, ATT_PRIM_TYPE, TYPE_MULT, INT_VALUE) 
                                    (SELECT '" , ANAME  , "' AS ATT_NAME, '",@primType,"' AS ATT_PRIM_TYPE, '",@typeMult,"' AS TYPE_MULT, ",ANAME," AS INT_VALUE FROM ", @tableName," WHERE ",className_in,"Id = ", objectID, ")");
    ELSEIF @primType = 'DateTime' and @typeMult = 'Set' THEN
        SET @SQL_TXT = CONCAT("INSERT INTO ATTRIBUTES 
                                    (ATT_NAME, ATT_PRIM_TYPE, TYPE_MULT, DATETIME_VALUE) 
                                    (SELECT '" , ANAME  , "' AS ATT_NAME, '",@primType,"' AS ATT_PRIM_TYPE, '",@typeMult,"' AS TYPE_MULT, ",ANAME," AS DATETIME_VALUE FROM ", @tableName," WHERE ",className_in,"Id = ", objectID, ")");

    ELSEIF @primType = 'SetValue' and @typeMult = 'Set' THEN
        SET @SQL_TXT = CONCAT("INSERT INTO ATTRIBUTES 
                                    (ATT_NAME, ATT_PRIM_TYPE, TYPE_MULT, SET_VALUE) 
                                    (SELECT '" , ANAME  , "' AS ATT_NAME, '",@primType,"' AS ATT_PRIM_TYPE, '",@typeMult,"' AS TYPE_MULT, ",ANAME," AS SET_VALUE FROM ", @tableName," WHERE ",className_in,"Id = ", objectID, ")");

   ELSEIF @primType = 'ClassRef' and @typeMult = 'Set' and @direction = 'Uni' THEN
        SET @SQL_TXT = CONCAT("INSERT INTO ATTRIBUTES
                                    (ATT_NAME, ATT_PRIM_TYPE, TYPE_MULT, OID_VALUE, CLASS_NAME)
                                    (SELECT '" , ANAME  , "' AS ATT_NAME, '",@primType,"' AS ATT_PRIM_TYPE, '",@typeMult,"' AS TYPE_MULT, ",ANAME," AS OID_VALUE,'",@className,"' AS CLASS_NAME FROM ", @tableName," WHERE ",className_in,"Id = ", objectID, ")");

    ELSEIF @primType = 'ClassRef' and @typeMult = 'Set' and @direction = 'Bi' THEN
        SET @SQL_TXT = CONCAT("INSERT INTO ATTRIBUTES
                                    (ATT_NAME, ATT_PRIM_TYPE, TYPE_MULT, OID_VALUE, CLASS_NAME)
                                    (SELECT '" , ANAME  , "' AS ATT_NAME, '",@primType,"' AS ATT_PRIM_TYPE, '",@typeMult,"' AS TYPE_MULT, ",@className,"_",@oppAttName," AS OID_VALUE,'",@className,"' AS CLASS_NAME FROM ", @tableName," WHERE ",className_in,"_",ANAME," = ", objectID, ")");
 


    END IF;

    IF(@SQL_TXT is not null ) THEN
        PREPARE stmt_name FROM @SQL_TXT;
        EXECUTE stmt_name;
        DEALLOCATE PREPARE stmt_name;
    END IF;
  END IF;

END WHILE;

CLOSE attribute_names;


BEGIN
DECLARE AID INT;
DECLARE OBJID INT;
DECLARE CNAME VARCHAR(500);

DECLARE attribute_values CURSOR for 
    SELECT ID, OID_VALUE, CLASS_NAME FROM ATTRIBUTES WHERE OID_VALUE is not null;

SET done = 0;
OPEN attribute_values;  

WHILE done = 0 DO

  FETCH NEXT FROM attribute_values INTO AID, OBJID, CNAME;
   IF done = 0 THEN
    CALL `GET_OBJECT_DESCRIPTION`(CNAME, OBJID, @objDesc);
    UPDATE ATTRIBUTES SET OBJ_DESC = @objDesc WHERE ID = AID;
    
   END IF;

END WHILE;

CLOSE attribute_values;

SELECT * FROM ATTRIBUTES;
		
				END;
				
				END
				$$

			
CREATE PROCEDURE `GET_OBJECT_METHOD_NAMES` ( className_in VARCHAR(500))
	BEGIN
    SELECT * FROM _Meta_Methods WHERE class = className_in AND isObjectMethod = true;
  END;
$$

CREATE PROCEDURE `GET_CLASS_METHOD_NAMES` ( className_in VARCHAR(500))
	BEGIN
    SELECT * FROM _Meta_Methods WHERE class = className_in AND isObjectMethod = false;
  END;
$$

CREATE PROCEDURE `METHOD_PARAMS` ( className_in VARCHAR(500),  methodName_in VARCHAR(500))
	BEGIN
    SELECT * FROM _Meta_Method_Params WHERE class = className_in and methodName = methodName_in;
  END;
$$

DELIMITER ;
drop procedure if exists `GET_OBJECT_BROWSE_LOCATION`;
DELIMITER $$
CREATE PROCEDURE `GET_OBJECT_BROWSE_LOCATION` ( className_in VARCHAR(500), Id_in INT)
	BEGIN
		
		SET @tableName = (SELECT tableName FROM _Meta_Classes WHERE className = className_in);  
		SET @idName = CONCAT(@tableName, "ID");
		
		SET @SQL_TXT = CONCAT("select ", 
				"(select min(",@idName,") from ",@tableName," where ",@idName," > ", Id_in, ") as next,", 
				"(select max(",@idName,") from ",@tableName," where ",@idName," < ", Id_in, ") as prev,",
				"(select min(",@idName,") from ",@tableName,") as first,",
				"(select max(",@idName,") from ",@tableName,") as last"); 
    	
		IF(@SQL_TXT is not null ) THEN
        	PREPARE stmt_name FROM @SQL_TXT;
        	EXECUTE stmt_name;
        	DEALLOCATE PREPARE stmt_name;
    	END IF;
  	END;
 $$

DELIMITER ;

DROP PROCEDURE IF EXISTS `GET_OBJECT_DESCRIPTION_AS_TABLE`;

DELIMITER $$

CREATE PROCEDURE `GET_OBJECT_DESCRIPTION_AS_TABLE`( className_in VARCHAR(500), orderBy_in VARCHAR(255), direction_in VARCHAR(10), start_in INT, limit_in INT, searchTerm_in VARCHAR(100), out total_out INT)
BEGIN
DECLARE thisTableName CHAR(255);
DECLARE idField CHAR(255);
if orderBy_in is null or orderBy_in = '' then
begin
	set orderBy_in = 'ID';
end;
end if;
set @thisTableName = (select tableName from _Meta_Classes where className = className_in);
set @idField = CONCAT(@thisTableName, 'Id');


DROP TABLE IF EXISTS ATTRIBUTES_FOR_DESC;
CREATE TEMPORARY TABLE ATTRIBUTES_FOR_DESC 
  (
    ID INT PRIMARY KEY AUTO_INCREMENT,
	CALL_CLASS VARCHAR(500),
	CALL_OID INT,
    ATT_NAME VARCHAR(500),
    ATT_PRIM_TYPE VARCHAR(500),
    TYPE_MULT VARCHAR(500),
    INT_VALUE INT,
    STRING_VALUE VARCHAR(500),
    SET_VALUE VARCHAR(500),
    OID_VALUE INT,
    CLASS_NAME VARCHAR(100)
  ) ENGINE = MEMORY; 

BEGIN


DROP TABLE IF EXISTS OBJECT_IDS;
CREATE TEMPORARY TABLE OBJECT_IDS 
  (
    ID INT PRIMARY KEY 
  );

SET @SQL_TEXT = CONCAT('INSERT INTO `OBJECT_IDS` SELECT ', @idField, ' FROM ', @thisTableName, '');

PREPARE stmt_name FROM @SQL_TEXT;
EXECUTE stmt_name;
DEALLOCATE PREPARE stmt_name; 


/*SELECT * FROM OBJECT_IDS;*/


/*DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1; */
	

END;


BEGIN
DECLARE done INT DEFAULT 0;
DECLARE OID INT ;

DECLARE object_ids CURSOR for 
    SELECT ID FROM OBJECT_IDS ;

DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;


OPEN object_ids;   

WHILE done = 0 DO
	FETCH NEXT FROM object_ids INTO OID;
		IF done = 0 THEN
			SET @SQL_TEXT = CONCAT('CALL `GET_OBJECT_DESCRIPTION_RECURSE`( \'', className_in, '\',', OID, ',@objectDesc)');
			PREPARE stmt_name5 FROM @SQL_TEXT;
			EXECUTE stmt_name5;
			DEALLOCATE PREPARE stmt_name5; 
		END IF;
END WHILE;

END;
/*SELECT * FROM ATTRIBUTES_FOR_DESC;
SELECT DISTINCT ATT_NAME, ATT_PRIM_TYPE FROM ATTRIBUTES_FOR_DESC WHERE CALL_CLASS = className_in; */

BEGIN

DECLARE done INT DEFAULT 0;
DECLARE ANAME CHAR(255);
DECLARE APT CHAR(20);

DECLARE WHERE_CLAUSE TEXT;


DECLARE attribute_names CURSOR for 
    SELECT DISTINCT ATT_NAME, ATT_PRIM_TYPE FROM ATTRIBUTES_FOR_DESC WHERE CALL_CLASS = className_in;

DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

OPEN attribute_names;   
SET @WHERE_CLAUSE = '';

WHILE done = 0 DO
	FETCH NEXT FROM attribute_names INTO ANAME, APT;
		IF done = 0 THEN
			IF(APT = 'String') THEN
				SET @SQL_TEXT1 = CONCAT('ALTER TABLE `OBJECT_IDS` ADD COLUMN `',ANAME, '` VARCHAR(1000);');
			ELSEIF(APT = 'Integer') THEN
				SET @SQL_TEXT1 = CONCAT('ALTER TABLE `OBJECT_IDS` ADD COLUMN `',ANAME, '` INT;');
			END IF;
			/* SELECT @SQL_TEXT1; */
			
			IF(@SQL_TEXT1 is not null ) THEN
				PREPARE stmt_name6 FROM @SQL_TEXT1;
				EXECUTE stmt_name6;
				DEALLOCATE PREPARE stmt_name6; 
				
			END IF;
			SET @WHERE_CLAUSE = CONCAT(@WHERE_CLAUSE, 'OR CAST(', ANAME, ' AS CHAR) LIKE "%', searchTerm_in, '%" ');
		END IF; 
END WHILE;
END;


BEGIN

DECLARE done INT DEFAULT 0;
DECLARE ANAME CHAR(255);
DECLARE OID INT;
DECLARE APT CHAR(20);
DECLARE STRV CHAR(255);
DECLARE INTV INT;

DECLARE attribute_rows CURSOR for 
    SELECT CALL_OID, ATT_NAME, ATT_PRIM_TYPE, INT_VALUE, STRING_VALUE
  FROM ATTRIBUTES_FOR_DESC WHERE CALL_CLASS = className_in;

DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

OPEN attribute_rows;   

/*SELECT * FROM ATTRIBUTES_FOR_DESC;*/
WHILE done = 0 DO
	FETCH NEXT FROM attribute_rows INTO OID, ANAME, APT, INTV, STRV;
		IF done = 0 THEN
		/*SELECT ANAME; */		

		SET @SQL_TEXT2 = null;
			SET @SQL_TEXT2 = CONCAT('INSERT INTO `OBJECT_IDS` (ID, ',ANAME,' ) VALUES (?,?) ON DUPLICATE KEY UPDATE ',ANAME,' = ?');
			/*SET @SQL_TEXT2 = CONCAT('INSERT INTO `OBJECT_IDS` (ID, ',ANAME, ') VALUES (',OID, ',', STRV, ') ON DUPLICATE KEY UPDATE ', ANAME, ' = ', STRV); */
		IF(@SQL_TEXT2 is not null ) THEN
			PREPARE stmt_name FROM @SQL_TEXT2;
			SET @OIDV = OID;
			SET @STRVV = STRV;
			EXECUTE stmt_name USING @OIDV, @STRVV, @STRVV;
			DEALLOCATE PREPARE stmt_name; 
		END IF; 
	END IF;
END WHILE;

CLOSE attribute_rows;
END;

SET @SQL_RESULT1 = CONCAT('SELECT * FROM OBJECT_IDS ',
							'WHERE false ', @WHERE_CLAUSE,
							'ORDER BY ', orderBy_in, ' ', direction_in, ' LIMIT ', start_in, ', ', limit_in, 
							';');
SET @SQL_RESULT2 = CONCAT('SELECT COUNT(*) INTO @total_rows FROM OBJECT_IDS ', 
							'WHERE false ', @WHERE_CLAUSE,
							';');

PREPARE stmt_result FROM @SQL_RESULT1;
EXECUTE stmt_result;
DEALLOCATE PREPARE stmt_result; 

PREPARE stmt_result FROM @SQL_RESULT2;
EXECUTE stmt_result;
DEALLOCATE PREPARE stmt_result; 

/* SELECT @WHERE_CLAUSE; */
SET total_out = @total_rows ;
/*SELECT * FROM ATTRIBUTES_FOR_DESC; */
END
$$

DELIMITER ;

DELIMITER ;
DROP PROCEDURE IF EXISTS `GET_NO_OBJECTS_FOR_CLASS` ;
DELIMITER $$
CREATE PROCEDURE `GET_NO_OBJECTS_FOR_CLASS`( className_in VARCHAR(100), out recordCount_out INT)
BEGIN
DECLARE done INT DEFAULT 0;


SELECT tableName INTO @TNAME FROM _Meta_Classes where className = className_in;

SET @SQL_TXT = CONCAT("SELECT COUNT(*) INTO @rc FROM ", @TNAME);

PREPARE stmt_name FROM @SQL_TXT;
EXECUTE stmt_name;
DEALLOCATE PREPARE stmt_name; 
SET recordCount_out = @rc;
END
$$

DELIMITER ;

DROP PROCEDURE IF EXISTS `GET_OBJECT_DESCRIPTION_ATTRIBUTES`;
DELIMITER $$

CREATE PROCEDURE `GET_OBJECT_DESCRIPTION_ATTRIBUTES`( className_in VARCHAR(500))
BEGIN
    SELECT * FROM _Meta_Attributes WHERE class = className_in and isId = 1;
END 
$$

DELIMITER ;
DROP PROCEDURE IF EXISTS `GET_SET_VALUES`;
DELIMITER $$

CREATE PROCEDURE `GET_SET_VALUES`( setName_in VARCHAR(500))
BEGIN
	DECLARE setTableName TEXT; 
	DECLARE setColumnName TEXT; 
    SELECT tableName, columnName  into @setTableName, @setColumnName 
		FROM _Meta_Sets WHERE setName = setName_in;

	SET @SQL_TXT = CONCAT('SELECT ',  @setColumnName, ' from ', @setTableName);
	PREPARE stmt_name FROM @SQL_TXT;
	EXECUTE stmt_name;
	DEALLOCATE PREPARE stmt_name; 
END 
$$

DELIMITER ;
DROP PROCEDURE IF EXISTS `GET_CLASS_VALUES`;
DELIMITER $$

CREATE PROCEDURE `GET_CLASS_VALUES`( className_in VARCHAR(500))
BEGIN

DECLARE classTableName TEXT; 



DROP TABLE IF EXISTS CLASS_DESCS;
CREATE TEMPORARY TABLE CLASS_DESCS 
  (
    OBJECT_ID INT PRIMARY KEY,
	DESCRIPTION VARCHAR(500)
  ) ENGINE = MEMORY; 


	SELECT tableName  into @classTableName 
		FROM _Meta_Classes WHERE className = className_in;

	SET @SQL_TXT = CONCAT('INSERT INTO CLASS_DESCS (OBJECT_ID)  SELECT ',  @classTableName, 'Id from ', @classTableName, ';');
	PREPARE stmt_name FROM @SQL_TXT;
	EXECUTE stmt_name;
	DEALLOCATE PREPARE stmt_name; 

BEGIN
	DECLARE done INT DEFAULT 0;
	DECLARE OID INT;

	DECLARE object_ids CURSOR for 
		SELECT OBJECT_ID FROM CLASS_DESCS;


	DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

	OPEN object_ids;   



	WHILE done = 0 DO
		FETCH NEXT FROM object_ids INTO OID;
		IF done = 0 THEN
			CALL `GET_OBJECT_DESCRIPTION`(className_in, OID, @objDesc);
			UPDATE CLASS_DESCS SET DESCRIPTION = @objDesc WHERE OBJECT_ID = OID;    
		END IF;

	END WHILE;
END;

	SELECT * FROM CLASS_DESCS;
END 
$$
DELIMITER ;
