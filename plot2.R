
## Generate plot 2

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
    Global_active_power = as.numeric(Global_active_power),
    date_time = as.POSIXct(strptime(paste(Date, Time, sep = ""),
                                    format = "%Y-%m-%d %H:%M:%S"))
  )

## Generate Plot 2

dev.copy(png, 'plot2.png')

plot(selected_dates$date_time, selected_dates$Global_active_power,
     ylab = "Global Active Power (kilowatts)",
     type = "l",
     xlab = "",
     lwd = 0.5)

dev.off()
