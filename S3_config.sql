SELECT
  resourceId,
  resourceName,
  resourceType,
  awsRegion,
  availabilityZone,
  resourceCreationTime,
  configuration,
  supplementaryConfiguration,
  tags,
  arn,
  accountId
FROM
  aws_config_configuration_snapshot
WHERE
  resourceType = 'AWS::S3::Bucket'
ORDER BY
  resourceCreationTime DESC
