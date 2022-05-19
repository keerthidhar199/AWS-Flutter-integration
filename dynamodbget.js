const AWS = require('aws-sdk');
AWS.config.update({ region: "eu-west-1" });
const docClient = new AWS.DynamoDB.DocumentClient({ region: "eu-west-1" });
exports.handler = function(e, ctx, callback) {
    let scanningParameters = {
        TableName: 'history',
        Limit: 100
    };
    docClient.scan(scanningParameters, function(err, data) {
        if (err) {
            callback(err, null);
        } else {
            callback(null, data);
        }
    });
};
// exports.handler = async (event, context) => {
//     const dc = new AWS.DynamoDB.DocumentClient({region:"eu-west-1"}); 
//     const params = {
//         TableName: "history", 
//         KeyConditionExpression: "id=:id", 
//         ExpressionAttributeValues: {":id": event.id} 
//     }; 
//     try {
//         var data = await dc.query(params).promise(); 
//         console.log(data);
//         return data;

//     }
//     catch(err) 
//     {
//         console.log(err); 
//         return err;

//     }
// };