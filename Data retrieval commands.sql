/*

"some common examples of BASIC Cleaning Data in SQL Queries"

*/
--*Remove irrelevant data(if we want to deal only with the customer database in the US )
SELECT * 
FROM customers 
WHERE country = 'USA';
------------------------------------
--*to not show any duplicated data
SELECT DISTINCT * 
FROM customers;
------------------------------------
--*to handle missing data/NULL values
/*if you want to display all the NOT NULL values of "state"*/
SELECT * 
FROM customers 
WHERE State IS NOT NULL;

/*if you want to replace all the NULL values of "Fax" with "0"instead*/
SELECT CustomerId, FirstName, LastName,
IFNULL(Fax, 0) AS Fax_updated
FROM customers
----------------------------------
/* to create the column name while displaying as we wish */
SELECT
    FirstName AS customer_firstname,
	LastName  AS customer_lastname
FROM customers;

----------------------------------------------------------------------------------
/* to select the specific piece of data we need*/
SELECT *
FROM customers
WHERE CustomerId = 8;
-----------------
SELECT FirstName,LastName
FROM customers
WHERE CustomerId=8;
---------------------
SELECT *
FROM customers
WHERE Country='Canada';
-------------------------
SELECT *
FROM customers
WHERE Country='Canada' AND State='ON';
----------------------
SELECT *
FROM customers
WHERE Country='Canada' or Country='USA' 
;
----------------------
/*resulting in descending order: use"DESC"(Max to Min numbers) 
WHILE it will be ascending order by default(ASCD) 
AND to limit the amount of data given we use: "LIMIT" followed by the amount number of data we need
*/
SELECT *
FROM customers
WHERE Country='Canada' or Country='USA' 
ORDER by CustomerId DESC;
LIMIT 14;
---------------------------
/* to get the data of first and last name with address of the customer ID=4 */
SELECT FirstName, LastName, Address
FROM customers
WHERE CustomerId = 4 ;
------------------------
/* to get the data of first and last name with address of the customer in Paris AND London*/
SELECT FirstName, LastName, Address
FROM customers
WHERE City = 'Paris' OR City = 'London' ;
---------------------------
/* to get the data of first 10 customers in the ID order*/
SELECT *
FROM customers
 LIMIT 10;
--------------------
/* to insert data into the database table*/
INSERT INTO customers(FirstName,LastName,Email)
VALUES("Zumo","Chareon","Zumo54956@hotmail.com");
-----------------------
/*to update the data in the database table
--***BE CAREFUL, and be SURE TO SET "WHERE" of "THE ID of the changes to happen" FIRST*** 
--*otherwise the whole selected column of data set would be updated too*/
UPDATE customers
SET FirstName="Zumo'NEW'Name"
    ,LastName="NEWchareon"
WHERE CustomerId = 61;
-------------------------------
/* to delete the data(the whole row), be careful too*/
DELETE FROM customers
WHERE CustomerId = 61;
-----------------
/* to show "all the names of customers" in the chosen city*/
SELECT FirstName
FROM customers
WHERE City='Paris';
-------------
/* to show "ONLY the number of customers" in the chosen city*/
SELECT COUNT(FirstName)
FROM customers
WHERE City='Paris';
-------------------
/* To find the average of the invoices from the customer spends*/
SELECT AVG(total)
FROM(invoices);
------------------
/* To find the SUMATION of the invoices from the customer spends*/
SELECT SUM(total)
FROM(invoices);
----------------------
/* To find the MAX and MIN values of the invoices from the customer spends*/
SELECT MAX(total), MIN(total)
FROM(invoices);
------------------------
/* to find "the number of customers by Country" or type of data we want,
AND set the column name "TEMPORARILY" while displaying as we want, like Quantity(no. of customers) using "AS" 
we use"GROUP BY" to classify the data
IF we want to show only the QuantiTy of customers > and = 5, we cannot use WHERE here
(WHERE is not functioning with the aggregate function, BUT we can use"HAVING" instead and it does the same thing)
(HAVING: USE WITH AGGREGATE FX, and used after "GROUP BY")
and order it by the max to min values of quantity*/
SELECT COUNT(CustomerId) AS Quantity , Country
FROM customers
GROUP BY Country
HAVING Quantity >= 5
ORDER BY Quantity DESC;
-------------------------
/* to find the average price of the tracks*/
SELECT AVG (UnitPrice)
FROM tracks;
-------------------------
/* to find the average, MAX, MIN time of the tracks*/
SELECT AVG (Milliseconds),
       MAX(Milliseconds), 
	   MIN(Milliseconds)
FROM tracks;
-------------------------------------------
/* to find the average, MAX, MIN time "IN SECONDS"of the tracks
--:AGGREGATE FX is used to calculate math stuff anyways, so we can do math directly in queries***
*/
SELECT AVG (Milliseconds)/1000 AS average_in_Seconds,
       MAX(Milliseconds)/1000 AS maximum_in_Seconds, 
	   MIN(Milliseconds)/1000 AS minimum_in_Seconds
FROM tracks;
-------------------------------------------------------------
/* to find the average, MAX, MIN time "IN MINUTES"of the tracks*/
SELECT AVG (Milliseconds)/(1000*60) AS average_in_Minutes,
       MAX(Milliseconds)/(1000*60) AS maximum_in_Minutes,
	   MIN(Milliseconds)/(1000*60) AS minimum_in_Minutes
FROM tracks;
--------------------------------------------------------------
/*GROUP BY ALBUM_ID AND order it from "max to min time length of the tracks"*/
SELECT AlbumId,
      AVG (Milliseconds)/(1000*60) AS average_in_Minutes,
       MAX(Milliseconds)/(1000*60) AS maximum_in_Minutes,
	   MIN(Milliseconds)/(1000*60) AS minimum_in_Minutes,
	   SUM(Milliseconds)/(1000*60) AS total_in_Minutes
FROM tracks
GROUP BY AlbumId
ORDER BY total_in_Minutes DESC;
----------------------------------------------------------------
/*we want to select every position EXCEPT IT Staff*/
SELECT * FROM employees
WHERE NOT Title = 'IT Staff';
------------------------------------
/* we want to select all the employees in ONLY SOME SPECIFIC positions we are looking for*/
SELECT * FROM employees
WHERE 
    Title IN ('Sales Support Agent',
	         'Sales Manager',
			 'General Manager')
----------------------------------------------------
SELECT * FROM customers
WHERE 
    Country IN('Brazil',
	         'USA',
			 'Sweden')
----------------------------------------
/*we want to select every customer list "EXCEPT USA  and BRAZIL and Sweden" */
SELECT * FROM customers
WHERE 
   NOT Country IN ('Brazil',
	               'USA',
			       'Sweden')
---------------------------------------
/*OR LIKE THIS*/
SELECT * FROM customers
WHERE 
   NOT Country NOT IN ('Brazil',
	                   'USA',
			           'Sweden')
----------------------------------------


/*TO FIND SMTH WE WANT BUT NOT SEXACTLY SURE WHAT IT IS OR HOW TO SPELL OR TYPE IT CORRCTLY
 we can USE "LIKE a%b"*/
/*we want to search for customer's firstname that ends with "a"*/
SELECT * FROM customers
WHERE 
    FirstName LIKE "%a"
	----------------------------------------
/*we want to search for customer's firstname that begins with "b"*/
SELECT * FROM customers
WHERE 
    FirstName LIKE "b%"
------------------------------------------
/*we want to search for customer's firstname that contains the letter "b" in their firstnames*/
SELECT * FROM customers
WHERE 
    FirstName LIKE "%b%"
------------------------------------------
/*we want to search for customer's firstname that contains the letter "b" in their firstnames 
and ends with the letter "t"*/
SELECT * FROM customers
WHERE 
    FirstName LIKE "%b%t"
------------------------------------
/*we want to search for customer's firstname that begins with the letter "r" in their firstnames 
and ends with the letter "t"*/
SELECT * FROM customers
WHERE 
    FirstName LIKE "r%t"
-----------------------------------
/*we want to find the customer's ID from ID no. 11-34*/
SELECT * FROM customers
WHERE 
    CustomerId > 10 AND CustomerId < 35
-----------------------------------------------------
/*OR to find the customer's ID from ID no. 10-35*/
SELECT * FROM customers
WHERE 
    CustomerId >= 10 AND CustomerId <= 35
----------------------------------------------
/*THE EASIEST FORM COULD USE "BETWEEN...AND..."*/
SELECT * FROM customers
WHERE 
    CustomerId BETWEEN 10 AND 35
-------------------------------------------
/*WE WANT ALL BUT NOT ID no. 10-35*/
SELECT * FROM customers
WHERE 
    CustomerId NOT BETWEEN 10 AND 35
-------------------------------------------
/*ex want to find the customer ID between 1-30 that live in Brazil and Czech Republic*/
SELECT * FROM customers
WHERE 
    CustomerId BETWEEN 1 and 30
	and Country in  ('Brazil','Czech Republic')
--------------------------------------------------
/*WANT TO KNOW WHO DID NOT PROVIDE THEIR PHONE NUMBERS, Wwe use "IS NULL" to check the blank data*/
SELECT * FROM customers
WHERE 
   Phone IS NULL;
-----------------------------
/*to check all the customer's phone numbers*/
SELECT * FROM customers
WHERE 
   Phone IS NOT NULL;
--------------------------------------
/* to find the customers that HAVE "BOTH" conditions*/
SELECT * FROM customers
WHERE 
   Country = "Brazil" AND State = "SP";
-------------------------------------------------
/* to find the customers that HAVE "ANY" of the conditions*/
SELECT * FROM customers
WHERE 
   Country = "Brazil" OR State = "SP";
--------------------------------------------
/*To get the customers from all the countries EXCEPT USA AND CANADA*/
SELECT * FROM customers
WHERE 
   NOT Country = "USA" AND NOT Country = "Canada";
----------------------------------------------------
/*OR LIKE THIS IS BETTER*/
SELECT * FROM customers
WHERE 
   NOT (Country = "USA" OR Country = "Canada");
-------------------------------------------------------


/*to JOIN DATA  from both tables*/
SELECT * 
FROM invoices
INNER JOIN customers
ON invoices.CustomerId = customers.CustomerId
ORDER BY InvoiceId ASC;
------------------------------------------------
SELECT InvoiceId, FirstName, LastName 
FROM invoices
INNER JOIN customers
ON invoices.CustomerId = customers.CustomerId
ORDER BY InvoiceId ASC;
--------------------------------------------
/*if you are afraid that there will be duplicates of first and last names in another tables too,
 use this form! to be safe, to select specific pieces of data  from specific tables that you need*/
SELECT invoices.InvoiceId, customers.FirstName, customers.LastName, invoices.Total
FROM invoices
INNER JOIN customers
--we join on the column that has the same name!, this case is "CustomerId"*/
ON invoices.CustomerId = customers.CustomerId
ORDER BY InvoiceId ASC;
-------------------------------------------------------------------------------------------
/*to show the list of all the employees with the supervisors of each person 
including the boss(has no supervisor)*/
SELECT employees.EmployeeId, 
       employees.FirstName,
	   employees.LastName,
	   employees.Title,
	   employers.FirstName AS Employer_FirstName,
	   employers.LastName AS Employer_LastName
FROM employees
LEFT JOIN employees AS employers
--*if we want the list of the employees "ONLY", we use "INNER JOIN" instead!
ON employees.ReportsTo = employers.EmployeeId;
-------------------------------------------------------
/*WANT TO CREATE THE CONDITIONS TO DISPLAY SMTH IF THE CONDITION MATCHES*/
/*we use "CASE" AFTER SELECT to create the conditions we  and display the message we want after "THEN"*/
SELECT InvoiceId, total,
  CASE
    WHEN total >= 10 THEN "AAA"
    WHEN total < 10 THEN "AA"
    ELSE "NONE"
   END AS RESULT
FROM invoices
LIMIT 100;
------------------------------------------------------
/*To classify the customer ranking AAA, AA and A grades*/
SELECT InvoiceId, total,
  CASE
    WHEN total > 10 THEN "AAA"
	WHEN total BETWEEN 5 AND 10 THEN "AA"
    WHEN total < 5 THEN "A"
    ELSE "NONE"
   END AS RESULT
FROM invoices
ORDER BY total DESC
------------------------------------------------
/*to show only distinct lit of ID without duplicates in the dataset, we use :"DISTINCT" right after "SELECT"*/
SELECT 
    DISTINCT CustomerId
FROM customers;
------------------------------
/*we can make sure that all country codes have the same length, using "LENGTH" or "LEN"(it does the same thing)
or in case we want to know how many letters there are in the country column*/
SELECT 
    LENGTH(Country) AS letters_in_country
FROM customers;
----------------------------------------------
/*if we want to check and know what are they countries or data that have the different formats, we can do this
i.e., to check "what are the countries having the country letters more than 10?"*/
--*AS A MATTER OF FACT, WE SHOULD KEEP ALL THE FORMAT OF DATA to be the same, 
--*i.e., if the country codes have 2 letters, 
--*then the format of the rest of the countries in the column should be 2 too!
--*(but if we do not create this table, we should not update it!!**)
SELECT 
    Country
FROM customers
WHERE LENGTH(Country) > 10
--------------------------------------------------
/*to show only the DISTINCT list(NO DUPLICATES) of people in the country "US" that contains only 2 letters
(the letter to start with = 1st letter so=1, and pull only 2 total letters from the 1st, so we put 2 later
>> WHERE SUBSTR(Country,1,2) = 'US' )*/
SELECT 
    DISTINCT CustomerId
FROM customers
WHERE SUBSTR(Country,1,2) = 'US'
----------------------------------------------
/*TO GET RID OF SPACEBAR OR EXTRA SPACES IN THE DATA, we use "TRIM" with the specific piece of data we want to fix
i.e., we found that the state name OH has more than 2 letters> so it must be an extra space after an H, 
so we use the below command to fix it*/
SELECT 
    DISTINCT CustomerId
FROM customers
WHERE TRIM(State) = 'OH'
----------------------------------------------------
/*to convert a text string into the form we want to analyze it correctly, we use "CAST"
i.e., this case we convert a text string into the float!*/
SELECT 
    CAST(CustomerId AS FLOAT64)
FROM customers
ORDER BY 
    CAST(CustomerId AS FLOAT64) DESC;
---------------------------------------------------------
/*if the format of the date contains both date and time tgt and we want "only DATE" NOT "date-time"
we can use CAST to fix it too as below*/
SELECT 
    CAST(DateInTable AS Date) AS DATE_ONLY
FROM customers
WHERE date between '2022-12-01' AND '2022-12-31';
---------------------------------------------------
/*we can use "CONCAT" to create the unique name temporarily(of the column name of the results) 
and give the results*/
SELECT CONCAT(product_code,product_color) AS new_product_code
FROM customers
WHERE product = 'couch'
--*cuz we can check the frequency of each couch type sales with what colors?**
--------------------------------------------------------------------------
/*we return non-null values in the list using: "COALESCE()"*/
--*TO CHECK WHAT COLUMNS ARE NULL or not?
SELECT 
--*COALESCE(COLUMN(S) YOU WANT TO CHECK)
    COALESCE(product, product_code) AS Product_info()/*>we can name it as we wish here(Product_info)*/
FROM customers;
---------------------------------------------------------------------------------------------
--*TO find a year on year/month on month increase on sales
--*to know the person particularly sitting behind the class or
--*to identify the rank of particular person in the class of 20 students
--*we use LAG/ LEAD/ ROW NUMBER/ RANK/ DENSE RANK: 5 POWERFUL WINDOW FUNCTIONS
-------------------------------------------------------------------------------------
--*Assume we have a table named "employees" with columns "name", "department", and "salary". 
/*Window Functions:
Purpose: Perform calculations over a specific window of data.*/
SELECT name, department, salary, AVG(salary) OVER (PARTITION BY department) AS avg_salary
FROM employees;
| name | department | salary | avg_salary |
|------|------------|--------|------------|
| John | HR         | 50000  | 52500      |
| Jane | IT         | 60000  | 62500      |
| Mary | HR         | 55000  | 52500      |
| Mark | IT         | 65000  | 62500      |

-----------------------------------------------------------------------------------------------
/*Stored Procedures (SP):
Purpose: A stored procedure is a named set of SQL statements that can be executed with a single call.*/
CREATE PROCEDURE sp_get_high_salary_employees(@min_salary INT)
AS
BEGIN
    SELECT name, department, salary
    FROM employees
    WHERE salary > @min_salary;
END;
--*USAGE
EXEC sp_get_high_salary_employees 50000;
/*we get the output as below*/
| name | department | salary |
|------|------------|--------|
| Jane | IT         | 60000  |
| Mark | IT         | 65000  |

------------------------------------------------------
/*Common Table Expressions (CTE):
Purpose: "Temporary named result sets" to simplify complex queries.
--*Assume we have a table named "employees" with columns "name", "department", and "salary".
--*We want to use a CTE to get employees with a "salary greater than 50000".*/
WITH cte AS (
    SELECT col1, col2 FROM table_name WHERE condition
)
SELECT * FROM cte;
/*OR*/

WITH high_salary_employees AS (
    SELECT name, department, salary
    FROM employees
    WHERE salary > 50000
)
SELECT name, department, salary
FROM high_salary_employees;

/*we get the output as below*/
| name | department | salary |
|------|------------|--------|
| Jane | IT         | 60000  |
| Mark | IT         | 65000  |

------------------------------------------------------------------------
/*PIVOT:
Purpose: PIVOT operator rotates rows into columns, aggregate data, and summarize results.*/
SELECT *
FROM sales
PIVOT (SUM(amount) FOR month IN ([Jan], [Feb], [Mar]));

| Product | Jan | Feb | Mar |
|---------|-----|-----|-----|
| A       | 100 | 150 | 200 |
| B       | 120 | 180 | 250 |

-------------------------------------------------------------
/*Triggers:
Purpose: Automatic execution of SQL statements on events (e.g., INSERT, UPDATE, DELETE).
--*Assume we have a table named audit_log to keep track of changes to the employees table using a trigger.*/

CREATE TRIGGER tr_example
ON table_name
AFTER INSERT
AS
BEGIN
    -- Trigger logic here
END;

/*OR*/

CREATE TRIGGER tr_audit_employee_changes
ON employees
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    DECLARE @action NVARCHAR(10);
    SET @action = CASE
                    WHEN EXISTS(SELECT * FROM inserted) AND EXISTS(SELECT * FROM deleted) THEN 'UPDATE'
                    WHEN EXISTS(SELECT * FROM inserted) THEN 'INSERT'
                    ELSE 'DELETE'
                  END;

    INSERT INTO audit_log (action, employee_id, change_date)
    SELECT @action, id, GETDATE()
    FROM inserted;

    -- For DELETE action, we also need to log the details of the deleted record
    IF @action = 'DELETE'
    BEGIN
        INSERT INTO audit_log (action, employee_id, change_date)
        SELECT 'DELETED', id, GETDATE()
        FROM deleted;
    END;
END;

---------------------------------------
/*INSERT and UPDATE:
Purpose: Insert new rows into a table or update existing rows.*/
INSERT INTO table_name (col1, col2) VALUES (value1, value2);

UPDATE table_name
SET col1 = new_value1, col2 = new_value2
WHERE condition;
---------------------------------------------------------------------
/*MERGE:
Assume we have two tables "employees" and "employees_updates". 
We want to merge the data from "employees_updates" into "employees" based on the "id" column.*/
MERGE INTO employees AS target
USING employees_updates AS source
ON target.id = source.id
WHEN MATCHED THEN
    UPDATE SET target.name = source.name, target.salary = source.salary
WHEN NOT MATCHED THEN
    INSERT (id, name, department, salary) VALUES (source.id, source.name, source.department, source.salary);
--------------------------------------------------------------------
/*LAG:
Purpose: Access data from a previous row within the result set.*/
SELECT ID, Sales, LAG(Sales) OVER (ORDER BY Date) AS PrevSales
FROM sales;
+------+-------+----------+
|  ID  | Sales | PrevSales|
+------+-------+----------+
|  1   |  100  |   NULL   |
|  2   |  150  |   100    |
|  3   |  120  |   150    |
|  4   |  180  |   120    |
+------+-------+----------+

------------------------------------------------------------------------
/*LEAD:
Purpose: Access data from a subsequent row within the result set.*/
SELECT ID, Sales, LEAD(Sales) OVER (ORDER BY Date) AS NextSales
FROM sales;
+------+-------+----------+
|  ID  | Sales | NextSales|
+------+-------+----------+
|  1   |  100  |   150    |
|  2   |  150  |   120    |
|  3   |  120  |   180    |
|  4   |  180  |   NULL   |
+------+-------+----------+

-------------------------------------------------------------------------
/*ROW_NUMBER:
Purpose: Assign a unique number to each row in the result set.*/
SELECT ID, Sales, ROW_NUMBER() OVER (ORDER BY Date) AS RowNum
FROM sales;
+------+-------+--------+
|  ID  | Sales | RowNum |
+------+-------+--------+
|  1   |  100  |   1    |
|  2   |  150  |   2    |
|  3   |  120  |   3    |
|  4   |  180  |   4    |
+------+-------+--------+

------------------------------------------------------------------
/*RANK:
Purpose: Assign a unique rank to each row with gaps for ties (e.g., 1, 2, 2, 4).*/
SELECT ID, Sales, RANK() OVER (ORDER BY Sales) AS SalesRank
FROM sales;
+------+-------+----------+
|  ID  | Sales | SalesRank|
+------+-------+----------+
|  1   |  100  |    1     |
|  3   |  120  |    2     |
|  2   |  150  |    3     |
|  4   |  180  |    4     |
+------+-------+----------+

---------------
/*DENSE_RANK:
Purpose: Assign a unique rank to each row without gaps for ties (e.g., 1, 2, 2, 3).*/
SELECT ID, Sales, DENSE_RANK() OVER (ORDER BY Sales) AS DenseSalesRank
FROM sales;
+------+-------+--------------+
|  ID  | Sales | DenseSalesRank|
+------+-------+--------------+
|  1   |  100  |      1       |
|  3   |  120  |      2       |
|  2   |  150  |      3       |
|  4   |  180  |      4       |
+------+-------+--------------+
------------------------
 /*to create a new table named "students" in a database*/
CREATE TABLE students (
    id INT PRIMARY KEY,
    name VARCHAR(50),
    age INT
);
---------------------------------------------


