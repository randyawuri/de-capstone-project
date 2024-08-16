from airflow.decorators import dag
from datetime import datetime
from airflow.providers.google.cloud.transfers.postgres_to_gcs import PostgresToGCSOperator
# from airflow.providers.google.cloud.operators.bigquery import BigQueryCreateEmptyDatasetOperator


POSTGRES_CONN = "postgres_id"
GOOGLE_CLOUD_CONN = "gcp_id"

@dag(start_date=datetime(2024, 8, 13), schedule="@daily", template_searchpath=["/opt/airflow/sql"], catchup=False)
def extract_from_postgres_to_gcp():

    customertb_to_gcs = PostgresToGCSOperator(
        task_id="customertb_to_gcs",
        postgres_conn_id=POSTGRES_CONN,
        sql="load_customer.sql",
        bucket="de_capstone_project_bucket",
        filename="customers",
        gcp_conn_id=GOOGLE_CLOUD_CONN,
        export_format="csv",
        write_on_empty=False,
    )

    # geolocationtb_to_gcs = PostgresToGCSOperator(
    #     task_id="geolocationtb_to_gcs",
    #     postgres_conn_id=POSTGRES_CONN,
    #     sql="load_geolocation.sql",
    #     bucket="de_capstone_project_bucket",
    #     filename="geolocation",
    #     gcp_conn_id=GOOGLE_CLOUD_CONN,
    #     export_format="csv",
    #     write_on_empty=False,
    # )

    order_itemstb_to_gcs = PostgresToGCSOperator(
        task_id="order_itemstb_to_gcs",
        postgres_conn_id=POSTGRES_CONN,
        sql="load_order_items.sql",
        bucket="de_capstone_project_bucket",
        filename="order_items",
        gcp_conn_id=GOOGLE_CLOUD_CONN,
        export_format="csv",
        write_on_empty=False,
    )

    order_paymenttb_to_gcs = PostgresToGCSOperator(
        task_id="order_paymenttb_to_gcs",
        postgres_conn_id=POSTGRES_CONN,
        sql="load_order_payment.sql",
        bucket="de_capstone_project_bucket",
        filename="order_payments",
        gcp_conn_id=GOOGLE_CLOUD_CONN,
        export_format="csv",
        write_on_empty=False,
    )

    # order_reviewtb_to_gcs = PostgresToGCSOperator(
    #     task_id="order_reviewtb_to_gcs",
    #     postgres_conn_id=POSTGRES_CONN,
    #     sql="load_order_review.sql",
    #     bucket="de_capstone_project_bucket",
    #     filename="order_review",
    #     gcp_conn_id=GOOGLE_CLOUD_CONN,
    #     export_format="csv",
    #     write_on_empty=False,
    # )

    orderstb_to_gcs = PostgresToGCSOperator(
        task_id="orderstb_to_gcs",
        postgres_conn_id=POSTGRES_CONN,
        sql="load_orders.sql",
        bucket="de_capstone_project_bucket",
        filename="orders",
        gcp_conn_id=GOOGLE_CLOUD_CONN,
        export_format="csv",
        write_on_empty=False,
    )

    # product_categorytb_to_gcs = PostgresToGCSOperator(
    #     task_id="product_categorytb_to_gcs",
    #     postgres_conn_id=POSTGRES_CONN,
    #     sql="load_product_category.sql",
    #     bucket="de_capstone_project_bucket",
    #     filename="product_category",
    #     gcp_conn_id=GOOGLE_CLOUD_CONN,
    #     export_format="csv",
    #     write_on_empty=False,
    # )

    productstb_to_gcs = PostgresToGCSOperator(
        task_id="productstb_to_gcs",
        postgres_conn_id=POSTGRES_CONN,
        sql="load_products.sql",
        bucket="de_capstone_project_bucket",
        filename="products",
        gcp_conn_id=GOOGLE_CLOUD_CONN,
        export_format="csv",
        write_on_empty=False,
    )

    sellerstb_to_gcs = PostgresToGCSOperator(
        task_id="sellerstb_to_gcs",
        postgres_conn_id=POSTGRES_CONN,
        sql="load_seller.sql",
        bucket="de_capstone_project_bucket",
        filename="sellers",
        gcp_conn_id=GOOGLE_CLOUD_CONN,
        export_format="csv",
        write_on_empty=False,
    )


    customertb_to_gcs >> order_itemstb_to_gcs >> orderstb_to_gcs >> order_paymenttb_to_gcs >> productstb_to_gcs >> sellerstb_to_gcs ##>> geolocationtb_to_gcs


extract_from_postgres_to_gcp()
