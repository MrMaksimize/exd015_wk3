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

bpol <- NEI %>%
  filter(fips == "24510") %>%
  group_by(year, type) %>%
  summarise(total_emissions = sum(Emissions))

g <- ggplot(data = bpol, aes(year, total_emissions)) +
  geom_line(aes(color=type), size=2) +
  facet_grid(type ~ ., scales="free_y") +
  labs(title="Total Emissions in Baltimore By Type", y = "Coal Emissions (tons)")

print(g)


dev.copy(png, file="./plot3.png")
dev.off()
