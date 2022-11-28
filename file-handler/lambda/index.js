const AWS = require('aws-sdk');

exports.handler = async function(event) {
    console.log(`Received new event: ${JSON.stringify(event)}`);

    const s3Event = JSON.parse(event.Records[0].body);
    const fileName = s3Event.Records[0].s3.object.key;
    const documentClient = new AWS.DynamoDB.DocumentClient({
        // IMPORTANT, use LOCALSTACK_HOSTNAME in endpoint
        endpoint: process.env.AWS_ENDPOINT || `http://${process.env.LOCALSTACK_HOSTNAME}:4566`,
        region: 'us-east-1',
        credentials: {
            accessKeyId: 'localstack',
            secretAccessKey: 'localstackSecret',
        },
    });
    const dynamoDBTableName = process.env.DYNAMO_DB_TABLE_NAME || 'localstack-files';
    const params = {
        TableName: dynamoDBTableName,
        Item: {
            Id: fileName,
            CreatedAt: Date.now(),
        },
    };

    try {
        console.log(`Saving DynamoDB item: ${JSON.stringify(params.Item)}`);
        const result = await documentClient.put(params).promise();
        console.log(`Saved DynamoDB item: ${params.Item.Id}`);

        return result;
    } catch (error) {
        console.log(`Error: ${JSON.stringify(error)}`);
        throw error;
    }
}
