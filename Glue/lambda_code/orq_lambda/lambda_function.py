import boto3
import subprocess
import json

def lambda_handler(event, context):


    glue_client = boto3.client('glue')


    s3_event = event['Records'][0]
    bucket = s3_event['s3']['bucket']['name']
    key = s3_event['s3']['object']['key']

    response = glue_client.start_job_run(
        JobName='glue-job-tecnic',
        Arguments={
            '--s3_input_path': f's3://{bucket}/{key}'
        }
    )

    print(event)
    print(response)
    print("hola antonia")
    return {
        'statusCode': 200,
        'body': json.dumps('Termine Bien.!')
    }
