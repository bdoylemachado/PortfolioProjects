--Selecting the price of Petrol Ordered by Highest Price 1st.
SELECT Country, [Price Per Gallon (USD)]AS Price
FROM PetrolTable
ORDER BY PRICE DESC

--Selecting all countries and ordering by Daily Barrel Consumption Descnding
SELECT Country, [Daily Oil Consumption (Barrels)] AS Daily_Barrel_Consumption
FROM PortfolioProject..PetrolTable2
ORDER BY Daily_Barrel_Consumption DESC


--Selecting all countries and ordering by Yearly Gallons Per Capita Descendign
SELECT Pet2.Country, Pet2.[Yearly Gallons Per Capita]
FROM PortfolioProject..PetrolTable2 AS Pet2
ORDER BY [Yearly Gallons Per Capita] DESC

--Selecting all Countries with highest prices of petrol in US dollars
SELECT Country, [Price Per Gallon (USD)] AS Price_USD
FROM PetrolTable
ORDER BY Price_USD DESC



--Finding Top Ten Countries Yearly Gallons per capita
SELECT TOP 10 Pet2.Country, Pet2.[Yearly Gallons Per Capita]
FROM PortfolioProject..PetrolTable2 AS Pet2
ORDER BY [Yearly Gallons Per Capita] DESC


--Finding Top 10 Countries by Daily_Barrel_Consumption
SELECT TOP 10 Country,[Daily Oil Consumption (Barrels)] AS Daily_Barrel_Consumption
FROM PortfolioProject..PetrolTable2
ORDER BY Daily_Barrel_Consumption DESC

--Finding Top 10 Countries with highest prices of petrol in US dollars
SELECT TOP 10  Country, [Price Per Gallon (USD)] AS Price_USD
FROM PetrolTable
ORDER BY Price_USD DESC

