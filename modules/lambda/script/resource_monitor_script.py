from email.message import Message
import boto3
import json
import os
from datetime import datetime, timezone
from dateutil import parser

ec2 = boto3.client('ec2')
sns_client = boto3.client('sns')
ec2 = boto3.resource('ec2')

instance_state = 'running'
instance_name = '<specify-instance-name>'
# Additionally you can specify instance type (eg: 'm5.16xlarge') if that is unique and add into filter section
arn = os.environ['sns_topic_arn_value']
instance_runtime = os.environ['instance_runtime']
instance_runtime_to_num = int(instance_runtime)


def lambda_handler(event, context):
    instance_list = []
    instances_running_for_more_than_a_day = []
    stop_instance = []
    terminate_instance = []

    # fetch instnaces running for more than a day
    instances = ec2_resource.instances.filter(
        Filters=[{
            'Name': 'tag:Name',
            'Values': [
                instance_name
            ]
        },
            {
            'Name': 'instance-state-name',
            'Values': [
                instance_state
            ]
        }
        ]
    )
    for instance in instances:
        instance_list.append(f'{instance.id}')
        # check if instance is running for more than a day
        ec2_instance_now = datetime.now()
        ec2_instance_dateTimeParser = parser.parse(f'{instance.launch_time}')
        ec2_instance_difference_in_time = ec2_instance_now - \
            ec2_instance_dateTimeParser.replace(tzinfo=None)
        ec2_instnace_total_seconds = ec2_instance_difference_in_time.total_seconds()
        ec2_instance_total_hours = ec2_instnace_total_seconds/3600
        ec2_instnace_ideal_runtime = instance_runtime_to_num
        if ec2_instance_total_hours > ec2_instnace_ideal_runtime:
            instances_running_for_more_than_a_day.append(f'{instance.id}')
            stop_instance.append(
                f'ec2_instance running for more than {ec2_instnace_ideal_runtime} hours = {instance.id} has been stopped')
            instance.stop
            # If you want to terminate instances
            # terminate_instance.append(
            #    f'ec2_instance running for more than {ec2_instnace_ideal_runtime} hours = {instance.id} has been terminated')
            # instance.terminate             Note:Please make sure that terminate should be used after stop script mentoring for few days
        else:
            continue

    json_syntax = '{"instances_running_for_more_than_a_day":["a_day_long_instances"],"stopped_instances":["stop_ec2_instance"],"terminated_instances":["terminate_ec2_instance"]}'
    json_encoded = json.loads(json_syntax)
    json_encoded['instances_running_for_more_than_a_day'] = instances_running_for_more_than_a_day
    json_encoded['stopped_instances'] = stop_instance
    json_encoded['terminated_instances'] = terminate_instance
    json_obj = json.dumps(json_encoded, indent=2, sort_keys=True)

    sns_client.publish(
        TopicArn=arn,
        Subject='Warning - Abundunt Instances',
        Message=json.dumps({'default': json_obj}),
        MessageStructure='json'
    )
