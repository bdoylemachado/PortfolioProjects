
SELECT *
FROM PortfolioProject..CovidDeaths
Where continent is not null
order by 3,4

--SELECT *
--FROM PortfolioProject..CovidVaccinations
--order by 3,4

-- Select data that we are going to be using

Select Location, date, total_cases, new_cases, total_deaths, population
FROM PortfolioProject..CovidDeaths
order by 1,2


-- Looking at Total cases VS Total Deaths
-- Shows likelihood of dying if you contract covid in your country.
Select Location, date, total_cases, total_deaths,  (total_deaths/total_cases)*100 AS DeathPercentage
FROM PortfolioProject..CovidDeaths
WHERE location like '%states%'
order by 1,2



-- Looking at Total Cases VS Population
-- Shows what percentage of population got covid
Select Location, date, population, total_cases, (total_cases/population)*100 AS Percentage_Of_Cases
FROM PortfolioProject..CovidDeaths
--WHERE location like '%states%'
order by 1,2



-- Looking at Countries with Highest Infection Rate compared to Populations
Select Location, population, MAX(total_cases) AS HighestInfectionCount, MAX((total_cases/population))*100 AS Percentage_Of_Infected
FROM PortfolioProject..CovidDeaths
--WHERE location like '%states%'
GROUP BY Location, population
order by Percentage_Of_Infected DESC

-- LET'S BREAK THINGS DOWN BY CONTINENT





-- Showing Continents with the Highest Death Count per Population

Select continent, MAX(cast(Total_deaths as int)) AS TotalDeathCount 
FROM PortfolioProject..CovidDeaths
--WHERE location like '%states%'
WHERE continent IS NOT NULL
GROUP BY continent
order by TotalDeathCount DESC


-- Global numbers

Select SUM(new_cases) AS Total_Cases, SUM(cast(new_deaths as int)) AS Total_Deaths, SUM(cast(new_deaths as int))/SUM(New_Cases)*100 AS DeathPercentage
FROM PortfolioProject..CovidDeaths
--WHERE location like '%states%'
WHERE continent is not null
--GROUP BY date
order by 1,2


-- Looking at Total Population VS Vaccination



-- USE CTE

With PopvsVac (Continent, Location, Date, Population, New_Vaccinations, RollingPeopleVaccinated) 
as
(
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CONVERT(int,vac.new_vaccinations)) OVER (Partition by dea.Location ORDER by dea.location, dea.date) as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/ population)*100  
FROM PortfolioProject..CovidDeaths dea
JOIN PortfolioProject..CovidVaccinations vac
	ON dea.location = vac.location
	and dea.date = vac.date
WHERE dea.continent is not null
--ORDER by 2,3
)

SELECT *, (RollingPeopleVaccinated/Population)*100
FROM PopvsVac

-- TEMP TABLE

DROP Table if exists #PercentPopulationVaccinated
Create Table #PercentPopulationVaccinated
(
Continent nvarchar(255),
Location nvarchar(255),
Date datetime,
Population numeric,
New_Vaccinations numeric,
RollingPeopleVaccinated numeric
)

Insert into #PercentPopulationVaccinated
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CONVERT(int,vac.new_vaccinations)) OVER (Partition by dea.Location ORDER by dea.location, dea.date) as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/ population)*100  
FROM PortfolioProject..CovidDeaths dea
JOIN PortfolioProject..CovidVaccinations vac
	ON dea.location = vac.location
	and dea.date = vac.date
WHERE dea.continent is not null
--ORDER by 2,3

SELECT *, (RollingPeopleVaccinated/Population)*100
FROM #PercentPopulationVaccinated


-- Creating View to store datas for later visualization

Create View PercentPopulationVaccinated as
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CONVERT(int,vac.new_vaccinations)) OVER (Partition by dea.Location ORDER by dea.location, dea.date) as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/ population)*100  
FROM PortfolioProject..CovidDeaths dea
JOIN PortfolioProject..CovidVaccinations vac
	ON dea.location = vac.location
	and dea.date = vac.date
WHERE dea.continent is not null
--ORDER by 2,3


Select *
From PercentPopulationVaccinated