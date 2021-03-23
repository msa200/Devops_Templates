import json
import boto3
# this code is used to update service after any change in parameter store variables. it is triggered
# via cloudwatch event trigger
def lambda_handler(event, context):
    ##########update API Service##########
    client = boto3.client('ecs')
    response = client.update_service(   
        cluster="",
        taskDefinition='',
        desiredCount=2,
        service="",
        networkConfiguration={
        'awsvpcConfiguration': {
            'subnets': [
                '',''
            ],
            'securityGroups': [
                '',
            ],
            'assignPublicIp': ''
        }
    },
    forceNewDeployment=True
)
   