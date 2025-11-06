import os 
from datetime import datetime

from cosmos import DbtDag, ProjectConfig, ProfileConfig, ExecutionConfig
from cosmos.profiles import SnowflakeUserPasswordProfileMapping

# Cóm conectarse a mi perfil de SnowFlake

profile_config = ProfileConfig(
    profile_name="etl_project",
    target_name="dev",
    profile_mapping=SnowflakeUserPasswordProfileMapping(
        conn_id="snowflake_conn", 
        profile_args={"database": "dbt_db_elt", "schema": "kaggle_raw"},
    )
)

# Dónde estan los modelos en el Docker
dbt_project_path = f"{os.environ['AIRFLOW_HOME']}/dags/elt_ecom"

project_config = ProjectConfig(
    dbt_project_path = dbt_project_path
)

# Cómo ejecutar los modelos del docker

dbt_execution_config = ExecutionConfig(
    dbt_executable_path=f"{os.environ['AIRFLOW_HOME']}/dbt_venv/bin/dbt",
)

# DAG

dbt_pipeline_dag = DbtDag(
    
    # Condifguración del dag    
    project_config=project_config,
    profile_config=profile_config,
    execution_config=dbt_execution_config,
    
    operator_args={"install_deps": True}, 
    
    # Cuando ejecutar
    schedule="@daily",
    start_date = datetime(2025, 10, 29),
    catchup=False,
    dag_id="pipeline-ecom", 
)
