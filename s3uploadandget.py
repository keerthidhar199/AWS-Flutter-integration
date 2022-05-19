import json
import boto3
import base64

def lambda_handler(event, context):
    s3=boto3.client('s3')
    bucket_name=event['pathParameters']['bucket']
    file_name=event['queryStringParameters']['file']
    method=event['queryStringParameters']['method']
    lists3 = boto3.resource('s3')
    my_bucket=lists3.Bucket(bucket_name)
    l=[]
    # getting data in s3 bucket

    if(method=='gets3'):
        response=s3.get_object(Bucket=bucket_name,Key=file_name)
        image=base64.b64encode(response['Body'].read())
        return {
            'statusCode': 200,
            'headers':{
                "Content-type":' '
            },
            'body': image
            
        }

# putting data in s3 bucket
    if(method=='puts3'):
        URL=s3.generate_presigned_post(Bucket=bucket_name,Key=file_name,Fields=None,Conditions=None,ExpiresIn=3600)
        return {
            'statusCode': 200,
            'headers':{
                "Content-type":' '
            },
            'body': json.dumps({"URL":URL})}
        
    else:
        return{
             'statusCode': 200,
            'headers':{
                "Content-type":' '
            },
            'body': 'Error'
        }
    

    
    # TODO implement
