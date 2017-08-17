# COURSERA - DATA SCIENCE
# EXPLORATORY DATA - WEEK 4
# PROGRAMMING ASSIGNMENT

## The R file 'plot3.R' aims to answer the following question:
## "Of the four types of sources indicated by the type (point, nonpoint,
## onroad, nonroad) variable, which of these four sources have seen decreases
## in emissions from 1999–2008 for Baltimore City? Which have seen increases
## in emissions from 1999–2008?"

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
## "Of the four types of sources indicated by the type (point, nonpoint,
## onroad, nonroad) variable, which of these four sources have seen decreases
## in emissions from 1999–2008 for Baltimore City? Which have seen increases
## in emissions from 1999–2008?
## Use the ggplot2 plotting system to make a plot answer this question"

## Load ggplot2 library
library(ggplot2)

## Plot dataset for Baltimore using geom_bar function of ggplot2 using as many
## plotting areas (facets) as there are types (eg: 4)
ggplot(NEI[NEI$fips == "24510", ],
       aes(factor(year),Emissions,fill=type)) +
        geom_bar(stat="identity") +
        facet_grid(.~type) +
        labs(title = expression("PM2.5 Emissions in Baltimore, Maryland, by source type")) +
        labs(x="year", y=expression("Amount of PM2.5 emitted (tons)"))

################################################################################
## 3. Store the plot into the file plot3.png
ggsave(file = 'plot3.png')
