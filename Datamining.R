# Load the dataset
data <- read.csv("C:/Users/Buzz Tech/Downloads/Customer_Behaviour.csv")

# View the first few rows of the dataset
head(data)

#2. Exploratory Data Analysis (EDA)
#Descriptive Statistics
# Summary statistics for the entire dataset
summary(data)

# For individual columns
summary(data$Age)  # Example for a specific column

#Visualizations
library(ggplot2)
#Histograms:
# Histogram of a numerical variable
ggplot(data, aes(x = Age)) +
  geom_histogram(binwidth = 5, fill = "blue", color = "black") +
  theme_minimal() +
  ggtitle("Age Distribution")

#Box Plots (to identify outliers):
# Box plot to detect outliers
ggplot(data, aes(y = Age)) +
  geom_boxplot(fill = "lightblue") +
  theme_minimal() +
  ggtitle("Boxplot of Age")

#Scatter Plot (to identify relationships between variables):
# Scatter plot between two variables
ggplot(data, aes(x = Age, y = Purchased)) +
  geom_point(color = "blue") +
  theme_minimal() +
  ggtitle("Age vs Purchase Amount")

#Variable Description:
# Check the structure of the dataset (variable types and first few entries)
str(data)

#3. Data Preprocessing
#Handling Missing Data
# Remove rows with any missing values
data_clean <- na.omit(data)
# Impute missing values with median for a specific column
data$Age[is.na(data$Age)] <- median(data$Age, na.rm = TRUE)

#Outlier Detection
Q1 <- quantile(data$Age, 0.25)
Q3 <- quantile(data$Age, 0.75)
IQR_value <- Q3 - Q1

# Filter out outliers
data_clean <- data[data$Age >= (Q1 - 1.5 * IQR_value) & data$Age <= (Q3 + 1.5 * IQR_value), ]

#Data Transformation
#Standardization:
data$Age_standardized <- scale(data$Age)
#Log Transformation:
data$Purchased_log <- log(data$Purchased + 1)  # Adding 1 to avoid log(0)
#Data Cleaning:
# Standardize categorical values (example: fixing "yes" and "Yes")
data$Gender <- tolower(data$Gender)


#4. Feature Engineering
#Customer Lifetime Value (CLV): If you have purchase history, you can calculate CLV as a combination of frequency and monetary value:
# Example: CLV = Frequency * Average Purchase Amount
 data$Frequency * data$AvgPurchased

#Recency, Frequency, Monetary (RFM)
 # Example feature creation: Recency based on the last purchase date
as.numeric(difftime(Sys.Date(), as.Date(data$LastPurchaseDate), units = "days"))
 
