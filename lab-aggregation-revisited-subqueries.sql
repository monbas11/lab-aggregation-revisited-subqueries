-- select the first name, last name and email address of all the customers who have rented a movid
select customer.first_name, customer.last_name, customer.email
from sakila.customer
join sakila.rental on customer.customer_id = rental_id;

-- what is the avg payment made by each costumer (display customer id, customer name (concatenated and the average payment made)

select c.customer_id, concat(c.first_name, ' ', c.last_name) as full_name, avg(p.amount) as avg_payment
from sakila.customer c
join sakila.payment p on c.customer_id = p.customer_id
group by c.customer_id, full_name;

-- Select the name and the mail address of all costumers who have rented the "action" movies
 -- 1. usig multiple join
 
select c.first_name, c.last_name, c.email
from sakila.customer c
join sakila.rental r on c.customer_id = r.customer_id
join sakila.inventory i on i.inventory_id= r.inventory_id
join sakila.film f on f.film_id = i.film_id
join sakila.film_category fc on fc.film_id = i.film_id
join sakila.category ca on ca.category_id = fc.category_id
where ca.name= "Action";

 -- 2. using multiple where clause and in condition

select first_name, last_name, email
from customer
where customer_id in (
    select customer_id
    from rental
    where inventory_id in (
        select inventory_id
        from inventory
        where film_id in (
            select film_id
            from film
            where film_id in (
                select film_id
                from film_category
                where category_id in (
                    select category_id
                    from category
                    where name = 'Action')))));
                    
                    
-- create new column classifying existing columns  as either or high value transactions based on the amount of payment. 
-- If the amount is between 0 and 2, label should be low and if the amount is between 2 and 4, the label should be medium, and if it is more than 4, then it should be high.

 
select payment_id,amount,
   case
        when amount between 0 and 2 then  'Low'
        when amount between 2 and 4 then'Medium'
        else 'High'
    end as transaction_class
from 
    payment;  