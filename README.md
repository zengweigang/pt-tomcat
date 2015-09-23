# 环境变量

设置 SESSION_DOMAIN 则会把context.xml中的sessionCookieDomain设置为那个环境变量, 不然默认是localhost

设置 DYNAMO_TABLE, 将会在context.xml中设置session管理的manager, 如果在ec2上运行, 则不需要做更多设置, 会自动读取region, 如果在本地测试, 需要再设置一个 DYNAMO_ENDPOINT 指向本地的dynamo, eg. localhost:8000
