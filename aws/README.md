## Temporary AWS Tokens via Okta
Using a combination of the following repos: 
* [GitHub - ThoughtWorksInc/aws_role_credentials: Generates AWS credentials for roles using STS] (https://github.com/thoughtworksinc/aws_role_credentials)
* [GitHub - ThoughtWorksInc/oktaauth: Module and CLI client to handle Okta authentication] (https://github.com/ThoughtWorksInc/oktaauth)
You too can have access to temporary tokens!
 
Install prereqs(python 2.7):
```
pip install awscli aws_role_credentials oktaauth --user
```

Execute the scripts:
```
oktaauth \
  --username [USERNAME] \
  --server thoughtworks.okta.com \
  --apptype amazon_aws \
  --appid [APP_ID] | \
  aws_role_credentials saml --profile [PROFILE]
```

### How do I get my App Id for oktaauth?
If you click the Okta chiclet for your AWS application and watch the URL bar you’ll see a few redirects go through.  If you blink you may miss it so you’ll need to be quick.  Here’s what one of those URLs you can capture look like.  The App Id is in bold.  https://thoughtworks.okta.com/app/amazon_aws/exkXXXXXXXXXXXXXXXX/sso/saml

### Assume Role
The default role you get is read-only role. If you want to assume admin role, see example ~/.aws/config (replace account id):
```
[profile sea]
region = ap-southeast-1

[profile cn]
region = cn-north-1

[profile admin]
region = ap-southeast-1
role_arn = arn:aws:iam::12345678:role/federated-admin
source_profile = sea
```

Then set env var for AWS_PROFILE
```
export AWS_PROFILE=admin
```
Then run AWS related command.
