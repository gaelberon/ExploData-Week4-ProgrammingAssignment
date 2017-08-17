# COURSERA - DATA SCIENCE
# EXPLORATORY DATA - WEEK 4
# PROGRAMMING ASSIGNMENT

## The R file 'plot6.R' aims to answer the following question:
## "Compare emissions from motor vehicle sources in Baltimore City with
## emissions from motor vehicle sources in Los Angeles County, California
## (fips == "06037"). Which city has seen greater changes over time in motor
## vehicle emissions?"

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
SCC <- readRDS("Source_Classification_Code.rds")

################################################################################
## 2. Produce a barplot to answer the question:
## "Compare emissions from motor vehicle sources in Baltimore City with
## emissions from motor vehicle sources in Los Angeles County, California
## (fips == "06037"). Which city has seen greater changes over time in motor
## vehicle emissions?"

## Compute the dataset for Baltimore
sumPerYearBaltimore <- with(NEI[NEI$SCC %in% SCC[grep("vehicle",
                                                      SCC$SCC.Level.Two,
                                                      ignore.case = TRUE), "SCC"] &
                                        NEI$fips == "24510", ],
                            tapply(Emissions, year, sum, na.rm = TRUE))

## Compute the dataset for Los Angeles
sumPerYearLosAngeles <- with(NEI[NEI$SCC %in% SCC[grep("vehicle",
                                                       SCC$SCC.Level.Two,
                                                       ignore.case = TRUE), "SCC"] &
                                         NEI$fips == "06037", ],
                             tapply(Emissions, year, sum, na.rm = TRUE))

## Define the range to build both plots with using the same limit for y axis
rng <- range(0, max(sumPerYearBaltimore, sumPerYearLosAngeles))

## Initialize a plotting area with 1 row and 2 columns
par(mfrow = c(1,2))

## Plot the Baltimore dataset first
barplot(height = sumPerYearBaltimore,
        names.arg = names(sumPerYearBaltimore),
        ylim = rng,
        main = "PM2.5 Motor vehicle emissions for Baltimore, Maryland",
        xlab = "Year",
        ylab = "Amount of PM2.5 emitted (tons)")

## Then plot the Los Angeles dataset
barplot(height = sumPerYearLosAngeles,
        names.arg = names(sumPerYearLosAngeles),
        ylim = rng,
        main = "PM2.5 Motor vehicle emissions for Los Angeles, California",
        xlab = "Year",
        ylab = "Amount of PM2.5 emitted (tons)")

################################################################################
## 3. Store the plot into the file plot6.png
dev.copy(png,
         file = 'plot6.png',
         width = 480,
         height = 480,
         units = "px")

########################################################################
## 4. Close the 'png file' device
dev.off()
