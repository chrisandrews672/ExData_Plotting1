
## Generate plot 1

file.name <- "./household_power_consumption.txt"
url       <- "http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
zip.file  <- "./data.zip"

# Check if the data is downloaded and download when applicable
if (!file.exists("./household_power_consumption.txt")) {
  download.file(url, destfile = zip.file)
  unzip(zip.file)
  file.remove(zip.file)
}

raw_data <- read.table("./household_power_consumption.txt", sep = ";", header = TRUE)

raw_data_02 <- raw_data %>%
  mutate(Date = as.Date(Date, format = "%d/%m/%Y")
         )

## Filter for just the two days required

selected_dates <- raw_data_02 %>%
  filter(Date == "2007/02/01" | Date == "2007/02/02") %>%
  mutate(
    Global_active_power = as.numeric(Global_active_power)
  )

## Generate Plot 1

dev.copy(png, 'plot1.png')

hist(selected_dates$Global_active_power,
     col = "red",
     main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)"
)

dev.off()
