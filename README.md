# AWS-Flutter-integration

## Objective
A gist and workaround of how to send and receive data from Flutter apps to AWS services S3 and DynamoDB.There are many flutter plugins that help in this application. But the catch is they make use of your Access Key and Secret Key. You can have a look at the significance of these keys <a href='https://docs.aws.amazon.com/powershell/latest/userguide/pstools-appendix-sign-up.html'>here</a>. 

Compromising this can make your account vulnerable thereby enabling access to whoever gets hands on these. In this application, I have done this in a possible secure using AWS lambda and API Gateway services.


## Procedure
### S3
For S3 to undergo this, you simply have to do the following, 
- Open your S3 bucket in AWS console and click on Permissions tab. You will see something like this.
![S3 specs 1](https://user-images.githubusercontent.com/98028588/169341570-9ace2feb-db39-409a-b2e3-d0deba2cc107.PNG)
- Click on the Edit and uncheck 'Block all public access' if it is checked(We will revert this back later as keeping this unchecked is not a good option). If it is unchecked go to the next step.
- Click Save changes.
- Now come down where you see another Edit under 'Bucket policy' section.
![S3 specs 2](https://user-images.githubusercontent.com/98028588/169342374-602dcea0-4782-4527-a439-a7cac1b7ca0e.PNG)
- Go back to 1st Step and check the 'Block all public access' box.

- Click Edit and inside the policy box where you see some lines of code. Try editing or replacing the code with the below code,
```{
	"Version": "2012-10-17",
	"Statement": [
		{
			"Sid": "Statement1",
			"Effect": "Allow",
			"Principal": "*",
			"Action": "s3:*",
			"Resource": "arn:aws:s3:::poleclimberhistory"
		}
	]
}
```
- You're done here. DynamoDB doesn't require all this, it goes fine with basic implementation.

### Lambda
- You can see three files here.
   - dynamodbget.js (Node.js 16.x)
   - dynamodbput.js (Node.js 16.x)
   - s3uploadandget.py (Python 3.x)

- As the file formats suggests try creating the lambda function respectively keeping the formats in mind in AWS Lambda console. 
- Choose Architecture as arm64 while creating.
![archi](https://user-images.githubusercontent.com/98028588/169345508-a96c0741-d39f-406c-9c53-f968f127ac86.PNG)
- Give basic S3 and Dynamodb permissions.

### API Gateway
- Create two functions in API Gateway(1 for dynamodb and 1 for S3).
- Create Resource for those two functions.
- Create two methods for dynamodb (get and put) whereas one method for S3 is enough.
- Link the lambda functions respectively.(*While calling the URL's in your dart file adding the  *)


## Run
Check the api links with postman if it is working or not.
- The functions in apicalls.dart is standard. 
- You can place this file in your project and use them in your code. 
- All you need to do is put the API links accordingly in each function.







