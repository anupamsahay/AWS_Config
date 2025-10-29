SELECT 
    configurationitem.resourceid,
    configurationitem.resourcename,
    configurationitem.resourcetype,
    configurationitem.awsregion,
    configurationitem.availabilityzones,
    configurationitem.configuration.loadbalancername,
    configurationitem.configuration.dnsname,
    configurationitem.configuration.scheme,
    configurationitem.configuration.vpcid,
    configurationitem.configuration.type,
    configurationitem.configuration.ipaddresstype,
    configurationitem.configuration.securitygroups,
    configurationitem.configuration.state,
    configurationitem.configuration.createdtime,
    configurationitem.tags
FROM 
    aws_config_configuration_snapshot
WHERE 
    configurationitem.resourcetype IN (
        'AWS::ElasticLoadBalancing::LoadBalancer',
        'AWS::ElasticLoadBalancingV2::LoadBalancer'
    )
    AND dt = (SELECT MAX(dt) FROM aws_config_configuration_snapshot)
ORDER BY 
    configurationitem.resourcename;
