-- 1

SELECT 
    o.orderid     AS 'numero do pedido', 
    o.orderdate   AS 'data do pedido',
    c.contactname AS 'nome do contato',
    c.country     AS 'pais'
FROM Sales.Orders o
INNER JOIN Sales.Customers c ON o.custid = c.custid;

-- 2

SELECT
    o.orderdate                    AS 'data do pedido',
    c.contactname                  AS 'nome do contato',
    e.firstname + ' ' + e.lastname AS 'nome completo do empregado',
    e.country                      AS 'país do empregado'
FROM Sales.Orders o
INNER JOIN Sales.Customers c ON o.custid = c.custid
INNER JOIN HR.Employees e ON o.empid = e.empid
WHERE e.country = 'UK';

-- 3

SELECT
    o.orderid                      AS 'numero do pedido', 
    o.orderdate                    AS 'data do pedido',
    c.contactname                  AS 'nome do contato',
    e.firstname + ' ' + e.lastname AS 'nome completo do empregado',
    c.country                      AS 'país do cliente'
FROM Sales.Orders o
INNER JOIN Sales.Customers c ON o.custid = c.custid
INNER JOIN HR.Employees e ON o.empid = e.empid
WHERE c.country = 'Brazil' ORDER BY o.orderdate DESC;

-- 4

SELECT
    o.orderid                      AS 'numero do pedido', 
    o.orderdate                    AS 'data do pedido',
    c.contactname                  AS 'nome do contato',
    e.firstname + ' ' + e.lastname AS 'nome completo do empregado',
    e.country                      AS 'país do empregado',
    s.companyname                  AS 'nome da empresa de entrega'
FROM Sales.Orders o
INNER JOIN Sales.Customers c ON o.custid = c.custid
INNER JOIN HR.Employees e ON o.empid = e.empid
INNER JOIN Sales.Shippers s ON o.shipperid = s.shipperid
WHERE e.country = 'USA' AND s.companyname in ('Shipper ETYNR', 'Shipper GVSUA') ORDER BY o.orderid;

-- 5

SELECT 
    p.*,
    ca.categoryname AS 'nome da categoria'
FROM Production.Products p
INNER JOIN Production.Categories ca ON p.categoryid = ca.categoryid
WHERE ca.categoryname = 'Beverages' AND p.unitprice < 30 ORDER BY p.unitprice DESC


-- 6

SELECT 
    p.productname AS 'nome do produto',
    s.companyname AS 'nome da empresa de entrega',
    od.qty        AS 'quantidade de produtos'
FROM Sales.Orders o
INNER JOIN Sales.Shippers s ON o.shipperid = s.shipperid
INNER JOIN Sales.OrderDetails od ON o.orderid = od.orderid
INNER JOIN Production.Products p ON od.productid = p.productid
WHERE od.qty > 100 ORDER BY p.productname ASC, od.qty DESC

-- 7

SELECT 
    c.contactname AS 'nome do contato do cliente',
    p.productname AS 'nome do produto',
    od.qty        AS 'quantidade de produtos',
    o.orderdate   AS 'data do pedido',
    su.city       AS 'cidade do fornecedor'
FROM Sales.Orders o
INNER JOIN Sales.Customers c ON o.custid = c.custid
INNER JOIN Sales.OrderDetails od ON o.orderid = od.orderid
INNER JOIN Production.Products p ON od.productid = p.productid
INNER JOIN Production.Suppliers su ON p.supplierid = su.supplierid
WHERE o.orderdate BETWEEN '2006-07-01' AND '2006-07-31' AND od.qty BETWEEN 20 AND 59
    AND (p.productname LIKE 'Product A%' OR p.productname LIKE 'Product G%')
    AND su.city IN ('Stockholm', 'Sydney', 'Sandvika', 'Ravenna')
ORDER BY o.empid