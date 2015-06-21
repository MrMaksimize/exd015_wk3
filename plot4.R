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

coal_cats <- SCC %>%
  filter(
    grepl("coal", Short.Name, ignore.case = TRUE) |
    grepl("coal", EI.Sector, ignore.case = TRUE)
  ) %>%
  mutate(SCC = as.character(SCC))


cpol <- NEI %>%
  mutate(SCC = as.character(SCC)) %>%
  semi_join(coal_cats, by = "SCC") %>%
  group_by(year) %>%
  summarise(coal_emissions = sum(Emissions))

g <- ggplot(data = cpol, aes(year, coal_emissions)) +
  geom_line(color="blue", size=2) +
  labs(title="Total Coal Emissions in the US by Year", y = "Coal Emissions (tons)")

print(g)


#dev.copy(png, file="./plot1.png")
#dev.off()
