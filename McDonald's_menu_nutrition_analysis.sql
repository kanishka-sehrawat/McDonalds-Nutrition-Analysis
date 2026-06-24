create database McDonalds;

select * from mcd_menu;

select count(*) as total_rows from mcd_menu;

-- query to find which category has most items
select menu_category,count(*) as total_items from mcd_menu group by menu_category order by count(*) desc;

-- query to find items contributing most to calorie intake
select menu_items,energy from mcd_menu order by energy desc limit 10;

-- query to find best choice for fitness conscious customers
select menu_items,protein from mcd_menu order by protein desc limit 10;

-- query to find drinks and sweets with excessive sugar
select menu_items,total_sugars from mcd_menu order by total_sugars desc limit 10;

-- query to find items contibuting most to sodium intake
select menu_items,sodium from mcd_menu order by sodium desc limit 10;

-- query to find most effective protein choices
with protein_content as 
(select menu_items,round(protein/energy,3) as protein_per_calorie from mcd_menu where energy>0)
select * from protein_content order by protein_ratio desc ;

-- query to find the most calorie dense category
select menu_category,round(avg(energy),2) as avg_cal from mcd_menu group by menu_category ;

-- query to find the lowest calorie item in each category
with low_calorie_item as 
(select *,row_number() over(partition by menu_category order by energy ) as rk from mcd_menu)
select menu_category,menu_items,energy from low_calorie_item where rk=1 ;

-- query to find the  nutrition comparison across categories
select menu_category,round(avg(energy),2) as avg_energy,round(avg(protein),2) as avg_protein,round(avg(total_fat),2) as avg_fat,
round(avg(total_carbohydrate),2) as avg_carbohydrate,round(avg(sodium),2) as avg_sodium from mcd_menu group by menu_category;


