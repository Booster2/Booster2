
insert into ClassicCars.Office (officeCode, city, phone, addressLine1, addressLine2, state, country, postalCode, territory)

select * from classicmodels.offices;


insert into Employee (employeeNumber, lastName, firstName, extension, email, jobTitle)
select employeeNumber, lastName, firstName, extension, email, jobTitle from classicmodels.employees
;

insert into Employee_office (Employee_office, Office_employees)
select EmployeeID, OfficeID from classicmodels.employees
inner join Employee on Employee.employeeNumber = employees.employeeNumber
inner join Office on Office.officeCode = employees.officeCode
;

insert into Office_employees (Employee_office, Office_employees)
select EmployeeID, OfficeID from classicmodels.employees
inner join Employee on Employee.employeeNumber = employees.employeeNumber
inner join Office on Office.officeCode = employees.officeCode
;


insert into Employee_reportsTo (Employee_reportsTo, Employee_inChargeOf)
select e1.EmployeeID, e2.EmployeeID from classicmodels.employees
inner join Employee as e1 on e1.employeeNumber = employees.employeeNumber
inner join Employee as e2 on e2.employeeNumber = employees.reportsTo
;

insert into Employee_inChargeOf (Employee_reportsTo, Employee_inChargeOf)
select e1.EmployeeID, e2.EmployeeID from classicmodels.employees
inner join Employee as e1 on e1.employeeNumber = employees.employeeNumber
inner join Employee as e2 on e2.employeeNumber = employees.reportsTo
;


insert into ProductLine (productLine, textDescription, htmldescription, image)

select productLine, substring(textDescription,1,500), convert(htmldescription,char(500)), convert(image , char(500)) from classicmodels.productlines
;


insert into Product (productCode, productName, productScale, productVendor, productDescription, quantityInStock, buyPrice, MSRP)
select productCode, productName, productScale, productVendor, productDescription, quantityInStock, buyPrice, MSRP from classicmodels.products
;

insert into ProductLine_products (ProductLine_products, Product_productLine)
select ProductLineId, ProductId from classicmodels.products
inner join Product on Product.ProductCode = products.productCode
inner join ProductLine on ProductLine.productLine = products.productLine
;

insert into Product_productLine (ProductLine_products, Product_productLine)
select ProductLineId, ProductId from classicmodels.products
inner join Product on Product.ProductCode = products.productCode
inner join ProductLine on ProductLine.productLine = products.productLine
;

insert into Customer (customerNumber, customerName, contactLastName, contactFirstName, phone, addressLine1, addressLine2, city, state, postalCode, country, creditLimit)
select customerNumber, customerName, contactLastName, contactFirstName, phone, addressLine1, addressLine2, city, state, postalCode, country, creditLimit from classicmodels.customers
;

insert into Customer_salesRepEmployee
(Customer_salesRepEmployee, Employee_salesRepFor)
select CustomerId, EmployeeId from classicmodels.customers 
inner join Customer on Customer.customerNumber = customers.customerNumber
inner join Employee on Employee.employeeNumber = customers.salesRepEmployeeNumber
;

insert into Employee_salesRepFor
(Customer_salesRepEmployee, Employee_salesRepFor)
select CustomerId, EmployeeId from classicmodels.customers 
inner join Customer on Customer.customerNumber = customers.customerNumber
inner join Employee on Employee.employeeNumber = customers.salesRepEmployeeNumber
;

insert into Payment (checkNumber, paymentDate, amount)
select checkNumber, paymentDate, amount from classicmodels.payments
;

insert into Customer_payments
(Customer_payments, payment_customer)
select CustomerId, PaymentId from classicmodels.payments
inner join Customer on Customer.customerNumber = payments.customerNumber
inner join Payment on Payment.checkNumber = payments.checkNumber

;

insert into Payment_customer
(Customer_payments, payment_customer)
select CustomerId, PaymentId from classicmodels.payments
inner join Customer on Customer.customerNumber = payments.customerNumber
inner join Payment on Payment.checkNumber = payments.checkNumber

;

insert into PurchaseOrder (orderNumber, orderDate, requiredDate, shippedDate, status, comments)
select orderNumber, orderDate, requiredDate, shippedDate, status, comments from classicmodels.orders
;

insert into PurchaseOrder_customer
(PurchaseOrder_customer, Customer_orders)
select PurchaseOrderId, CustomerId from classicmodels.orders
inner join PurchaseOrder on orders.orderNumber = PurchaseOrder.orderNumber
inner join Customer on Customer.customerNumber = orders.customerNumber
;

insert into Customer_orders
(PurchaseOrder_customer, Customer_orders)
select PurchaseOrderId, CustomerId from classicmodels.orders
inner join PurchaseOrder on orders.orderNumber = PurchaseOrder.orderNumber
inner join Customer on Customer.customerNumber = orders.customerNumber
;

alter table PurchaseOrderDetails
	add column import_key varchar(500);

insert into PurchaseOrderDetails (quantityOrdered, priceEach, orderLineNumber, import_key)
select quantityOrdered, priceEach, orderLineNumber, concat(orderNumber," ",orderLineNumber)

from classicmodels.orderdetails
;

insert into PurchaseOrderDetails_purchaseOrder
(PurchaseOrderDetails_purchaseOrder,PurchaseOrder_details)
(select PurchaseOrderDetailsId, PurchaseOrderId from classicmodels.orderdetails
inner join PurchaseOrderDetails on import_key = concat(orderNumber," ",orderdetails.orderLineNumber)
inner join PurchaseOrder on PurchaseOrder.orderNumber = orderdetails.orderNumber)
;

insert into PurchaseOrder_details
(PurchaseOrderDetails_purchaseOrder,PurchaseOrder_details)
(select PurchaseOrderDetailsId, PurchaseOrderId from classicmodels.orderdetails
inner join PurchaseOrderDetails on import_key = concat(orderNumber," ",orderdetails.orderLineNumber)
inner join PurchaseOrder on PurchaseOrder.orderNumber = orderdetails.orderNumber)
;

insert into Product_forPurchaseOrders
(Product_forPurchaseOrders,PurchaseOrderDetails_product)
(select ProductId, PurchaseOrderDetailsId from classicmodels.orderdetails
inner join PurchaseOrderDetails on import_key = concat(orderNumber," ",orderdetails.orderLineNumber)
inner join Product on Product.productCode = orderdetails.productCode)
;
insert into PurchaseOrderDetails_product
(Product_forPurchaseOrders,PurchaseOrderDetails_product)
(select ProductId, PurchaseOrderDetailsId from classicmodels.orderdetails
inner join PurchaseOrderDetails on import_key = concat(orderNumber," ",orderdetails.orderLineNumber)
inner join Product on Product.productCode = orderdetails.productCode)
;
alter table PurchaseOrderDetails
	drop import_key ;
