From python:3.8
RUN apt update -y
RUN pip install boto3
RUN apt install awscli -y
RUN mkdir backup
RUN mkdir /data
COPY s3-backup.py backup/s3-backup.py
CMD ["python", "backup/s3-backup.py"]
