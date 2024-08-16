from airflow.decorators import dag
from datetime import datetime
from airflow.providers.google.cloud.transfers.gcs_to_bigquery import GCSToBigQueryOperator

POSTGRES_CONN = "postgres_id"
GOOGLE_CLOUD_CONN = "gcp_id"

@dag(start_date=datetime(2024, 8, 15), schedule="@daily", template_searchpath=["/opt/airflow/sql"], catchup=False)
def gcp_to_biquery():

    # GCS to BigQuery tasks
    gcs_customer_to_bigquery = GCSToBigQueryOperator(
        task_id="gcs_customer_to_bigquery",
        bucket="de_capstone_project_bucket",
        source_objects=["customers"],
        destination_project_dataset_table="olist_ecommerce_store.customers",
        write_disposition="WRITE_TRUNCATE",
        external_table=False,
        autodetect=True,
        source_format="CSV",
        gcp_conn_id=GOOGLE_CLOUD_CONN,
    )

    # gcs_geolocation_to_bigquery = GCSToBigQueryOperator(
    #     task_id="gcs_geolocation_to_bigquery",
    #     bucket="de_capstone_project_bucket",
    #     source_objects=["geolocation"],
    #     destination_project_dataset_table="olist_ecommerce_store.geolocation",
    #     write_disposition="WRITE_TRUNCATE",
    #     external_table=False,
    #     autodetect=True,
    #     source_format="CSV",
    #     gcp_conn_id=GOOGLE_CLOUD_CONN,
    # )

    gcs_order_items_to_bigquery = GCSToBigQueryOperator(
        task_id="gcs_order_items_to_bigquery",
        bucket="de_capstone_project_bucket",
        source_objects=["order_items"],
        destination_project_dataset_table="olist_ecommerce_store.order_items",
        write_disposition="WRITE_TRUNCATE",
        external_table=False,
        autodetect=True,
        source_format="CSV",
        gcp_conn_id=GOOGLE_CLOUD_CONN,
    )

    gcs_order_payments_to_bigquery = GCSToBigQueryOperator(
        task_id="gcs_order_payments_to_bigquery",
        bucket="de_capstone_project_bucket",
        source_objects=["order_payments"],
        destination_project_dataset_table="olist_ecommerce_store.order_payments",
        write_disposition="WRITE_TRUNCATE",
        external_table=False,
        autodetect=True,
        source_format="CSV",
        gcp_conn_id=GOOGLE_CLOUD_CONN,
    )

    # gcs_order_reviews_to_bigquery = GCSToBigQueryOperator(
    #     task_id="gcs_order_reviews_to_bigquery",
    #     bucket="de_capstone_project_bucket",
    #     source_objects=["order_review"],
    #     destination_project_dataset_table="olist_ecommerce_store.order_reviews",
    #     write_disposition="WRITE_TRUNCATE",
    #     external_table=False,
    #     autodetect=True,
    #     source_format="CSV",
    #     gcp_conn_id=GOOGLE_CLOUD_CONN,
    # )

    gcs_orders_to_bigquery = GCSToBigQueryOperator(
        task_id="gcs_orders_to_bigquery",
        bucket="de_capstone_project_bucket",
        source_objects=["orders"],
        destination_project_dataset_table="olist_ecommerce_store.orders",
        write_disposition="WRITE_TRUNCATE",
        external_table=False,
        autodetect=True,
        source_format="CSV",
        gcp_conn_id=GOOGLE_CLOUD_CONN,
    )

    # gcs_product_category_to_bigquery = GCSToBigQueryOperator(
    #     task_id="gcs_product_category_to_bigquery",
    #     bucket="de_capstone_project_bucket",
    #     source_objects=["product_category"],
    #     destination_project_dataset_table="olist_ecommerce_store.product_category",
    #     write_disposition="WRITE_TRUNCATE",
    #     external_table=False,
    #     autodetect=True,
    #     source_format="CSV",
    #     gcp_conn_id=GOOGLE_CLOUD_CONN,
    # )

    gcs_products_to_bigquery = GCSToBigQueryOperator(
        task_id="gcs_products_to_bigquery",
        bucket="de_capstone_project_bucket",
        source_objects=["products"],
        destination_project_dataset_table="olist_ecommerce_store.products",
        write_disposition="WRITE_TRUNCATE",
        external_table=False,
        autodetect=True,
        source_format="CSV",
        gcp_conn_id=GOOGLE_CLOUD_CONN,
    )

    gcs_sellers_to_bigquery = GCSToBigQueryOperator(
        task_id="gcs_sellers_to_bigquery",
        bucket="de_capstone_project_bucket",
        source_objects=["sellers"],
        destination_project_dataset_table="olist_ecommerce_store.sellers",
        write_disposition="WRITE_TRUNCATE",
        external_table=False,
        autodetect=True,
        source_format="CSV",
        gcp_conn_id=GOOGLE_CLOUD_CONN,
    )

    gcs_customer_to_bigquery >> gcs_order_items_to_bigquery >> gcs_order_payments_to_bigquery >> gcs_orders_to_bigquery >> gcs_products_to_bigquery >> gcs_sellers_to_bigquery

gcp_to_biquery()
