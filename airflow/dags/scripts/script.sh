#!/bin/bash

# Step 1: Activate the DBT virtual environment
source /opt/airflow/dbt_venv/bin/activate

# Step 2: Navigate to the DBT project directory
cd /opt/airflow/de_capstone_project

# Step 3: Run the DBT models
dbt run

# Step 4: Deactivate the virtual environment
deactivate

# Step 5: Print a success message
echo "DBT models have been successfully run."
