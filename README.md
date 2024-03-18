# Statistics for Business Analytics I

## Assignment 2

The data for this assignment are a random sample of 63 cases from the files of a big real estate agency in the USA concerning house sales from February 15 to April 30, 1993. The data was collected from many cities (and corresponding local real estate agencies) and is used as a basis for the whole company. The variables in this dataset are:

1. PRICE = Selling prices (in hundreds$)
2. SQFT = Square Feet of living space
3. AGE = Age of home (in years)
4. FEATS = Number out of 11 features (dishwasher, refrigerator, microwave, disposer, washer, intercom, skylight(s), compactor, dryer, handicap fit, cable TV access
5. NE = Located in northeast sector of city (1) or not (0)
6. COR = Corner location (1) or not (0).

### Tasks

1. **Read and Understand the Dataset**
    - Read the "usdata" dataset and use `str()` to understand its structure.

2. **Variable Conversion**
    - Convert the variables PRICE, SQFT, AGE, FEATS to be numeric variables and NE, COR to be factors.

3. **Descriptive Analysis and Visualization**
    - Perform descriptive analysis and visualization for each variable to get an initial insight into what the data looks like. Comment on your findings.

4. **Pairwise Comparisons**
    - Conduct pairwise comparisons between the variables in the dataset to investigate if there are any associations implied by the dataset. Plot variables against one another and use correlation plots and measures for the numerical variables. Comment on your findings.

5. **Linear Relationship Analysis**
    - Determine if there is a linear relationship between PRICE and any of the variables in the dataset.

6. **Multiple Regression Modeling**
    - Construct a model for the expected selling prices (PRICE) according to the remaining features. Conduct multiple regression having PRICE as a response and all the other variables as predictors. Evaluate the fit of this linear model to the data. Comment on R^2 adj.

7. **Feature Selection using Stepwise Methods**
    - Find the best model for predicting the selling prices (PRICE). Select the appropriate features using stepwise methods (Forward, Backward, or Stepwise procedure according to AIC or BIC to choose which variables appear to be more significant for predicting selling PRICES).

8. **Final Model Summary**
    - Get the summary of your final model and comment on the output. Interpret the coefficients and discuss the significance of each coefficient. Should the intercept be excluded from our model?

9. **Assumptions Checking**
    - Check the assumptions of your final model. Assess whether the assumptions are satisfied. If not, discuss the impact of the violation of the assumption not satisfied in terms of inference and suggest potential remedies.

10. **LASSO Variable Selection**
    - Conduct LASSO as a variable selection technique and compare the variables that you end up having using LASSO to the variables that you ended up having using stepwise methods. Comment on the comparison.

### Deliverable

A PDF file documenting the process of completing each task along with the interpretation of results, including necessary comments and explanations.
