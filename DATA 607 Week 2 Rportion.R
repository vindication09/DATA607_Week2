#load the library to make the connection to MySQL
library(RMySQL)
        
#make the connection to MYSQL
mydb = dbConnect(MySQL(), user='root', password='bbuser', dbname='movies', host='localhost')
        
#list all the tables in the database
dbListTables(mydb)
        
#for any table in the database,this lists the field 
dbListFields(mydb, 'movies')
      
#Lets make a table that has the person id, their name, movie title, and the rating
#Let save this table as an r data frame 
#From the Documentation,The function dbGetQuery submits the statement, 
#fetches all output records, and clears the result set.
rs<-dbGetQuery(mydb, 'select 
a.person_id, 
a.name, 
b.movie, 
c.rating 
from names a
left join reviews c 
on (a.person_id=c.person_id)
left join movies b
on (b.movie_id=c.movie_id)
order by c.rating desc;')

#Lets Look at our newd data frame 
df.movies<-rs
head(df.movies)

#We should find out how R assigned data types
#Does it match witht the data types we made in the SQL script? 
str(df.movies)

#i noticed that there are missing values
#How many missing values are there? 
colSums(is.na(df.movies))

#There are 31 missing (NA) values in the ratings column 

#Lets plot a distribution of the ratings per movie 
#We can subset a data fram using a SQL query 
#This query gives us the movie title, appended to each of the 5 ratings,and a tally of how many times
#a specific movie was given that rating 
ds<-dbGetQuery(mydb,'select movie, rating, count(rating) as freq
from movieratings
where rating is not null
group by movie desc,rating desc
order by movie desc, rating desc;')


#Check the new subset 
head(ds)

#How can we show the Freq. of Ratings for all the movies? 
library(ggplot2)
library(RColorBrewer)
require(scales)
ggplot(ds, aes(x=rating, y=freq, group = movie, colour = movie)) +
  geom_point() +
  geom_point( size=4, shape=21, fill="white")+
  ggtitle("Frequency of Ratings for Each Movie")+
  labs( x="Rating (1-5 Scale)", y="Count")+
  labs(caption="Data Source: Custom Facebook Survey, 17 Participants")+
  scale_color_brewer(palette="Dark2")


#From this chart, we can see that Coco is at the top with 10 participants giving the movie a rating of 5. 
#On the lower end, Saw has recieved the most unfavorable ratings of 1. 






