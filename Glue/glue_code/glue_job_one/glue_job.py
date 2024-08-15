from awsglue.context import GlueContext
from pyspark.context import SparkContext
from awsglue.utils import getResolvedOptions
from awsglue.dynamicframe import DynamicFrame
import sys

# Obtener los argumentos pasados al Job
args = getResolvedOptions(sys.argv, ['JOB_NAME', 's3_input_path'])
s3_input_path = args['s3_input_path']

# Configuración de Spark y Glue
sc = SparkContext()
glueContext = GlueContext(sc)
spark = glueContext.spark_session

# Leer datos desde S3 en un DynamicFrame
datasource = glueContext.create_dynamic_frame.from_options(
    connection_type="s3",
    connection_options={"paths": [s3_input_path]},
    format="csv",
    format_options={"withHeader": True, "separator": ","},  # Manejar encabezados
    transformation_ctx="datasource"
)

# Convertir DynamicFrame a DataFrame
df = datasource.toDF()

# Verificar nombres de columnas
df.printSchema()

# Convertir DataFrame de nuevo a DynamicFrame
dynamic_frame = DynamicFrame.fromDF(df, glueContext, "dynamic_frame")

# Escribir datos en DynamoDB
glueContext.write_dynamic_frame.from_options(
    frame=dynamic_frame,
    connection_type="dynamodb",
    connection_options={
        "tableName": "Customers",
        "writeCapacityUnits": "5"  # Ajusta según la capacidad de escritura que necesites
    },
    transformation_ctx="sink"
)