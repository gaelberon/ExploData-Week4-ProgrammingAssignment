# COURSERA - DATA SCIENCE
# EXPLORATORY DATA - WEEK 4
# PROGRAMMING ASSIGNMENT

## The R file 'plot2.R' aims to answer the following question:
## "Have total emissions from PM2.5 decreased in the Baltimore City, Maryland
## (fips == "24510") from 1999 to 2008?"

## summarySCC_PM25.rds (PM2.5 Emissions Data): This file contains a data frame
## with all of the PM2.5 emissions data for 1999, 2002, 2005, and 2008.
## For each year, the table contains number of tons of PM2.5 emitted from a
## specific type of source for the entire year. Here are the first few rows
## 
## List of variables:
## fips: A five-digit number (represented as a string) indicating the U.S.
##       county
## SCC: The name of the source as indicated by a digit string (see source code
##      classification table)
## Pollutant: A string indicating the pollutant
## Emissions: Amount of PM2.5 emitted, in tons
## type: The type of source (point, non-point, on-road, or non-road)
## year: The year of emissions recorded

## Source_Classification_Code.rds (Source Classification Code Table): This table
## provides a mapping from the SCC digit strings in the Emissions table to the
## actual name of the PM2.5 source. The sources are categorized in a few
## different ways from more general to more specific and you may choose to
## explore whatever categories you think are most useful. For example, source
## “10100101” is known as “Ext Comb /Electric Gen /Anthracite Coal /Pulverized
## Coal”.

################################################################################
## 1. Read the input files
## NB. This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
#SCC <- readRDS("Source_Classification_Code.rds")

################################################################################
## 2. Produce a barplot to answer the question:
## "Have total emissions from PM2.5 decreased in the Baltimore City, Maryland
## (fips == "24510") from 1999 to 2008?
## Use the base plotting system to make a plot answering this question."

## Compute dataset for Baltimore
sumPerYearBaltimore <- with(NEI[NEI$fips == "24510", ],
                             tapply(Emissions, year, sum, na.rm = TRUE))

## Initialize a plotting area with 1 row and 1 column
par(mfrow = c(1,1))

## Plot dataset for Baltimore
barplot(height = sumPerYearBaltimore,
        names.arg = names(sumPerYearBaltimore),
        main = "PM2.5 Emissions in Baltimore, Maryland",
        xlab = "Year",
        ylab = "Amount of PM2.5 emitted (tons)")

################################################################################
## 3. Store the plot into the file plot2.png
dev.copy(png,
         file = 'plot2.png',
         width = 480,
         height = 480,
         units = "px")

########################################################################
## 4. Close the 'png file' device
dev.off()
