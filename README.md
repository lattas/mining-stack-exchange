This repository contains the scripts used and the results of a data-mining project on the database of the [Database Administration StackExchange](http://dba.stackexchange.com/) between 2008-2013.

***

Short Presentation of Results: on [Slideshare](https://www.slideshare.net/AlexanderLattas/mining-the-dba-stackexchange).

***

#Metholodogy
##The Database
The database was found [here](http://meta.stackexchange.com/questions/198915/is-there-a-direct-download-link-with-a-raw-data-dump-of-stack-overflow-not-a-t) and consists of xml files with the Database Administration StackExchange database, from 2008 to 2013.
##Tools
The team used SQL Server and Visual studio to create the Data Warehouse and Cube that were then loaded to Tableau for the visualisation of the data. Hadoop was used for 3 MapReduce Jobs and RapidMiner for to run Associated Rules and Clustering Algorithms.
##Data Warehouse and Cube
After clearing the xml files and passing them in SQL Server, the team created the nessecary relations and dimensions, using Posts as a fact table and cleared 5% of the total data as they were orphaned:

##First Results
Metrics on Days, Months, Years as well as Badges and Tag frequency:

![General Results](https://github.com/a-lattas/mining-stack-exchange/blob/master/Results/General.jpg)

![PostsPerMonth](https://github.com/a-lattas/mining-stack-exchange/blob/master/Results/PostsPerMonth.png)

Posts per country:

![PostsPerCountry](https://github.com/a-lattas/mining-stack-exchange/blob/master/Results/PostsPerCountry.png)

##Clustering
Clustering results relating to Post data:

![ClusteringToPosts](https://github.com/a-lattas/mining-stack-exchange/blob/master/Results/ClusterPosts.png)

Clustering results relating to User data:

![ClusteringToUsers](https://github.com/a-lattas/mining-stack-exchange/blob/master/Results/ClusterUsers.png)

##Association Rules

![Association Rules Results](https://github.com/a-lattas/mining-stack-exchange/blob/master/Results/AssociationRules.png)

##MapReduce Results

![MapReduceResults](https://github.com/a-lattas/mining-stack-exchange/blob/master/Results/MapReduce.jpg)
