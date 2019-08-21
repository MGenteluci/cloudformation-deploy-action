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
    - uses: mgenteluci/cloudformation-deploy-action@v1
      env:
        TEMPLATE: 'template.yml'
        AWS_STACK_NAME: 'my-stack'
        AWS_REGION: 'us-east-1'
        AWS_ACCESS_KEY_ID: ${{ secrets.AWS_ACCESS_KEY_ID }}
        AWS_SECRET_ACCESS_KEY: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
        AWS_DEPLOY_BUCKET: ${{ secrets.AWS_DEPLOY_BUCKET }}
```
