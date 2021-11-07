[![forthebadge](https://forthebadge.com/images/badges/made-with-markdown.svg)](https://forthebadge.com) [![forthebadge](https://forthebadge.com/images/badges/as-seen-on-tv.svg)](https://forthebadge.com) [![forthebadge](https://github.com/iaks23/SQLMurderMystery/blob/main/img/shut-up-i'm-in-my-mind-palace.svg)](https://forthebadge.com) 


# 🚨 SQL Murder Mystery

> A fun SQL challenge mixed with a classic whodunnit created by [Knight Lab](https://mystery.knightlab.com) from Northwestern University

[![star-useful](https://img.shields.io/badge/🌟-If%20useful-red.svg)](https://shields.io) 
[![view-repo](https://img.shields.io/badge/View-Repo-blueviolet)](https://github.com/iaks23?tab=repositories)
[![view-profile](https://img.shields.io/badge/Go%20To-Profile-orange)](https://github.com/iaks23) 

# 📁 Case Files
* [🔎 Elementary, Dear Watson](#preface)
* [📝 Crime Scene Report](#report)
  * [👩🏼‍🦳 Witness Interview 1](#wit1)
  * [🧑🏾‍🦱 Witness Interview 2](#wit2)
* [🛵 Following Up on Leads](#leads)
* [📌 Finding The Killer](#killer)
* [⏰ The Plot Thickens](#plot)
* [💡 A Study in Red](#red)


# 🔎 Elementary, Dear Watson <a name='preface'></a>

### There's been a murder in SQL CITY! 

A crime has occurred, a murderer is on the loose, and a detective needs our SQL expertise. We have access to the police department's database and one clue.

> 💡 The crime was a `murder` that occurred sometime on `Jan.15, 2018` and that it took place in `SQL City`.

Let's put on our thinking caps, and get aborad the mystery train!

<p align="center">
  <img width="350" height="350" src="https://github.com/iaks23/SQLMurderMystery/blob/main/img/game.GIF">
</p>

# 📝 Crime Scene Report <a name='report'></a>

The SQLCity Police Department's database looks a little something like this, 

![Schema](https://github.com/iaks23/SQLMurderMystery/blob/main/img/schema.png)

Based on the schema above and the clue given, we will start oour investigation by fetchin the crime scene report

```SQL
SELECT * from crime_scene_report WHERE type='murder' and date=20180115 
and city='SQL City';
```
|Data|Type|Description|City|
|---|---|---|---|
|20180115|	murder|	Security footage shows that there were 2 witnesses. The first witness lives at the last house on "Northwestern Dr". The second witness, named Annabel, lives somewhere on "Franklin Ave".| SQL City|

The address clues leads us to the `person` table which has the column address. 

```SQL
SELECT * from person 
WHERE address_street_name='Franklin Ave' and name like 'Annabel%';
```

|id|	name|	license_id|	address_number|	address_street_name|	ssn|
|---|---|---|---|---|---|
|16371|	Annabel Miller|	490173|	103| Franklin Ave|	318771143|



```SQL
SELECT * from person 
WHERE address_street_name='Northwestern Dr' order by address_number DESC;
```

|id|	name|	license_id|	address_number|	address_street_name|	ssn|
|---|---|---|---|---|---|
|14887|	Morty Schapiro|	118009|	4919|	Northwestern Dr|	111564949|

### Two leads!

Let's explore their interviews to find out if they know something! 

# 👩🏼‍🦳 Witness Interview #1 <a name='wit1'></a>

```SQL
SELECT * FROM interview WHERE person_id=16371
```

> Annabel Franklin Says:

`I saw the murder happen, 
and I recognized the killer from my gym when I was working out last week on January the 9th.`


# 🧑🏾‍🦱 Witness Interview #2 <a name='wit2'></a>

```SQL

SELECT * FROM interview WHERE person_id=14887
```

> Morty Schapiro Says:

`I heard a gunshot and then saw a man run out. He had a "Get Fit Now Gym" bag. 
The membership number on the bag started with "48Z". Only gold members have those bags. 
The man got into a car with a plate that included "H42W"`

# 🛵 Following Our Leads <a name='leads'></a>

We're getting warmer and the name of the killer probably lies in the two tables related to the Get Fit Now gyms. 

First let's explore the timings that Anabel was working out on the 9th of January when she spotted the murderer. 

```SQL
SELECT * FROM get_fit_now_member WHERE person_id=16371
```

|id|	person_id|	name|	membership_start_date|	membership_status|
|---|---|---|---|---|
|90081|	16371|	Annabel Miller|	20160208|	gold|

```SQL
SELECT * FROM get_fit_now_check_in WHERE membership_id = '90081'
```

> Annabel's checkin & checkout times are: 1600 to 1700

Using this knowledge along with the second witness statement, 

```SQL
SELECT * FROM get_fit_now_check_in WHERE check_in_date = 20180109 
and membership_id like '48Z%'
```

|membership_id|	check_in_date|	check_in_time|	check_out_time|
|---|---|---|---|
|48Z7A|	20180109|	1600|	1730|
|48Z55|	20180109|	1530|	1700|

```SQL
SELECT * FROM get_fit_now_member WHERE id='48Z7A'
```

#### 28819	Joe Germuska

```SQL
SELECT * FROM get_fit_now_member WHERE id='48Z55'
```

#### 67318	Jeremy Bowers

We have two suspects and the only way to narrow down is to verify the license plates as well. 

# 📌 Finding The Killer <a name='killer'></a>

We can narrow down the suspect by using our Witness #2's statement. 

```SQL
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
```

So the only person with a 48Z GOLD membership & a license plate that includes H42W is

|id|	name|	id|	membership_status|	plate_number|
|---|---|---|---|---|
|67318|	Jeremy Bowers|	48Z55|	gold|	0H42W2|

> 🥳 We've found our killer! Let's confirm! 

```SQL
INSERT INTO solution VALUES (1, 'Jeremy Bowers');
        
        SELECT value FROM solution;
       
```

`Congrats, you found the murderer! But wait, there's more... If you think you're up for a challenge, try querying the interview transcript of the murderer to find the real villain behind this crime. If you feel especially confident in your SQL skills, try to complete this final step with no more than 2 queries. Use this same INSERT statement with your new suspect to check your answer.`

# ⏰ The Plot Thickens <a name='plot'></a>

So Jeremy was only a puppet in the hands of the real criminal. Let's find out what he says in his witness statement to get some clues!

```SQL
select * from interview WHERE person_id = 67318
```

#### Jeremy says:

`I was hired by a woman with a lot of money. I don't know her name but 
I know she's around 5'5" (65") or 5'7" (67"). She has red hair and she drives a Tesla Model S. 
I know that she attended the SQL Symphony Concert 3 times in December 2017.`

So many clues, all that's left to do is find the mastermind.

# 💡 A Study in Red <a name='red'></a>

Jeremy's clues have led us to performing an advance join with multiple tables. 

```SQL
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
```

|id	|name|	ssn|	annual_income|	event_name|	date|
|---|---|---|---|---|---|
|99716|	Miranda Priestly|	987756388|	310000|	SQL Symphony Concert|	20171206|
|99716|	Miranda Priestly|	987756388|	310000|	SQL Symphony Concert|	20171212|
|99716|	Miranda Priestly|	987756388|	310000|	SQL Symphony Concert|	20171229|

Our query lets us know that `Miranda Priestly` is a wealthy woman with red hair and a Tesla Model S, who has been to te SQL Symphony Concert thrice in December, just like Jeremy said. 

Looks like somebody forgot to cover their tracks up.

```sqL
INSERT INTO solution VALUES (1, 'Miranda Priestly');
        
        SELECT value FROM solution;
```

`Congrats, you found the brains behind the murder! Everyone in SQL City hails you as the greatest SQL detective of all time. Time to break out the champagne! 🍾`

--------------------------------


© Akshaya Parthasarathy, 2021 

🌟 If you enjoyed this repo!

Feedback is always welcome, drop a message on

[![LINKEDIN](https://img.shields.io/badge/LinkedIn-0077B5?style=for-the-badge&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/akshaya-parthasarathy23)
[![INSTAGRAM](https://img.shields.io/badge/Instagram-E4405F?style=for-the-badge&logo=instagram&logoColor=white)](https://www.instagram.com/aks_sarathy/)
[![REDDIT](https://img.shields.io/badge/Reddit-FF4500?style=for-the-badge&logo=reddit&logoColor=white)](https://www.reddit.com/user/longstoryshort_)



