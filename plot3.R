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
  filter(fips == "24510")

g <- ggplot(data = bpol, aes(year, Emissions)) +
  coord_cartesian(ylim = c(-100, 500)) +
  geom_point(aes(color=type), alpha=1/2) +
  geom_smooth(method="lm") +
  facet_grid(type ~ .)

print(g)


#dev.copy(png, file="./plot1.png")
#dev.off()
