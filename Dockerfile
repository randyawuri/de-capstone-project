FROM apache/airflow:2.9.3

USER root

# Install system packages
RUN apt-get update && apt-get install -y \
    gcc \
    python3-dev

COPY /airflow/dags/scripts/script.sh /opt/airflow/dags/scripts/script.sh
RUN chmod 755 /opt/airflow/dags/scripts/script.sh
    
USER airflow

COPY requirements.txt /requirements.txt
RUN pip install --upgrade pip
RUN pip install --no-cache-dir -r /requirements.txt


# install dbt into a venv to avoid package dependency conflicts
WORKDIR "/opt/airflow/"
COPY dbt-requirements.txt ./
COPY /de_capstone_project/profiles.yml /opt/airflow/de_capstone_project/.dbt/profiles.yml
RUN python -m virtualenv dbt_venv && source dbt_venv/bin/activate && \
    pip install --no-cache-dir -r dbt-requirements.txt && deactivate

