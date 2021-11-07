SELECT * from crime_scene_report WHERE type='murder' and date=20180115 
and city='SQL City';
              

SELECT * from person 
WHERE address_street_name='Northwestern Dr' order by address_number DESC;



SELECT * from person 
WHERE address_street_name='Franklin Ave' and name like 'Annabel%';


SELECT * FROM interview WHERE person_id=14887


SELECT * FROM interview WHERE person_id=16371


SELECT * FROM get_fit_now_member WHERE person_id=16371



SELECT * FROM get_fit_now_check_in WHERE membership_id = '90081'



SELECT * FROM get_fit_now_check_in WHERE check_in_date = 20180109 
and membership_id like '48Z%'


SELECT * FROM get_fit_now_member WHERE id='48Z7A'




SELECT * FROM get_fit_now_member WHERE id='48Z55'

/* Alternatively an advance join can also be applied*/

SELECT 
t1.id,
t1.name,
t2.id,
t2.membership_status,
t3.plate_number
FROM person AS t1 INNER JOIN 
get_fit_now_member AS t2
ON t1.id = t2.person_id
INNER JOIN 
drivers_license AS t3
ON t1.license_id = t3.id
WHERE 
t2.id LIKE '48Z%'
AND 
t3.plate_number LIKE '%H42W%'


INSERT INTO solution VALUES (1, 'Jeremy Bowers');
        
        SELECT value FROM solution;

/*Congrats, you found the murderer! But wait, there's more... If you think you're up for a challenge, 
try querying the interview transcript of the murderer to find the real villain behind this crime. 
If you feel especially confident in your SQL skills, try to complete this final step with no more than 2 queries. 
Use this same INSERT statement with your new suspect to check your answer.*/


select * from interview WHERE person_id = 67318


SELECT 
t1.id,
t1.name,
t1.ssn,
t3.annual_income,
t4.event_name,
t4.date
FROM person AS t1 
INNER JOIN drivers_license AS t2
ON t1.license_id = t2.id
INNER JOIN income AS t3
ON t1.ssn = t3.ssn
INNER JOIN facebook_event_checkin AS t4
ON t1.id = t4.person_id
WHERE
t2.hair_color='red' AND
t2.gender='female' AND
t2.car_make='Tesla' AND
t2.car_model='Model S'



INSERT INTO solution VALUES (1, 'Miranda Priestly');
        
        SELECT value FROM solution;

/*Congrats, you found the brains behind the murder! Everyone in SQL City hails you as the greatest SQL detective of all time. Time to break out the champagne!
*/