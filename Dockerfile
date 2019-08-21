FROM ubuntu

LABEL version="0.0.1"

LABEL com.github.actions.name="CloudFormation Deploy Action"
LABEL com.github.actions.description="Deploy AWS CloudFormation Stack"
LABEL com.github.actions.icon="upload-cloud"
LABEL com.github.actions.color="orange"

LABEL repository="https://github.com/mgenteluci/cloudformation-deploy-action"
LABEL homepage="https://github.com/mgenteluci/cloudformation-deploy-action"
LABEL maintainer="Matheus Genteluci <mgenteluci97@gmail.com>"

RUN apt-get update -y && apt-get install awscli -y

ADD entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
