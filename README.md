# CloudFormation Deploy Action

This action deploys AWS CloudFormation Stacks through yml files.

## Usage

```yml
name: "Deploy CloudFormation Stack"
on: 
  push:
    branches:
    - master

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v1
    - uses: mgenteluci/cloudformation-deploy-action@v1.1.0
      env:
        TEMPLATE: 'template.yml'
        CAPABILITIES: 'CAPABILITY_IAM'
        AWS_STACK_NAME: 'my-stack'
        AWS_REGION: 'us-east-1'
        AWS_ACCESS_KEY_ID: ${{secrets.AWS_ACCESS_KEY_ID}}
        AWS_SECRET_ACCESS_KEY: ${{secrets.AWS_SECRET_ACCESS_KEY}}
        AWS_DEPLOY_BUCKET: ${{secrets.AWS_DEPLOY_BUCKET}}
```

### Environment Variables

* `TEMPLATE` - [Optional]. YML file containing CloudFormation Stack. Default to `template.yml`.
* `CAPABILITIES` - [Optional]. AWS Stack Capabilites. Default to `CAPABILITY_IAM`.
* `AWS_STACK_NAME` - [**Required**]. The Stack name that is going to be published.
* `AWS_REGION` - [**Required**]. AWS Region where to deploy the CloudFormation Stack.
* `AWS_ACCESS_KEY_ID` - [**Required**]. AWS Access Key Id.
* `AWS_SECRET_ACCESS_KEY` - [**Required**]. AWS Secret Access Key.
* `AWS_DEPLOY_BUCKET` - [**Required**]. AWS S3 Bucket where the Stack package is going to be stored.

### Examples

* An implementation example can be found [here](https://github.com/MGenteluci/aws-sqs-cloudformation).

### License

The Dockerfile and associated scripts and documentation in this project are released under the [MIT License](LICENSE).
