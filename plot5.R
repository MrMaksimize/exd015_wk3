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


car_cats <- SCC %>%
  filter(grepl("vehicle", EI.Sector, ignore.case = TRUE)) %>%
  mutate(SCC = as.character(SCC))


mvpol <- NEI %>%
  mutate(SCC = as.character(SCC)) %>%
  filter(fips == "24510") %>%
  semi_join(car_cats, by = "SCC") %>%
  group_by(year) %>%
  summarise(mv_emissions = sum(Emissions))

g <- ggplot(data = mvpol, aes(year, mv_emissions)) +
  geom_line(color="blue", size=2) +
  labs(
    title="Total Motor Vehicle Emissions in Baltimore by Year",
    y = "Motor Vehcile Emissions (tons)"
  )

 print(g)


dev.copy(png, file="./plot5.png")
dev.off()
