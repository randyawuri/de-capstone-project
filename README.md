```markdown
# Brazilian E-Commerce Data Engineering Project

## Project Overview

This project demonstrates an end-to-end ETL (Extract, Transform, Load) process using a dataset from Kaggle. The project leverages tools such as PostgreSQL, Docker, Docker Compose, Apache Airflow, dbt, and Google BigQuery to enable data end users to answer key analytical questions. The focus is on building a scalable data pipeline that ingests, transforms, and analyzes data to provide actionable insights.

## Project Structure

```
├── airflow/
│   ├── dags/
│   │   ├── extract_from_postgres_to_gcp.py
│   │   ├── gcp_to_bigquery.py
│   │   └── running_dbt_models_dag.py
│   ├── scripts/
│   │   └── script.sh
│   ├── config/
│   ├── gcp/
│   └── service_account.json
├── dbt/
│   ├── de_capstone_project/
│   │   ├── models/
│   │   │   ├── final_model/
│   │   │   │   ├── fct_sales_by_category.sql
│   │   │   │   ├── fct_avg_delivery_time.sql
│   │   │   │   └── fct_orders_by_state.sql
│   │   │   ├── intermediate_model/
│   │   │   │   ├── int_sales_by_category.sql
│   │   │   │   ├── int_avg_delivery_time.sql
│   │   │   │   └── int_orders_by_state.sql
│   │   │   └── staging_model/
│   │   │       ├── stg_customers.sql
│   │   │       ├── stg_products.sql
│   │   │       └── stg_orders.sql
│   └── dbt_project.yml
│   └── profiles.yml
├── source_db/
│   ├── init.sql
│   ├── olist_customers_dataset.csv
│   ├── olist_geolocation_dataset.csv
│   ├── olist_order_items_dataset.csv
│   ├── olist_order_payments_dataset.csv
│   ├── olist_order_reviews_dataset.csv
│   ├── olist_orders_dataset.csv
│   ├── olist_products_dataset.csv
│   ├── olist_sellers_dataset.csv
│   └── product_category_name_translation.csv
├── Dockerfile
├── docker-compose.yml
├── dbt-requirements.txt
├── requirements.txt
└── README.md
```

## Prerequisites

- Docker and Docker Compose installed.
- Python 3.7+ installed.
- Google Cloud Platform (GCP) account with necessary permissions.
- Kaggle account to download the dataset.

## Project Steps

### Step 1: Data Ingestion into PostgreSQL

1. **Clone the Repository**:
   - Clone this repository to your local machine:
     ```sh
     git clone <repository-url>
     ```

2. **Setup Service Account**

   - **Create a Service Account and Generate Key File**:
     - **Create a Bucket and Dataset**:
       - Go to the Google Cloud Console and create a bucket named `de_capstone_project_bucket` Dataset `olist_ecommerce_store`.
     - **Create a Service Account**:
       - Navigate to `IAM & Admin > Service accounts`.
       - Click on **Create Service Account** and fill in the required details.
     - **Generate Key File**:
       - After creating the service account, go to the **Keys** section.
       - Click on **Add key > Create a new key**, select **JSON**, and click **Create**.
       - Save the generated key file locally as `service_account.json`.

   - **Configure Airflow with Service Account**:
     - Move the `service_account.json` file to the Airflow configuration directory:
       ```sh
       mv service_account.json airflow/gcp/service_account.json
       ```
    - create a `.env` file and paste in the project root dir
        `AIRFLOW_UID=50000`

     > **Note**: Ensure the file is placed in the correct directory for Airflow to recognize the service account credentials.

3. **Create Tables**:
   - Use the `init.sql` script to create tables corresponding to each CSV file in the dataset within the PostgreSQL database.

4. **Ingest Data**:
   - Data from the CSV files will be automatically ingested into the PostgreSQL tables upon container startup using the `COPY` commands defined in the `init.sql` script.

### Step 2: Running the Project

To start the project, ensure Docker and Docker Compose are installed. Then run the following commands:

```sh
docker-compose build
docker-compose up -d airflow-init
docker-compose up -d
```

- Access the Airflow UI at [http://localhost:8080](http://localhost:8080) (default credentials: `airflow/airflow`).

- **Configure Connections**:
    - Set up your PostgreSQL and Google Cloud connections.
      - `postgres_id`
      - `gcp_id`
  > **Note**: Wait 5-10 minutes for the Airflow UI to become accessible.

### Step 3: Airflow DAGs

- The DAGs are located in the `airflow/dags/` directory. These DAGs orchestrate the ETL process:
  - **`extract_from_postgres_to_gcp.py`**: Extracts data from PostgreSQL and loads it into Google Cloud Storage (GCS).
  - **`gcp_to_bigquery.py`**: Loads data from GCS into BigQuery.
  - **`running_dbt_models_dag.py`**: Runs dbt models to transform data.

### Step 4: Transforming and Modeling Data with dbt

1. **Setup dbt**:
   - The project is already set up in the `/de_capstone_project/` directory.

2. **Configure dbt**:
   - The `profiles.yml` file is configured to connect dbt to your BigQuery dataset.

3. **Create and Run Models**:
   - dbt models are organized into staging, intermediate, and final models.
   - To run all models, navigate to the dbt project directory and execute:
     ```sh
     dbt run
     ```
   - Alternatively, use the `running_dbt_models_dag.py` DAG in Airflow to automate the execution of dbt models.

### Step 5: Answering Analytical Questions

Based on the domain knowledge of the Brazilian E-Commerce dataset, here are three analytical questions to answer using dbt models:

1. **Which product categories have the highest sales?**
   - **Model**: `fct_sales_by_category.sql`
   - **Explanation**: Aggregates sales by product category to determine the categories with the highest revenue.

2. **What is the average delivery time for orders?**
   - **Model**: `fct_avg_delivery_time.sql`
   - **Explanation**: Calculates the time difference between order purchase and delivery to determine average delivery times.

3. **Which states have the highest number of orders?**
   - **Model**: `fct_orders_by_state.sql`
   - **Explanation**: Counts the number of orders per state to identify regions with the highest order volumes.

## Data Modeling with dbt

### dbt Models

1. **Staging Models**:
   - **`stg_orders.sql`**: Raw orders data with necessary joins.
   - **`stg_order_items.sql`**: Raw order items data with necessary joins.
   - **`stg_products.sql`**: Raw product data.
   - **`stg_customers.sql`**: Raw customer data.
   - **`stg_order_payments.sql`**: Raw payment data.

2. **Intermediate Models**:
   - **`int_sales_by_category.sql`**: Aggregates sales data by product category.
   - **`int_avg_delivery_time.sql`**: Calculates average delivery time for each order.
   - **`int_orders_by_state.sql`**: Counts the number of orders per state.

3. **Final Models**:
   - **`fct_sales_by_category.sql`**: Final sales by category model, providing clean and aggregated sales data.
   - **`fct_avg_delivery_time.sql`**: Final average delivery time model, showing average delivery durations.
   - **`fct_orders_by_state.sql`**: Final orders by state model, giving a summary of orders per state.

### Example dbt Model: `int_sales_by_category.sql`

This model aggregates the sales data by product category, which is then used by the final model to provide insights into which product categories are driving the most revenue.

```sql
with base as (
    select
        o.order_id,
        p.product_category_name,
        sum(oi.price) as total_sales
    from
        {{ ref('stg_orders') }} o
    join
        {{ ref('stg_order_items') }} oi on o.order_id = oi.order_id
    join
        {{ ref('stg_products') }} p on oi.product_id = p.product_id
    group by
        p.product_category_name
)
select
    product_category_name,
    sum(total_sales) as sales_by_category
from
    base
group by
    product_category_name
```

## Project Deliverables

1. **PostgreSQL Scripts**:
   - Scripts to create tables and ingest data are provided in `source_db/init.sql`.

2. **Airflow DAGs**:
   - DAG files to orchestrate the ETL process are located in the `airflow/dags/` directory.

3. **dbt Project**