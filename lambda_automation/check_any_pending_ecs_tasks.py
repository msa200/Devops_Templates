import json
import boto3
from botocore.exceptions import ClientError

# this code is used to check number of pending tasks each hour and send email if it is more than 0
# to avoide having a failing task restarting for number of days and causing high cost in ecr and nat
# it is triigered with event bridge as a cron job
def lambda_handler(event, context):
    ##########update API Service##########
    client = boto3.client('ecs')
    response = client.describe_clusters(clusters=[""])
    if response["clusters"][0]["pendingTasksCount"] > 0:

        
        # Replace sender@example.com with your "From" address.
        # This address must be verified with Amazon SES.
        SENDER = ""
        
        # Replace recipient@example.com with a "To" address. If your account 
        # is still in the sandbox, this address must be verified.
        RECIPIENT = ""
        
        # If necessary, replace us-west-2 with the AWS Region you're using for Amazon SES.
        AWS_REGION = "eu-central-1"
        
        # The subject line for the email.
        SUBJECT = "issue with ecs"
        
        # The email body for recipients with non-HTML email clients.
        BODY_TEXT = ("ecs issue pending containers"
                    )
                    
        # The HTML body of the email.
        BODY_HTML = """<html>
        <head></head>
        <body>
          <h1>ECS Issue</h1>
          <p>this email to notify you with issue on ecs dev account</p>
        </body>
        </html>
                    """            
        
        # The character encoding for the email.
        CHARSET = "UTF-8"
        
        # Create a new SES resource and specify a region.
        client = boto3.client('ses',region_name=AWS_REGION)
        
        # Try to send the email.
        try:
            #Provide the contents of the email.
            response = client.send_email(
                Destination={
                    'ToAddresses': [
                        RECIPIENT,
                    ],
                },
                Message={
                    'Body': {
                        'Html': {
                            'Charset': CHARSET,
                            'Data': BODY_HTML,
                        },
                        'Text': {
                            'Charset': CHARSET,
                            'Data': BODY_TEXT,
                        },
                    },
                    'Subject': {
                        'Charset': CHARSET,
                        'Data': SUBJECT,
                    },
                },
                Source=SENDER,
            )
        # Display an error if something goes wrong.	
        except ClientError as e:
            print(e.response['Error']['Message'])
        else:
            print("Email sent! Message ID:"),
            print(response['MessageId'])