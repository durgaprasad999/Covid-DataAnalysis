
# Covid Analysis Across Globe

Hello! Data Lovers
This project focus on understanding and retreving useful tables from the dataset of 25 million data points.
Using the tables we analyze and create tableau dashboard.




## Installation

Install SQL Server and MS SQL Server Management Studio. Do read Documentation page for better understanding.
    
## 🔗 Links
[![portfolio](https://img.shields.io/badge/my_portfolio-000?style=for-the-badge&logo=ko-fi&logoColor=white)](https://www.venkat-dataanalyst.com/) [![linkedin](https://img.shields.io/badge/linkedin-0A66C2?style=for-the-badge&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/pylavenkatadurgaprasad/)



## Documentation

[SQL Server Installation](https://intellipaat.com/blog/tutorial/sql-tutorial/sql-server-download-installation/)

[Covid-Dataset](https://ourworldindata.org/covid-deaths)

[Tableau Installation](https://intellipaat.com/blog/tutorial/tableau-tutorial/installation-tableau-desktop/)


## Queries to understand the Data

Remember the tables I have used are made and customized for my project purpose and I highly recommend you to work on your own tables based on your project requirements.
 
I named my database AnalystProject. I have one of the table for CovidDeaths, this query will help you to understand the table

```bash
select * from AnalystProject.dbo.CovidDeaths
order by 3, 4
```
same goes for vaccination table 

```bash
select * from AnalystProject.dbo.CovidVaccinations
order by 3, 4
```
The reason I named the datasets as CovidDeaths and CovidVaccinations is to understand the global numbers respectively, Which is my projects main theme. Do yours accordingly.

Selecting with a * will bring all the columns which are not necessary, this query will help us filter some

```bash
select location, date, total_cases, new_cases, total_deaths, population
from AnalystProject.dbo.CovidDeaths
order by 1,2
```
Now we will figure out the death percentage while using group by attribute

```bash
select location, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
from AnalystProject.dbo.CovidDeaths
where location like 'india'
group by location, total_cases, total_deaths
order by 1,2
```
With respect to population
```bash
select location, date, total_cases, population, (total_cases/population)*100 as DeathPercentage
from AnalystProject.dbo.CovidDeaths
--where location like 'india'
order by 1,2
```
If we want to know about the countries with highest rate of infection

```bash
select location, population, max(total_cases) as Highinfectioncount, max((total_cases/population))*100 as Percentpeopleinfected
from AnalystProject.dbo.CovidDeaths
--where location like 'india'
group by location, population
order by 4 desc
```
group by date

```bash
Select Location, Population,date, MAX(total_cases) as HighestInfectionCount,  Max((total_cases/population))*100 as PercentPopulationInfected
From AnalystProject.dbo.CovidDeaths
Group by Location, Population, date
order by PercentPopulationInfected desc
```
To find countries with highest death rate w.r.t population

```bash
select location, max(cast(total_deaths as int)) as Highdeathcount, max((total_deaths/population))*100 as Percentpeopledied
from AnalystProject.dbo.CovidDeaths
--where continent is not null
group by location
order by 2 desc
```

While finding highest death count in a continent, the data has some null values which I removed "where" and "not"
```bash
select continent, max(cast(total_deaths as int)) as Highdeathcount
from AnalystProject.dbo.CovidDeaths
--where location like 'india'
where continent is not null
group by continent
order by 2 desc
```
While finding highest death count I have come across strange values in my project tables

```bash
Select location, SUM(cast(new_deaths as int)) as TotalDeathCount
From AnalystProject.dbo.CovidDeaths
Where continent is null 
and location not in ('World', 'European Union', 'International', 'high income', 'upper middle income', 'Lower middle income', 'Low income')
Group by location
order by TotalDeathCount desc
```
Here I have came to know my database was somehow added other tables data into my project specified tables which I got to know later. Be cautious while cleaning data. Here I am referring "Income" 
name in location. So without wasting time searching for the coloums I simple resolved using "not in".

The global number of cases and deaths with death percentage

```bash
select sum(new_cases) as totalcases, sum(cast(new_deaths as int)) as totaldeaths, (sum(cast(new_deaths as int))/sum(new_cases))*100 as DeathPercentage
from AnalystProject.dbo.CovidDeaths
--where location like 'india'
where continent is not null
--group by date
order by 1,2
```

To find total vaccination people with respect to population we use join function.
```bash
select cod.continent, cod.location, cod.date, cod.population, cov.new_vaccinations
, sum(convert(int,cov.new_vaccinations)) over (partition by cod.location order by cod.location, cod.date)
from AnalystProject.dbo.CovidDeaths cod 
join AnalystProject.dbo.CovidVaccinations cov
	on cod.location=cov.location 
	and cod.date=cov.date
where cod.continent is not null
order by 2,3
```
There are many more queries to use and retrieve relevant information to serve our purpose. I hope you learned something new from my project.


## Tableau
Refer Documentation for Tableau Installation.
Here we use the refined datasts to visualize our work.

[My Tableau](https://public.tableau.com/app/profile/pyla.venkata.durga.prasad/viz/Covid_DataSet_Analysis/Dashboard1?publish=yes)

Thank you.