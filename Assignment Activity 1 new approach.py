#!/usr/bin/env python
# coding: utf-8

# In[2]:


# Import necessary libraries
import pandas as pd
import numpy as np
import statsmodels.api as sm
import matplotlib.pyplot as plt 
from statsmodels.formula.api import ols


# In[3]:


# Load the dataset
reviews = pd.read_csv('turtle_reviews.csv')

# Explore the dataset
print(reviews.head())
print(reviews.dtypes)
print(reviews.info())

# Check for missing values
print(reviews.isnull().sum())

# Drop redundant columns
reviews.drop(['language', 'platform'], axis=1, inplace=True)

# Rename columns
reviews.rename(columns={'remuneration (k£)': 'renumeration', 'spending_score (1-100)': 'spending_score'}, inplace=True)



reviews.to_csv('cleaned_reviews.csv', index=False)

clean_reviews = pd.read_csv('cleaned_reviews.csv')
print(clean_reviews.shape)
print(clean_reviews.info())


# In[4]:


# Extract the relevant columns
X_renumeration = clean_reviews[['renumeration']]
X_spending_score = clean_reviews[['spending_score']]
X_age = clean_reviews[['age']]
y = clean_reviews['loyalty_points']

plt.scatter(X_renumeration, y)
plt.scatter(X_spending_score, y)
plt.scatter(X_age, y)


# In[5]:


# Create formula and pass through OLS methods.
f = 'y ~ X_renumeration'
test = ols(f, data = clean_reviews).fit()

# Print the regression table.
print(test.summary())

# Extract the estimated parameters.
print("Parameters: ", test.params)  

# Extract the standard errors.
print("Standard errors: ", test.bse)  

# Extract the predicted values.
print("Predicted values: ", test.predict()) 

y_pred = (-65.6865) + 34.1878 * clean_reviews['renumeration']
y_pred

# Plot the data points with a scatterplot.
plt.scatter(X_renumeration, y)

# Plot the regression line (in black).
plt.plot(X_renumeration, y_pred, color='black')

# Set the x and y limits on the axes.
plt.xlim(0)
plt.ylim(0)

# View the plot.
plt.show()


# In[6]:


# Create formula and pass through OLS methods.
f = 'y ~ X_spending_score'
test = ols(f, data = clean_reviews).fit()

# Print the regression table.
print(test.summary())

# Extract the estimated parameters.
print("Parameters: ", test.params)  

# Extract the standard errors.
print("Standard errors: ", test.bse)  

# Extract the predicted values.
print("Predicted values: ", test.predict()) 

y_pred = (-75.0527) + 33.0617 * clean_reviews['spending_score']
y_pred

# Plot the data points with a scatterplot.
plt.scatter(X_spending_score, y)

# Plot the regression line (in black).
plt.plot(X_spending_score, y_pred, color='black')

# Set the x and y limits on the axes.
plt.xlim(0)
plt.ylim(0)

# View the plot.
plt.show()


# In[7]:


# Create formula and pass through OLS methods.
f = 'y ~ X_age'
test = ols(f, data = clean_reviews).fit()

# Print the regression table.
print(test.summary())

# Extract the estimated parameters.
print("Parameters: ", test.params)  

# Extract the standard errors.
print("Standard errors: ", test.bse)  

# Extract the predicted values.
print("Predicted values: ", test.predict()) 

y_pred = (1736.5177) + -4.0128 * clean_reviews['age']
y_pred

# Plot the data points with a scatterplot.
plt.scatter(X_age, y)

# Plot the regression line (in black).
plt.plot(X_age, y_pred, color='black')

# Set the x and y limits on the axes.
plt.xlim(0)
plt.ylim(0)

# View the plot.
plt.show()


# In[ ]:




