import boto3
import os
import datetime
import shutil
s3_list=os.environ["S3_BACKUP_TARGETS"]
backup_s3=os.environ["BACKUP_S3"]
client = boto3.client('s3')
for s3 in s3_list.split(","):
    response = client.list_objects(
        Bucket=backup_s3,
        Prefix="backup-{}".format(s3)
    )
    dict_of_keys={}
    try:
        for ob in response["Contents"]:
            print(ob["Key"])
            print(ob["LastModified"])
            dict_of_keys[ob["LastModified"]]=ob["Key"]

        for ob in sorted(dict_of_keys.items(),reverse=True)[5:]:
            response = client.delete_object(
                Bucket=backup_s3,
                Key=ob[1]
            )   
    except:
        pass
    os.chdir("/data")
    try:
        shutil.rmtree("backup-s3-{}".format(s3))
    except:
        pass
    os.mkdir("backup-s3-{}".format(s3))
    os.system("aws s3 sync s3://{} backup-s3-{}".format(s3,s3))
    backup_name=str(datetime.datetime.now().strftime("%m-%d-%Y"))
    shutil.make_archive("backup-{}-{}".format(s3,backup_name), 'zip', "backup-s3-{}".format(s3))
    client.upload_file("backup-{}-{}.zip".format(s3,backup_name), backup_s3, "backup-{}-{}.zip".format(s3,backup_name))
    shutil.rmtree("backup-s3-{}".format(s3))
    os.remove("backup-{}-{}.zip".format(s3,backup_name))


    
