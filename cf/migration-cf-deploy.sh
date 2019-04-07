CIDR=$(dig +short myip.opendns.com @resolver1.opendns.com)
SECURITY_GROUP_ID=${1? Param1:Security group id missing}
FROM_PORT=3306
TO_PORT=3306
ENV=${2?Param2:Environment missing}


aws cloudformation create-stack \
    --stack-name $ENV-ingress-rule-for-migrations \
    --template-body file://${PWD}/cf/rapido-migration-ingress.yaml \
    --parameters ParameterKey=SecurityGroupId,ParameterValue=$SECURITY_GROUP_ID \
                 ParameterKey=AccessCidr,ParameterValue=$CIDR \
                 ParameterKey=FromPort,ParameterValue=$FROM_PORT \
                 ParameterKey=ToPort,ParameterValue=$TO_PORT \
    --profile rapido-devops
