<template>
  <h1>Resources</h1>

  <h2>S3</h2>
  <ul>
    <li v-for="bucket in s3Buckets">
      {{ bucket }}
    </li>
  </ul>

  <h2>SQS</h2>
  <ul>
    <li v-for="url in sqsUrls">
      {{ url }}
    </li>
  </ul>

  <h2>Lambda</h2>
  <ul>
    <li v-for="lambda in lambdas">
      {{ lambda }}
    </li>
  </ul>

  <h2>DynamoDB Tables</h2>
  <ul>
    <li v-for="table in dynamoDBTables">
      {{ table }}
    </li>
  </ul>

  <h2>DynamoDB Query Result</h2>
  <code>{{ scanResult }}</code>


</template>

<script>
import {SQS, S3, Lambda, DynamoDB} from 'aws-sdk';

export default {
  name: 'App',
  data() {
    return {
      awsParams: {
        endpoint: process.env.AWS_ENDPOINT || 'http://localhost:4566',
        region: 'us-east-1',
        credentials: {
          accessKeyId: 'localstack',
          secretAccessKey: 'localstackSecret',
        },
      },
      s3Buckets: [],
      sqsUrls: [],
      lambdas: [],
      dynamoDBTables: [],
      scanResult: '',
    };
  },
  async created() {
    await Promise.all([
      this.loadS3(),
      this.loadSqs(),
      this.loadLambda(),
      this.loadDynamoDB(),
    ]);
    await this.loadDynamoDBScan();
  },
  methods: {
    async loadS3() {
      const s3 = new S3(this.awsParams);

      try {
        const result = await s3.listBuckets().promise();
        this.s3Buckets = result.Buckets.map((bucket) => bucket.Name);
      } catch (error) {
        console.log(error);
      }
    },
    async loadSqs() {
      const sqs = new SQS(this.awsParams);

      try {
        const result = await sqs.listQueues().promise();
        this.sqsUrls = result.QueueUrls;
      } catch (error) {
        console.log(error);
      }
    },
    async loadLambda() {
      const lambda = new Lambda(this.awsParams);

      try {
        const result = await lambda.listFunctions().promise();
        this.lambdas = result.Functions.map((lambda) => lambda.FunctionName);
      } catch (error) {
        console.log(error);
      }
    },
    async loadDynamoDB() {
      const dynamoDB = new DynamoDB(this.awsParams);

      try {
        const result = await dynamoDB.listTables().promise();
        this.dynamoDBTables = result.TableNames;
      } catch (error) {
        console.log(error);
      }
    },
    async loadDynamoDBScan() {
      const documentClient = new DynamoDB.DocumentClient(this.awsParams);

      try {
        const params = {
          TableName: this.dynamoDBTables[0],
        };
        const result = await documentClient.scan(params).promise();
        this.scanResult = JSON.stringify(result, null, 4);
      } catch (error) {
        console.log(error);
      }
    }
  }
}
</script>

<style>
h1, h2, p {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}
</style>
