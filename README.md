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




