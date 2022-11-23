# localstack-examples
Localstack examples for SDK, Terraform and Serverless Framework

##
1. Install Docker
2. Run `docker-compose up -d` to start Localstack
3. Run any example:
4. For SDK
    * go to `./sdk`
    * run `npm install`
    * run `npm run create` to create queue
    * run `npm run delete` to delete queue
5. For Terraform
   * go to `./terraform`
   * install Terraform
   * run `terraform init` to initialize Terraform
   * run `terraform plan` to check resources that will be created
   * run `terraform apply` to create resources
   * run `terraform destroy` to delete resources
6. For Serverless Framework
7. Run `aws --endpoint-url=http://localhost:4566 sqs list-queues` to confirm that queue was created
