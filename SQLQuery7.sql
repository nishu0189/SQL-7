

------------------------------------------QUESTIONS---------------------------------------------------------------------------
--DROP table icc_world_cup

create table icc_world_cup(
team_1 Varchar(20),
team_2 Varchar(20),
winner Varchar(20) 
);

INSERT INTO icc_world_cup values('India','SL','India');
INSERT INTO icc_world_cup values('SL','Aus','Aus');
INSERT INTO icc_world_cup values('SA','Eng','Eng');
INSERT INTO icc_world_cup values('Eng','NZ','NZ');
INSERT INTO icc_world_cup values('Aus','India','India'); 

/* 1- write a query to produce below output from icc_world_cup table.
team_name, no_of_matches_played , no_of_wins , no_of_losses */

select * from icc_world_cup ;

Select winner, Team_1 from  icc_world_cup
UNION 
Select winner, Team_2 from  icc_world_cup

Select  Team_1, winner,
case when team_1 = winner then 1 else 0 end as win_flag
from  icc_world_cup
UNION ALL
Select Team_2 , winner,
case when team_2 = winner then 1 else 0 end as win
from  icc_world_cup
;


/* 2- write a query to print first name and last name of a customer using orders table(everything after first space can be considered as last name)
customer_name, first_name, last_name*/







--Run below script to create drivers table:

create table drivers(id varchar(10), start_time time, end_time time, start_loc varchar(10), end_loc varchar(10));
insert into drivers 
values('dri_1', '09:00', '09:30', 'a','b'), 
('dri_1', '09:30', '10:30', 'b','c'), 
('dri_1','11:00','11:30', 'd','e'),
('dri_1', '12:00', '12:30', 'f', 'g'),
('dri_1', '13:30', '14:30', 'c','h'),
('dri_2', '12:15', '12:30', 'f','g' ), 
('dri_2', '13:30', '14:30', 'c' , 'h');

/*
3- write a query to print below output using drivers table.
Profit rides are the no of rides where end location of a ride is same as start location of immediately of next ride
id, total_rides , profit_rides
dri_1,5,1
dri_2,2,0 */

select * from drivers;

select d1.id ,count(d1.id) as total_rides, count(d2.id) as  profit_rides
from drivers d1
left join drivers d2 on d1.id = d2.id and d1.end_loc = d2.start_loc and d1.end_time = d2.start_time
 group by d1.id;




/* Q4 write a query to print customer name and no of occurence of character 't' in the customer name.
customer_name , count_of_occurence_of_t */

select name, len(name)- len(replace(name,'t',''))
from orders


Q5-write a query to print below output from orders data. example output
hierarchy type, hierarchy name , total_sales_in_west_region, total_sales_in_east_region
category , Technology, ,
category, Furniture, ,
category, Office Supplies, ,
sub_category, Art ,
sub_category, Furnishings, ,
-- and so on all the category , subcategory and ship_mode hierarchies
select * from orders

select 'category' as hierarchytype, category as hierarchyname , sum(case when region = 'west'then sales end)as total_sales_in_west_region, 
sum(case when region = 'east'then sales end) as total_sales_in_east_region
from orders 
group by category
union all
--i have not subcategory in table so i am taking CITY
select 'subcategory' as hierarchytype, city as hierarchyname , sum(case when region = 'west'then sales end)as total_sales_in_west_region, 
sum(case when region = 'east'then sales end) as total_sales_in_east_region
from orders 
group by city
union all
select 'ship_mode' as hierarchytype, ship_mode as hierarchyname , sum(case when region = 'west'then sales end)as total_sales_in_west_region, 
sum(case when region = 'east'then sales end) as total_sales_in_east_region
from orders 
group by ship_mode


/* Q6- the first 2 characters of order_id represents the country of order placed . write a query to print total no of 
orders placed in each country
(an order can have 2 rows in the data when more than 1 item was purchased in the order but
it should be considered as 1 order)
*/

-- drop table ord
CREATE TABLE ord (
    order_id VARCHAR(20),
    item_name VARCHAR(50),
    quantity INT
);

INSERT INTO ord (order_id, item_name, quantity) VALUES 
('US12345', 'Laptop', 1),
('US12345', 'Mouse', 1),
('IN67890', 'Smartphone', 1),
('UK11121', 'Tablet', 1),
('IN67891', 'Charger', 1);

select left(order_id,2) as country,
count(distinct order_id) as no_of_order
from ord
group by left(order_id,2);