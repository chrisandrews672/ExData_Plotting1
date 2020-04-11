
## Generate plot 4

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
    Sub_metering_1 = as.numeric(Sub_metering_1),
    Sub_metering_2 = as.numeric(Sub_metering_2),
    Sub_metering_3 = as.numeric(Sub_metering_3),
    Voltage = as.numeric(Voltage),
    Global_reactive_power = as.numeric(Global_reactive_power),
    date_time = as.POSIXct(strptime(paste(Date, Time, sep = ""),
                                    format = "%Y-%m-%d %H:%M:%S"))
  )

## Generate Plot 4 - four sub-plots

dev.copy(png, 'plot4.png')

par(mfcol = c(2,2))

# Plot 1

plot(selected_dates$date_time, selected_dates$Global_active_power,
     ylab = "Global Active Power",
     type = "l",
     xlab = "",
     lwd = 0.5)

# Plot 2

plot(selected_dates$date_time, selected_dates$Sub_metering_1,
     ylab = "Energy sub metering",
     xlab = "",
     type = "l",
     col = "black")

lines(selected_dates$date_time, selected_dates$Sub_metering_2,
      ylab = "Energy sub metering",
      xlab = "",
      type = "l",
      col = "red")

lines(selected_dates$date_time, selected_dates$Sub_metering_3,
      ylab = "Energy sub metering",
      xlab = "",
      type = "l",
      col = "blue")

legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col = c("black", "red", "blue"), lty = 1, cex = 0.5)

# plot 3

plot(selected_dates$date_time, selected_dates$Voltage,
     ylab = "Voltage",
     type = "l",
     xlab = "datetime",
     lwd = 0.5)

# plot 4

plot(selected_dates$date_time, selected_dates$Global_reactive_power,
     ylab = "Global_reactive_power",
     type = "l",
     xlab = "datetime",
     lwd = 0.5)

dev.off()
