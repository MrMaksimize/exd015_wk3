## Set WD to the location of file
setwd(dirname(parent.frame(2)$ofile))

source('helpers.R')

# Initialize, downloading data if needed.
init()

if (!exists('NEI') || !exists('SCC')) {
  ## This first line will likely take a few seconds. Be patient!
  NEI <- tbl_df(readRDS("summarySCC_PM25.rds"))
  SCC <- tbl_df(readRDS("Source_Classification_Code.rds"))
}

pol_year <- NEI %>%
  filter(fips == "24510") %>%
  group_by(year) %>%
  summarise(total_emissions = sum(Emissions))


with(pol_year, plot(
  lwd = 3,
  year,
  total_emissions/1000000,
  main = "Total Emissions By Year in Baltimore City",
  type="b",
  col = "blue",
  ylab = "Total Emissions (in millions of tons)"
))




#dev.copy(png, file="./plot2.png")
#dev.off()
