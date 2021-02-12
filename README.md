# Mid Bootcamp Project - House Price Predictions (Regression)

Sara, Kati & Josie

## Objective

Build a model that will predict the sale price of houses based on features provided in the dataset. Furthermore, analyze which factors are responsible for higher property value ($650K and above) to help Real Estate Agents as well as Investors to understand real estate features and their effect on the market price.

## Dataset

The dataset consists of 20 unique features on about 21,600 properties that were sold between May 2014 and May 2015 in King County, Washington. The dataset can be found in the file "regression_data.csv" and the description of the column names can be found in the "project_details_regression.md" file in folder "04_original_data" in this repository.

## Data Analysis Workflow

### 1. Exploring & Preparing the Data:

o	Understanding the context.

o	Exploring the data, e.g. by using 

  - SQL queries (see file "01_regression_sql_queries")

  - Python codes (see file "02_regression_model_python ")

  - Tableau visualizations (see file "03_regression_tableau_workbook")

o	Cleaning the data.

o	Analyzing the correlation matrix.

### 2. Attempts to Improve the Regression Model:

o	Use log transformation on highly skewed variables (including target).

o	Apply different scaling techniques like StandardScaler, Min-Max-Scaler & Normalizer.

o	Drop variable with highest correlation outside of target.

o	Generate new features based on location, e.g.

  - from latitude and longitude: engineer the distance to Seattle (Downtown) – the closest major city
  - from the zipcode: engineer the city, population density, median household income and median home value
  
o	Group different features, e.g. year renovated, size of living area.

### 3. ‘Raw’ Model vs. Improved Model:

<center> <img src="chart_repo.PNG" alt="Model"> 


## Key Insights

o	Generating new features based on location contributed most to improve our model. 

o	The most important factors responsible for higher property value ($650K and above) are

  - size of living area,

  - grade,

  - size of house (apart from basement) and

  - number of bathrooms.

o	Ideas for future improvement of the model:

  - Generate distance to nearest (smaller) cities.

  - Split into urban, suburban and rural areas.

  - Generate distances to nearest school.

## Deliverables

README.md

01_project_regression_sql_queries.sql

02_project_regression_model_python.ipynb

03_project_regression_tableau_workbook.twbx

04_original_data
