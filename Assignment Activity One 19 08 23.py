#!/usr/bin/env python
# coding: utf-8

# In[1]:


# Import necessary libraries
import pandas as pd
import numpy as np
import statsmodels.api as sm
import matplotlib.pyplot as plt


# In[2]:


# Load the dataset
reviews = pd.read_csv('turtle_reviews.csv')

# Explore the dataset
print(reviews.head())
print(reviews.dtypes)
print(reviews.info())


# In[3]:


# Check for missing values
print(reviews.isnull().sum())


# In[4]:


# Display descriptive statistics
print(reviews.describe())


# In[5]:


# Drop redundant columns
reviews.drop(['language', 'platform'], axis=1, inplace=True)

# Rename columns
reviews.rename(columns={'remuneration (k£)': 'renumeration', 'spending_score (1-100)': 'spending_score'}, inplace=True)


# In[14]:


reviews.to_csv('cleaned_reviews.csv', index=False)

clean_reviews = pd.read_csv('cleaned_reviews.csv')
print(clean_reviews.shape)
print(clean_reviews.info())

X = reviews[['age', 'renumeration', 'spending_score']]
y = reviews['loyalty_points']

X = sm.add_constant(X)

model = sm.OLS(y, X).fit()

parameters = model.params
std_errors = model.bse
predicted_values = model.predict(X)

regression_table = pd.DataFrame({'Coefficients': parameters, 'Standard Errors': std_errors})
print(regression_table)

plt.scatter(y, predicted_values)
plt.plot([y.min(), y.max()], [y.min(), y.max()], linestyle='--', color='red', linewidth=2)
plt.xlabel('Actual Loyalty Points')
plt.ylabel('Predicted Loyalty Points')
plt.title('Linear Regression: Actual vs. Predicted Loyalty Points')
plt.show()


# In[ ]:




