-- SQL | Project: Regression --

-- 1. Create a database called house_price_regression.

create database if not exists house_price_regression;

use house_price_regression;


-- 2. Create a table house_price_data with the same columns as given in the csv file. Please make sure you use the correct data types for the columns.

drop table if exists house_price_data;

create table house_price_data (
	`id` bigint not null,
    `date` text,
    `bedrooms` int,
    `bathrooms` decimal,
    `sqft_living` int,
    `sqft_lot` int,
    `floors` decimal,
    `waterfront` int,
    `view` int,
    `condition` int,
    `grade` int,
    `sqft_above` int,
    `sqft_basement` int,
    `yr_built` int,
    `yr_renovated` int,
    `zipcode` int,
    `lat` float,
    `long` float,
    `sqft_living15` int,
    `sqft_lot15` int,
    `price` int
    );

select * from house_price_data;
    
-- 3. Import the data from the csv file into the table. 

SHOW VARIABLES LIKE 'local_infile';
SET GLOBAL local_infile = 1;

load data local infile 'C:/Users/josefin/01_IRONHACK/Week5/data_mid_bootcamp_project_regression/regression_data.csv'
into table house_price_data
fields terminated BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
	(`id`,`date`,`bedrooms`,`bathrooms`,`sqft_living`,`sqft_lot`,`floors`,`waterfront`,`view`,`condition`,`grade`,
    `sqft_above`,`sqft_basement`,`yr_built`,`yr_renovated`,`zipcode`,`lat`,`long`,`sqft_living15`,`sqft_lot15`,`price`);


-- 4. Select all the data from table house_price_data to check if the data was imported correctly.

select * from house_price_data;

    
-- 5. Use the alter table command to drop the column date from the database, as we would not use it in the analysis with SQL. 
	-- Select all the data from the table to verify if the command worked. Limit your returned results to 10.

alter table house_price_data
drop column date;

select * from house_price_data
limit 10;


-- 6. Use sql query to find how many rows of data you have.

select * from house_price_data;
#we have 21597 rows in total

    
-- 7. Now we will try to find the unique values in some of the categorical columns:
	
-- What are the unique values in the column bedrooms?
select distinct(bedrooms) from house_price_data
order by bedrooms;

select distinct(bedrooms), count(id) as nr_of_properties
from house_price_data
group by bedrooms
order by bedrooms;
# 33 seems like a lot of bedrooms; need to check later for typo or consider to drop

-- What are the unique values in the column bathrooms?
select distinct(bathrooms) from house_price_data
order by bathrooms;

select distinct(bathrooms), count(id) as nr_of_properties
from house_price_data
group by bathrooms
order by bathrooms;

-- What are the unique values in the column floors?
select distinct(floors) from house_price_data
order by floors;

select distinct(floors), count(id) as nr_of_properties
from house_price_data
group by floors
order by floors;

-- What are the unique values in the column condition?
select distinct(`condition`) from house_price_data
order by `condition`;

select distinct(`condition`), count(id) as nr_of_properties, round(avg(price), 0) as average_price
from house_price_data
group by `condition`
order by `condition`;

-- What are the unique values in the column grade?
select distinct(grade) from house_price_data
order by grade;

select distinct(grade), count(id) as nr_of_properties, round(avg(price), 0) as average_price
from house_price_data
group by grade
order by grade;

select * from house_price_data
where grade <= 3 or grade = 13
order by price;


-- 8. Arrange the data in a decreasing order by the price of the house. Return only the IDs of the top 10 most expensive houses in your data.

select id, price from house_price_data
order by price desc
limit 10;


-- 9. What is the average price of all the properties in your data?

select round(avg(price),0) as average_price from house_price_data;


-- 10. In this exercise we will use simple group by to check the properties of some of the categorical variables in our data.
	
-- What is the average price of the houses grouped by bedrooms? The returned result should have only two columns, bedrooms and Average of the prices. Use an alias to change the name of the second column.
select distinct(bedrooms), round(avg(price),0) as average_price from house_price_data
group by bedrooms
order by bedrooms;

-- What is the average sqft_living of the houses grouped by bedrooms? The returned result should have only two columns, bedrooms and Average of the sqft_living. Use an alias to change the name of the second column.
select bedrooms, round(avg(sqft_living),0) as average_sqft_living from house_price_data
group by bedrooms
order by bedrooms;
    
-- What is the average price of the houses with a waterfront and without a waterfront? The returned result should have only two columns, waterfront and Average of the prices. Use an alias to change the name of the second column.
select waterfront, round(avg(price),0) as average_price from house_price_data
group by waterfront
order by waterfront;

-- Is there any correlation between the columns condition and grade? You can analyse this by grouping the data by one of the variables and then aggregating the results of the other column. Visually check if there is a positive correlation or negative correlation or no correlation between the variables.
select `condition`, avg(grade) as average_grade 
from house_price_data
group by `condition`
order by `condition` asc;

select grade, avg(`condition`) as average_condition
from house_price_data
group by grade
order by grade asc; 
# there seems to be no correlation between the condition and the grade


-- 11. One of the customers is only interested in the following houses:
        
-- Number of bedrooms either 3 or 4
-- Bathrooms more than 3
-- One Floor
-- No waterfront
-- Condition should be 3 at least
-- Grade should be 5 at least
-- Price less than 300000
-- For the rest of the things, they are not too concerned. 

-- Write a simple query to find what are the options available for them?

select * from house_price_data
where bedrooms in (3, 4) 
#where (bedrooms = 3 or bedrooms = 4)
	and bathrooms > 3 
    and floors = 1 
    and waterfront = 0 
    and `condition` >= 3 
    and grade >= 5 
    and price < 300000;
    
#no option available in our offer with their demands


-- 12. Your manager wants to find out the list of properties whose prices are twice more than the average of all the properties in the database. 
	-- Write a query to show them the list of such properties. You might need to use a sub query for this problem.

select id, price from house_price_data
where price > (select (avg(price) * 2) from house_price_data)
order by price asc;


-- 13. Since this is something that the senior management is regularly interested in, create a view of the same query.

create view pricy_houses as 
	(select id, price from house_price_data
	where price > (select (avg(price) * 2) from house_price_data));

select * from pricy_houses;


-- 14. Most customers are interested in properties with three or four bedrooms. What is the difference in average prices of the properties with three and four bedrooms?

select round((avg(b.price) - avg(a.price)),2) as difference_avg_price
from house_price_data as a
cross join house_price_data as b
where a.bedrooms = 3
and b.bedrooms = 4
group by b.bedrooms;


-- 15. What are the different locations where properties are available in your database? (distinct zip codes)

select distinct(zipcode) as district from house_price_data;
#there are 70 different zipcodes where properties are available


-- 16. Show the list of all the properties that were renovated.

select id from house_price_data
where yr_renovated != 0;


-- 17. Provide the details of the property that is the 11th most expensive property in your database.

select * from (select *, rank() over (order by price desc) as ranking from house_price_data) as ranking_table
where ranking = 11;
