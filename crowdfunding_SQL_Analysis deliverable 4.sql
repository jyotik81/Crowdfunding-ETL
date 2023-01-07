-- Challenge Bonus queries.
-- 1. (2.5 pts)
-- Retrieve all the number of backer_counts in descending order for each `cf_id` for the "live" campaigns. 
select cf_id, backers_count, outcome
from campaign
 where outcome = 'live'
 order by backers_count Desc;
 



-- 2. (2.5 pts)
-- Using the "backers" table confirm the results in the first query.
select c.cf_id as "Campaign ID",
       c.backers_count as "no.of backers",
	   count(b.backer_id) as "no. of backers"
from campaign as c
inner join backers as b
on c.cf_id = b.cf_id
where c.outcome = 'live'
group by c.cf_id
order by backers_count desc;

-- 3. (5 pts)
-- Create a table that has the first and last name, and email address of each contact.
-- and the amount left to reach the goal for all "live" projects in descending order. 
select ct.first_name "First Name", 
       ct.last_name "Last Name", 
	   ct.email "Email",
	   cg.goal - cg.pledged as "Remaining Goal Amount"
into email_contacts_remaining_goal_amount
from contacts as ct
inner join campaign as cg on cg.contact_id = ct.contact_id
where cg.outcome = 'live'
order by "Remaining Goal Amount" DESC;

-- Check the table

select * from email_contacts_remaining_goal_amount;

-- 4. (5 pts)
-- Create a table, "email_backers_remaining_goal_amount" that contains the email address of each backer in descending order, 
-- and has the first and last name of each backer, the cf_id, company name, description, 
-- end date of the campaign, and the remaining amount of the campaign goal as "Left of Goal". 

select bk.email "Email", 
	   bk.first_name "First Name",
	   bk.last_name "Last Name",
	   bk.cf_id,
	   cg.company_name,
	   cg.description,
	   cg.end_date,
	   cg.goal - cg.pledged "Left of Goal"
	   
into email_backers_remaining_goal_amount
from backers bk
inner join campaign as cg on cg.cf_id = bk.cf_id
order by bk.last_name, bk.email

-- Check the table
select * from email_backers_remaining_goal_amount

