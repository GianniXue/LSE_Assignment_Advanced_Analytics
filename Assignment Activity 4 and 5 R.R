install.packages('tidyverse')
library(tidyverse)
library(dplyr)
library(ggplot2)
library(moments)
library(stats)



# Activity 4
turtle_sales <- read.csv('/Users/giannixue/Documents/turtle_sales.csv')
typeof(turtle_sales)
class(turtle_sales)
dim(turtle_sales)

turtle_sales <- subset(turtle_sales, select = -c(Ranking, Year, Genre, Publisher))
View(turtle_sales)
turtle_sales
summary(turtle_sales)

# EU vs NA Sales by Platform
qplot(NA_Sales,
      EU_Sales,
      colour=Platform,
      data=turtle_sales)

#Activity 5
# 2. Min, Max, Mean and Summary of turtle_sales
summary_stats <- summary(turtle_sales[c("EU_Sales", "NA_Sales", "Global_Sales")])
summary_stats
summary(turtle_sales)

# 3. Determine the impact on sales per product_id
sales_summary <- turtle_sales %>%
  group_by(Product) %>%
  summarize(
    Total_EU_Sales = sum(EU_Sales),
    Total_NA_Sales = sum(NA_Sales),
    Total_Global_Sales = sum(Global_Sales)
  )
summary(sales_summary)

# 4. Create plots to review and determine insights into the data set
# Create scatterplot for EU Sales vs. NA Sales
ggplot(turtle_sales, aes(x = EU_Sales, y = NA_Sales)) +
  geom_point() +
  labs(x = "EU Sales", y = "NA Sales") +
  ggtitle("Scatterplot: EU Sales vs. NA Sales")

# Create histogram for EU Sales
ggplot(turtle_sales, aes(x = EU_Sales)) +
  geom_histogram(binwidth = 1, fill = "blue", color = "black") +
  labs(x = "EU Sales", y = "Frequency") +
  ggtitle("Histogram: EU Sales")

# Create histogram for NA Sales
ggplot(turtle_sales, aes(x = NA_Sales)) +
  geom_histogram(binwidth = 1, fill = "green", color = "black") +
  labs(x = "NA Sales", y = "Frequency") +
  ggtitle("Histogram: NA Sales")

# Create boxplot for Global Sales
ggplot(turtle_sales, aes(y = Global_Sales)) +
  geom_boxplot(fill = "purple", color = "black") +
  labs(y = "Global Sales") +
  ggtitle("Boxplot: Global Sales")

# 5. Determine the normality of the data set (sales data)
# Extract the sales columns from your dataset
sales_data <- turtle_sales[, c("EU_Sales", "NA_Sales", "Global_Sales")]

# Create Q-Q plots for each sales column
ggplot(sales_data, aes(sample = EU_Sales)) + geom_qq() + ggtitle("Q-Q Plot: EU Sales")
ggplot(sales_data, aes(sample = NA_Sales)) + geom_qq() + ggtitle("Q-Q Plot: NA Sales")
ggplot(sales_data, aes(sample = Global_Sales)) + geom_qq() + ggtitle("Q-Q Plot: Global Sales")

# Perform Shapiro-Wilk test on each sales column
shapiro_eu <- shapiro.test(sales_data$EU_Sales)
shapiro_na <- shapiro.test(sales_data$NA_Sales)
shapiro_global <- shapiro.test(sales_data$Global_Sales)

# Print the Shapiro-Wilk test results
cat("Shapiro-Wilk Test for EU Sales:\n")
print(shapiro_eu)
cat("\nShapiro-Wilk Test for NA Sales:\n")
print(shapiro_na)
cat("\nShapiro-Wilk Test for Global Sales:\n")
print(shapiro_global)

# Calculate skewness and kurtosis for each sales column
skewness_eu <- skewness(sales_data$EU_Sales)
kurtosis_eu <- kurtosis(sales_data$EU_Sales)
skewness_na <- skewness(sales_data$NA_Sales)
kurtosis_na <- kurtosis(sales_data$NA_Sales)
skewness_global <- skewness(sales_data$Global_Sales)
kurtosis_global <- kurtosis(sales_data$Global_Sales)

# Print skewness and kurtosis values
cat("\nSkewness and Kurtosis for EU Sales:\n")
cat("Skewness:", skewness_eu, "\n")
cat("Kurtosis:", kurtosis_eu, "\n\n")

cat("Skewness and Kurtosis for NA Sales:\n")
cat("Skewness:", skewness_na, "\n")
cat("Kurtosis:", kurtosis_na, "\n\n")

cat("Skewness and Kurtosis for Global Sales:\n")
cat("Skewness:", skewness_global, "\n")
cat("Kurtosis:", kurtosis_global, "\n\n")

# Calculate correlations between sales columns
correlation_matrix <- cor(sales_data)

# Print the correlation matrix
cat("Correlation Matrix for Sales Data:\n")
print(correlation_matrix)

# 6. Create plots to gain insights into the sales data.
# Create scatterplots with trend lines
ggplot(turtle_sales, aes(x = EU_Sales, y = NA_Sales)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE, color = "red") +
  labs(x = "EU Sales", y = "NA Sales") +
  ggtitle("Scatterplot: EU Sales vs. NA Sales with Trend Line")

ggplot(turtle_sales, aes(x = EU_Sales, y = Global_Sales)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE, color = "blue") +
  labs(x = "EU Sales", y = "Global Sales") +
  ggtitle("Scatterplot: EU Sales vs. Global Sales with Trend Line")

ggplot(turtle_sales, aes(x = NA_Sales, y = Global_Sales)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE, color = "green") +
  labs(x = "NA Sales", y = "Global Sales") +
  ggtitle("Scatterplot: NA Sales vs. Global Sales with Trend Line")


