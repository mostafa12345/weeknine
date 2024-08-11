import boto3
import os

def lambda_handler(event, context):
    ssm_client = boto3.client('ssm')

    # Get SSM Document name from environment variables
    document_name = os.environ['SSM_DOCUMENT_NAME']
    
    # Get EC2 instance ID from environment variables
    instance_id = os.environ['EC2_INSTANCE_ID']
    
    try:
        # Invoke the SSM Document
        response = ssm_client.send_command(
            InstanceIds=[instance_id],
            DocumentName=document_name
        )
        
        command_id = response['Command']['CommandId']
        print(f"SSM Command sent. Command ID: {command_id}")
        
        return {
            'statusCode': 200,
            'body': f"SSM Command sent successfully. Command ID: {command_id}"
        }
        
    except Exception as e:
        print(f"An error occurred: {str(e)}")
        return {
            'statusCode': 500,
            'body': f"An error occurred: {str(e)}"
        }

