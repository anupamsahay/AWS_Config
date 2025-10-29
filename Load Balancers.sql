-- Query all types of load balancers
SELECT 
    configurationitem.resourceid AS arn,
    configurationitem.resourcename AS name,
    configurationitem.resourcetype AS type,
    configurationitem.awsregion AS region,
    CASE 
        WHEN configurationitem.resourcetype = 'AWS::ElasticLoadBalancingV2::LoadBalancer' 
        THEN configurationitem.configuration.type
        ELSE 'classic'
    END AS lb_type,
    configurationitem.configuration.scheme AS scheme,
    configurationitem.configuration.vpcid AS vpc_id,
    configurationitem.configuration.dnsname AS dns_name,
    configurationitem.configuration.createdtime AS created_time,
    configurationitem.tags AS tags
FROM 
    aws_config_configuration_snapshot
WHERE 
    configurationitem.resourcetype IN (
        'AWS::ElasticLoadBalancing::LoadBalancer',
        'AWS::ElasticLoadBalancingV2::LoadBalancer'
    )
    AND configurationitem.configurationitemstatus = 'ResourceDiscovered'
    AND dt = (SELECT MAX(dt) FROM aws_config_configuration_snapshot)
ORDER BY 
    configurationitem.awsregion, configurationitem.resourcename;
