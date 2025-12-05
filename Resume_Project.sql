CREATE DATABASE Resume_Project
USE Resume_Project

SELECT * FROM [dbo].[Books]
SELECT * FROM [dbo].[Customers]
SELECT * FROM[dbo].[Orders]

--1.Retrieve all books in the "Fiction" genre

SELECT * FROM Books
WHERE Genre ='Fiction'

--2.Find books published after the year 1950
SELECT * FROM Books
WHERE Published_Year >=1950
--3.List all customers from the Canada
SELECT * FROM Customers
WHERE Country= 'Canada'
--4.Show orders placed in November 2023
      WITH  Orders_placed   AS   (SELECT *,
	                              FORMAT(Order_Date ,'MMMM') AS Month_Name,
								  YEAR(Order_Date) AS year_
                                  FROM Orders ) 
           
		    SELECT * FROM Orders_placed 
			WHERE Month_Name ='November' AND  year_ ='2023'
--5. Retrieve the total stock of books available
   SELECT SUM (Stock) AS books_available FROM Books
--6  Find the details of the most expensive book
        SELECT  TOP 1 * FROM Books
		ORDER BY Price DESC
---7 Show all customers who ordered more than 1 quantity of a book

           SELECT * FROM Orders
           WHERE Quantity>1
---8  Retrieve all orders where the total amount exceeds $20
            SELECT * FROM Orders
           WHERE Total_Amount >20;
---9 List all genres available in the Books table
          SELECT DISTINCT Genre FROM Books
----10. Find the book with the lowest stock
              SELECT * FROM Books
			  ORDER BY Stock ASC
--11) Calculate the total revenue generated from all orders
                  SELECT ROUND(SUM(Total_Amount),2) AS total_revenue FROM Orders
--12. Retrieve the total number of books sold for each genre
                      SELECT  SUM(Quantity) AS total_number_Books_sold,Genre
					  FROM Orders AS O
					        JOIN Books AS B
							ON O.Book_ID = B.Book_ID
							GROUP BY Genre
 ---13) Find the average price of books in the "Fantasy" genre      
           SELECT AVG(price) AS average_price
		    FROM Books
			WHERE Genre ='Fantasy'
---14.List customers who have placed at least 2 orders	

          SELECT Customer_id,COUNT(Order_id)  AS least_Orders
		  FROM Orders
		  GROUP BY Customer_id
		  HAVING COUNT(Order_id) >=2
---15) Find the most frequently ordered book

   WITH most_Order AS (SELECT Title,
                          DENSE_RANK () OVER(ORDER BY COUNT(Order_id) DESC) AS frequently
		               FROM Orders AS O
                          JOIN Books AS B
					       ON O.Book_ID = B.Book_ID
		                  GROUP BY Title)
         SELECT Title
		 FROM most_Order
		 WHERE frequently ='1'
		
---16) Show the top 3 most expensive books of 'Fantasy' Genre
               SELECT TOP 3
			   * FROM Books
			   WHERE Genre='Fantasy'
			   ORDER BY Price DESC
---17) Retrieve the total quantity of books sold by each author
             SELECT B.Author,SUM(O.Quantity) AS Total_Book_sold
			 FROM Orders AS O
			     JOIN Books AS B
				 ON O.Book_ID =B.Book_ID
				 GROUP BY B.Author
---18) List the cities where customers who spent over $30 are located
                  SELECT Name,ROUND(SUM(Total_Amount),2)AS Total_Spent
				  FROM Orders AS O
				  JOIN Customers AS C
				  ON O.Customer_ID = C.Customer_ID
				  GROUP BY Name
				  HAVING SUM(Total_Amount)>30
--19 Find the customer who spent the most on orders
 SELECT TOP 1 Name,ROUND(SUM(Total_Amount),2)AS Total_Spent
				  FROM Orders AS O
				  JOIN Customers AS C
				  ON O.Customer_ID = C.Customer_ID
				  GROUP BY Name
				 ORDER BY SUM(Total_Amount) DESC  
--20) Calculate the stock remaining after fulfilling all orders
 
   
	      SELECT   DISTINCT  B.Book_ID,B.Stock, SUM(O.Quantity) AS Total_Order,
				(B.Stock - SUM(O.Quantity)) AS remaining
			  FROM Books AS B
			  JOIN Orders AS O
			  ON B.Book_ID =O.Book_ID
			  GROUP BY B.Book_ID,B.Stock
			  HAVING B.Stock - SUM(O.Quantity) <0




SELECT * FROM [dbo].[Books]
SELECT * FROM [dbo].[Customers]
SELECT * FROM[dbo].[Orders]

