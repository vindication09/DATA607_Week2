
#--create a schema 
drop schema if exists movies;
create schema movies;
use movies; 

#--create a movies table from my survey 
drop table if exists movies;
create table movies  (
movie_id integer primary key not null,
movie varchar(150) not null);

#--populate the movies table with the results from the survey 
insert into  movies (movie_id, movie)
values (1, 'The Shape of Water');

insert into  movies (movie_id, movie)
values (2, 'Get Out');

insert into  movies (movie_id, movie)
values (3, 'John Wick');

insert into  movies (movie_id, movie)
values (4, 'Spider Man Homecoming');

insert into  movies (movie_id, movie)
values (5, 'Logan');

insert into  movies (movie_id, movie)
values (6, 'The Lovely Bones');

insert into  movies (movie_id, movie)
values (7, 'Saw');

insert into  movies (movie_id, movie)
values (8, 'Coco');

#--create a names table 
drop table if exists names;
create table names (
person_id integer primary key, 
name varchar(150) not null);

#---populate the names table 
insert into names (person_id, name)
values (101, 'Vinicio'), 
(102, 'Anonymous1'), 
(103, 'Nick'), 
(104, 'David'), 
(105, 'Anonymous2'), 
(106, 'Loren'), 
(107, 'Kelly'), 
(108, 'Rachel'), 
(109, 'Tess'), 
(110, 'Holly'), 
(111, 'Jimmy'), 
(112, 'Glamis'), 
(113, 'Kari'), 
(114, 'Chris'), 
(115, 'Eddie'), 
(116, 'Rebecca'),
(117, 'Kathryn');


#--create a reviewers table 
drop table if exists reviews;
create table reviews (
person_id integer references names(person_id), 
movie_id integer references movies(movie_id), 
rating integer check (rating between 1 and 5));

#--populate the table with the results from my survey 
insert into reviews (person_id, movie_id, rating)
values 
(101, 1, 5), 
(101, 2, null), 
(101, 3, 5), 
(101, 4, 4),
(101, 5, 5),
(101, 6, 4),
(101, 7, 3), 
(101, 8, 5),

(102, 1, null),
(102, 2, 5), 
(102, 3, 5), 
(102, 4, 5),
(102, 5, 5),
(102, 6, null),
(102, 7, 5), 
(102, 8, null),
(103, 1, 2),

(103, 2, 4), 
(103, 3, 5), 
(103, 4, 3),
(103, 5, 4),
(103, 6, 2),
(103, 7, 4), 
(103, 8, 2),

(104, 1, null),
(104, 2, null), 
(104, 3, null), 
(104, 4, null),
(104, 5, 5),
(104, 6, null),
(104, 7, null), 
(104, 8, 5),

(105, 1, null),
(105, 2, null), 
(105, 3, null), 
(105, 4, null),
(105, 5, null),
(105, 6, null),
(105, 7, 3), 
(105, 8, 3),

(106, 1, 5),
(106, 2, 5), 
(106, 3, 3), 
(106, 4, 1),
(106, 5, 3),
(106, 6, 4),
(106, 7, 1), 
(106, 8, null),

(107, 1, 1),
(107, 2, 5), 
(107, 3, 5), 
(107, 4, 4),
(107, 5, 5),
(107, 6, 5),
(107, 7, 2), 
(107, 8, 5),

(108, 1, 3),
(108, 2, 3), 
(108, 3, 3), 
(108, 4, 3),
(108, 5, 4),
(108, 6, 4),
(108, 7, 3), 
(108, 8, 4),

(109, 1, 3),
(109, 2, 3), 
(109, 3, 3), 
(109, 4, 3),
(109, 5, 4),
(109, 6, 5),
(109, 7, 3), 
(109, 8, 5),

(110, 1, 5),
(110, 2, 4), 
(110, 3, 3), 
(110, 4, 2),
(110, 5, 3),
(110, 6, 4),
(110, 7, 1), 
(110, 8, 3),

(111, 1, null),
(111, 2, null), 
(111, 3, 4), 
(111, 4, 5),
(111, 5, null),
(111, 6, null),
(111, 7, null), 
(111, 8, 5), 

(112, 1, 1),
(112, 2, null), 
(112, 3, 5), 
(112, 4, 5),
(112, 5, 5),
(112, 6, 5),
(112, 7, 2), 
(112, 8, 5),

(113, 1, 3),
(113, 2, 4), 
(113, 3, 4), 
(113, 4, 5),
(113, 5, 4),
(113, 6, 3),
(113, 7, 1), 
(113, 8, 5),

(114, 1, null),
(114, 2, null), 
(114, 3, 4), 
(114, 4, null),
(114, 5, null),
(114, 6, null),
(114, 7, null), 
(114, 8, null),

(115, 1, 4),
(115, 2, null), 
(115, 3, 5), 
(115, 4, 4),
(115, 5, 5),
(115, 6, 5),
(115, 7, 4), 
(115, 8, 5),

(116, 1, 5),
(116, 2, 3), 
(116, 3, 5), 
(116, 4, 2),
(116, 5, 5),
(116, 6, 5),
(116, 7, 2), 
(116, 8, 5),

(117, 1, 3),
(117, 2, 3), 
(117, 3, 3), 
(117, 4, 5),
(117, 5, 5),
(117, 6, 1),
(117, 7, 2), 
(117, 8, 5);

#--check your tables 
select * from movies;
select * from names;
select * from reviews order by movie_id desc;

drop table if exists movieratings;
create table movieratings
select 
a.person_id, 
a.name, 
b.movie, 
c.rating 
from names a
left join reviews c 
on (a.person_id=c.person_id)
left join movies b
on (b.movie_id=c.movie_id)
order by c.rating desc;

select movie_id, rating, count(rating) from reviews where movie_id=1 group by movie_id, rating order by rating desc;

select movie, avg(rating) as avg
from movieratings
where rating is not null
group by movie desc;







