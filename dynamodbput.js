const AWS = require('aws-sdk'); 
AWS.config.update({region:"eu-west-1"}); 
const docClient = new AWS.DynamoDB.DocumentClient();

async function createItem(getid,getinfo){
  try {
      const params = {
          TableName : 'history',
          Item: {
              id: getid,
              data: getinfo
          }
      };
    await docClient.put(params).promise();
  }
  catch (err)
  {
      return err;
  }
}

exports.handler = async (event) => {
  try
  {
      await createItem(event.id,event.info);
      return { body: 'Successfully created item!' };
  }
  catch (err)
  {
      return { error: err };
  }
};