CIDR=$(dig +short myip.opendns.com @resolver1.opendns.com)
SECURITY_GROUP_ID=${1? Param1:Security group id missing}
ENV=${2?Param2:Environment missing}


aws cloudformation create-stack \
    --stack-name $ENV-ingress-rule-for-migrations \
    --template-body file://${PWD}/cf/rapido-migration-ingress.yaml \
    --parameters ParameterKey=SecurityGroupId,ParameterValue=$SECURITY_GROUP_ID \
                 ParameterKey=AccessCidr,ParameterValue=$CIDR \
    --profile rapido-devops
