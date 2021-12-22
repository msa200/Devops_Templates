import json
import boto3
import logging
import json
import sys
import random
import requests
import time

logger = logging.getLogger()
logger.setLevel(logging.INFO)
dynamodb = boto3.resource('dynamodb')
table = dynamodb.Table('deployment-status')
def lambda_handler(event, context):
    if "eventName" in event["detail"].keys():
        logger.info(event)
        if event["detail"]["eventName"]=="SERVICE_DEPLOYMENT_COMPLETED":
            title=event["resources"][0].split("/")[2]
            table.put_item(Item= {'service_name': title,"status":"SERVICE_DEPLOYMENT_COMPLETED"})
        if event["detail"]["eventName"]=="SERVICE_STEADY_STATE":
            time.sleep(5)
            title=event["resources"][0].split("/")[2]
            response = table.get_item(Key={'service_name': title})
            logger.info("#############################")
            logger.info(response)
            if response['Item']["status"]=="SERVICE_DEPLOYMENT_COMPLETED":
                table.put_item(Item= {'service_name': title,"status":"SERVICE_STEADY_STATE"})
                resp=send_slack("Deployed :tada:","{}/Development".format(title),"#66ff66")
                logger.info("**********************************")
                logger.info(resp.text)
    #     if current=="PROVISIONING":
    #         resp=send_slack("{}".format(current),title,"#ffff00")
    #     elif current=="PENDING":
    #         resp=send_slack("{}".format(current),title,"#66ffff")
    #     elif current=="RUNNING":
    #         
    #     else:
    #         resp=send_slack("{}".format(current),title,"#ff6666")
        
# slack

def send_slack(message,title,color):
    url = ""
    slack_data = {
        "username": "NotificationBot",
        "icon_emoji": ":satellite:",
        #"channel" : "#somerandomcahnnel",
        "attachments": [
            {
                "color": color,
                "fields": [
                    {
                        "title": title,
                        "value": message,
                        "short": "false",
                    }
                ]
            }
        ]
    }
    byte_length = str(sys.getsizeof(slack_data))
    headers = {'Content-Type': "application/json", 'Content-Length': byte_length}
    response = requests.post(url, data=json.dumps(slack_data), headers=headers)
    if response.status_code != 200:
        raise Exception(response.status_code, response.text)
    return response    
