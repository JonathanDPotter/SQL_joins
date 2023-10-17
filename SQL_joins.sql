USE bestbuy;
/* joins: select all the computers from the products table:
using the products table and the categories table, return the product name and the category name */
SELECT p.Name AS ProductName, c.Name AS Category
FROM products AS p
INNER JOIN categories AS c 
ON p.CategoryID = c.CategoryID
WHERE c.Name = "Computers";

/* joins: find all product names, product prices, and products ratings that have a rating of 5 */
SELECT p.Name, p.Price, r.Rating
FROM products AS p
INNER JOIN reviews AS r
ON p.ProductID = r.ProductID
WHERE r.Rating = 5;

/* joins: find the employee with the most total quantity sold.  use the sum() function and group by */
SELECT e.EmployeeID, concat(e.FirstName, " ", e.LastName) as Name, sum(s.Quantity) AS TotalQuantity 
FROM employees AS e
INNER JOIN sales AS s
ON e.EmployeeID = s.EmployeeID
GROUP BY s.EmployeeID
HAVING TotalQuantity = (SELECT sum(sales.Quantity) AS Total From sales GROUP BY sales.EmployeeID ORDER BY Total DESC LIMIT 1);

/* joins: find the name of the department, and the name of the category for Appliances and Games */
SELECT c.Name AS Category, d.Name AS Department
FROM categories as c
INNER JOIN departments as d
ON c.DepartmentID = d.DepartmentID
HAVING c.Name = "Appliances" OR c.Name = "Games" ;

/* joins: find the product name, total # sold, and total price sold,
 for Eagles: Hotel California --You may need to use SUM() */
 SELECT p.Name, sum(s.Quantity) AS TotalQuantity, sum(s.Quantity * s.PricePerUnit) AS TotalPriceSold
 FROM products AS p
 INNER JOIN sales AS s
 ON p.ProductID = s.ProductID
 GROUP BY s.ProductID
 HAVING p.Name = "Eagles: Hotel California";

/* joins: find Product name, reviewer name, rating, and comment on the Visio TV. (only return for the lowest rating!) */
SELECT p.name, r.Reviewer, r.Rating, r.Comment
FROM reviews AS r 
INNER JOIN products AS p  
ON p.ProductID = r.ProductID
WHERE p.name = "Visio TV"
ORDER BY r.Rating
LIMIT 1;

-- ------------------------------------------ Extra - May be difficult

/* Your goal is to write a query that serves as an employee sales report.
This query should return the employeeID, the employee's first and last name, the name of each product, how many of that product they sold */
SELECT employees.EmployeeID, CONCAT(employees.FirstName, " ", employees.LastName) AS Name, group_concat(products.Name, " x", sales.Quantity ORDER BY products.Name ASC SEPARATOR ", ") as Sales
FROM sales
INNER JOIN products
ON sales.ProductID = products.ProductID
INNER JOIN employees-- 
ON sales.EmployeeID = employees.EmployeeID
GROUP BY employees.EmployeeID
ORDER BY employees.LastName;