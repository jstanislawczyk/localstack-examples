(async () => {
    const AWS = require("aws-sdk");
    const sqs = new AWS.SQS({
        endpoint: process.env.AWS_ENDPOINT || 'http://localhost:4566',
        region: 'us-east-1',
        credentials: {
            accessKeyId: 'localstack',
            secretAccessKey: 'localstackSecret',
        },
    });
    const params = {
        QueueName: 'sdk-test-queue',
    };

    try {
        const result = await sqs.createQueue(params).promise();
        console.log(`Queue created: ${JSON.stringify(result)}`);
    } catch (error) {
        console.log(error);
    }
})();

