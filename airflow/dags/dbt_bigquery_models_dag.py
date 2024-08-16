from datetime import datetime, timedelta
from airflow import DAG
from airflow.operators.bash import BashOperator


default_args = {
    'owner': 'airflow',
    'depends_on_past': False,
    'start_date': datetime(2024, 8, 15),
    'retries': 1,
    'retry_delay': timedelta(minutes=5),
}


with DAG(
    default_args=default_args,
    dag_id='un_models_from_script',
    start_date=datetime(2021, 11, 1),
    schedule_interval='@daily',
) as dag:
    run_models_from_script = BashOperator(
        task_id='task1',
        bash_command="bash ./opt/airflow/dags/scripts/script.sh"
    )
    run_models_from_script

