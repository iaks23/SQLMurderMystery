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


