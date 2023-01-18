select * from AnalystProject.dbo.CovidDeaths
order by 3, 4

select * from AnalystProject.dbo.CovidVaccinations
order by 3, 4

select location, date, total_cases, new_cases, total_deaths, population
from AnalystProject.dbo.CovidDeaths
order by 1,2

--total cases vs total deaths
--shows the likelyhood of dying
select location, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
from AnalystProject.dbo.CovidDeaths
where location like 'india'
group by location, total_cases, total_deaths
order by 1,2

--total cases vs population, tells about percentage of population got covid
select location, date, total_cases, population, (total_cases/population)*100 as DeathPercentage
from AnalystProject.dbo.CovidDeaths
--where location like 'india'
order by 1,2

--countries with highest infection rate w.r.t population
select location, population, max(total_cases) as Highinfectioncount, max((total_cases/population))*100 as Percentpeopleinfected
from AnalystProject.dbo.CovidDeaths
--where location like 'india'
group by location, population
order by 4 desc


Select Location, Population,date, MAX(total_cases) as HighestInfectionCount,  Max((total_cases/population))*100 as PercentPopulationInfected
From AnalystProject.dbo.CovidDeaths
Group by Location, Population, date
order by PercentPopulationInfected desc

--countries with highest death rate w.r.t population
select location, max(cast(total_deaths as int)) as Highdeathcount, max((total_deaths/population))*100 as Percentpeopledied
from AnalystProject.dbo.CovidDeaths
--where continent is not null
group by location
order by 2 desc

--by continent
select continent, max(cast(total_deaths as int)) as Highdeathcount
from AnalystProject.dbo.CovidDeaths
--where location like 'india'
where continent is not null
group by continent
order by 2 desc

--Removing noise in  data, I have some noise in my database, which got added to my covid data from another table in my database, I have removed simply using "not in"
Select location, SUM(cast(new_deaths as int)) as TotalDeathCount
From AnalystProject.dbo.CovidDeaths
Where continent is null 
and location not in ('World', 'European Union', 'International', 'high income', 'upper middle income', 'Lower middle income', 'Low income')
Group by location
order by TotalDeathCount desc

--global numbers
select sum(new_cases) as totalcases, sum(cast(new_deaths as int)) as totaldeaths, (sum(cast(new_deaths as int))/sum(new_cases))*100 as DeathPercentage
from AnalystProject.dbo.CovidDeaths
--where location like 'india'
where continent is not null
--group by date
order by 1,2

--total population vs vaccination (windows function example)
select cod.continent, cod.location, cod.date, cod.population, cov.new_vaccinations
, sum(convert(int,cov.new_vaccinations)) over (partition by cod.location order by cod.location, cod.date)
from AnalystProject.dbo.CovidDeaths cod 
join AnalystProject.dbo.CovidVaccinations cov
	on cod.location=cov.location 
	and cod.date=cov.date
where cod.continent is not null
order by 2,3
