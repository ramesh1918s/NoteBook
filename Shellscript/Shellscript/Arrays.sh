-----------------------------------------------------ARRAYS-----------------------

 - Arrays is list of componites
 - Index in Arrays 

 - root@ip-10-40-1-29:/home/ubuntu# FRIENDS=("Ranga","Thiru","Shiva","Raja")
root@ip-10-40-1-29:/home/ubuntu# echo $FRIENDS
Ranga,Thiru,Shiva,Raja
root@ip-10-40-1-29:/home/ubuntu# type $FRIENDS
bash: type: Ranga,Thiru,Shiva,Raja: not found
root@ip-10-40-1-29:/home/ubuntu# type ping
ping is /usr/bin/ping
root@ip-10-40-1-29:/home/ubuntu# echo $FRIENDS[*]
Ranga,Thiru,Shiva,Raja[*]
root@ip-10-40-1-29:/home/ubuntu# echo ${FRIENDS[*]}
Ranga,Thiru,Shiva,Raja
root@ip-10-40-1-29:/home/ubuntu# echo ${FRIENDS[@]}
Ranga,Thiru,Shiva,Raja
root@ip-10-40-1-29:/home/ubuntu# echo ${FRIENDS[0]}
Ranga,Thiru,Shiva,Raja
root@ip-10-40-1-29:/home/ubuntu# echo ${FRIENDS[1]}

root@ip-10-40-1-29:/home/ubuntu# ipython
Command 'ipython' not found, did you mean:
  command 'ipython3' from deb ipython3 (8.14.0-2)
  command 'xpython' from deb xpython (0.15.10+~0.6.1-1)
  command 'bpython' from deb bpython (0.24-1)
Try: apt install <deb name>
root@ip-10-40-1-29:/home/ubuntu# FRIENDS=(Rang Thiru Raja Shiva)
root@ip-10-40-1-29:/home/ubuntu# echo ${FRIENDS}
Rang
root@ip-10-40-1-29:/home/ubuntu# echo ${FRIENDS[0]}
Rang
root@ip-10-40-1-29:/home/ubuntu# echo ${FRIENDS[1]}
Thiru
root@ip-10-40-1-29:/home/ubuntu# echo ${FRIENDS[2]}
Raja
root@ip-10-40-1-29:/home/ubuntu# echo ${FRIENDS[3]}
Shiva
root@ip-10-40-1-29:/home/ubuntu# echo ${FRIENDS[4]}

root@ip-10-40-1-29:/home/ubuntu# echo ${FRIENDS[@]:2}
Raja Shiva
root@ip-10-40-1-29:/home/ubuntu# echo ${FRIENDS[@]:1}
Thiru Raja Shiva
root@ip-10-40-1-29:/home/ubuntu# echo ${FRIENDS[@]:0}
Rang Thiru Raja Shiva
root@ip-10-40-1-29:/home/ubuntu# echo ${FRIENDS[@]:3}
Shiva
root@ip-10-40-1-29:/home/ubuntu# REGIONS=('us-east-1''us-east-2''us-west-1''us-west-2')
root@ip-10-40-1-29:/home/ubuntu# for REGION in {REGIONS[*]}
> do
> echo $REGIONS
> done
us-east-1us-east-2us-west-1us-west-2
root@ip-10-40-1-29:/home/ubuntu# for REGION in ${REGIONS[*]}; do echo $REGIONS; done
us-east-1us-east-2us-west-1us-west-2
root@ip-10-40-1-29:/home/ubuntu# for REGION in ${REGIONS[*]}; do echo $REGION; done
us-east-1us-east-2us-west-1us-west-2


------------------------------------------------------------------------------------------------------------------------------------------------
#  install on aws cli on  ubuntu linux

#  - Access_key     
 
#  - key            
#  - REGIONS=('us-east-1''us-east-2''us-west-1''us-west-2')
#  - PROFILES=('east1''east2''west1''west2')
#  -
 
#   aws_access_key_id = 
#   aws_secret_access_key = 


# [east1]
# aws_access_key_id = 
# aws_secret_access_key = 


# [east2]
# aws_access_key_id = 
# aws_secret_access_key = 


# [west1]
# aws_access_key_id = 
# aws_secret_access_key = 


# [west2]
# aws_access_key_id = 
# aws_secret_access_key = 



# - nano .aws/credentials
# - [default]
# aws_access_key_id =  
# aws_secret_access_key =

# [east1]
# aws_access_key_id =  
# aws_secret_access_key =


# [east2]
# aws_access_key_id =  
# aws_secret_access_key = 


# [west1]
# aws_access_key_id = 
# aws_secret_access_key = 


# [west2]
# aws_access_key_id =  
# aws_secret_access_key = 



--------------------------------------------------------------------------------------------------


nano config

 
#[default]
#region = us-east-1
#output = json

[profile east1]
region = us-east-1
output = json


[profile east2]
region = us-east-2
output = table

[profile west1]
region = us-west-1
output = json

[profile west2]
region = us-west-2
output = table


--------------------------------------------------------------------------------------------------------------


root@ip-10-40-1-29:~/.aws# aws ec2 describe-instances --profile west1
{
    "Reservations": []
}
root@ip-10-40-1-29:~/.aws# aws ec2 describe-instances --profile west2
-------------------
|DescribeInstances|
+-----------------+
root@ip-10-40-1-29:~/.aws# aws ec2 describe-instances --profile east2
-------------------
|DescribeInstances|
+-----------------+
root@ip-10-40-1-29:~/.aws# aws ec2 describe-instances --profile east1
{
    "Reservations": [
        {
            "ReservationId": "r-087fa8420ef772a97",
            "OwnerId": "851725475020",
            "Groups": [],
            "Instances": [
                {
                    "Architecture": "x86_64",
                    "BlockDeviceMappings": [
                        {
                            "DeviceName": "/dev/sda1",
                            "Ebs": {
                                "AttachTime": "2024-10-14T11:36:16+00:00",
                                "DeleteOnTermination": true,
                                "Status": "attached",
                                "VolumeId": "vol-0cf31aebf6924f416"
                            }
                        }
                    ],
                    "ClientToken": "612b2c1a-adb9-4739-9043-fd400b4af318",
                    "EbsOptimized": false,
                    "EnaSupport": true,
                    "Hypervisor": "xen",
                    "NetworkInterfaces": [
                        {
                            "Association": {
                                "IpOwnerId": "amazon",
                                "PublicDnsName": "",
                                "PublicIp": "54.174.187.193"
                            },
                            "Attachment": {
                                "AttachTime": "2024-10-14T11:36:15+00:00",
                                "AttachmentId": "eni-attach-02b6ec9822f46f1eb",
                                "DeleteOnTermination": true,
                                "DeviceIndex": 0,
                                "Status": "attached",
                                "NetworkCardIndex": 0
                            },
                            "Description": "",
                            "Groups": [
                                {
                                    "GroupId": "sg-0dea1a04ef01db7a4",
                                    "GroupName": "uru_SG"
                                }
                            ],
                            "Ipv6Addresses": [],
                            "MacAddress": "12:9f:44:f2:7b:9f",
                            "NetworkInterfaceId": "eni-0269a5a0b920605f7",
                            "OwnerId": "851725475020",
                            "PrivateIpAddress": "10.40.1.29",
                            "PrivateIpAddresses": [
                                {
                                    "Association": {
                                        "IpOwnerId": "amazon",
                                        "PublicDnsName": "",
                                        "PublicIp": "54.174.187.193"
                                    },
                                    "Primary": true,
                                    "PrivateIpAddress": "10.40.1.29"
                                }
                            ],
                            "SourceDestCheck": true,
                            "Status": "in-use",
                            "SubnetId": "subnet-09261ae91426b5740",
                            "VpcId": "vpc-09e86515a72628a0a",
                            "InterfaceType": "interface"
                        }
                    ],
                    "RootDeviceName": "/dev/sda1",
                    "RootDeviceType": "ebs",
                    "SecurityGroups": [
                        {
                            "GroupId": "sg-0dea1a04ef01db7a4",
                            "GroupName": "uru_SG"
                        }
                    ],
                    "SourceDestCheck": true,
                    "Tags": [
                        {
                            "Key": "Name",
                            "Value": "Shell"
                        }
                    ],
                    "VirtualizationType": "hvm",
                    "CpuOptions": {
                        "CoreCount": 1,
                        "ThreadsPerCore": 1
                    },
                    "CapacityReservationSpecification": {
                        "CapacityReservationPreference": "open"
                    },
                    "HibernationOptions": {
                        "Configured": false
                    },
                    "MetadataOptions": {
                        "State": "applied",
                        "HttpTokens": "required",
                        "HttpPutResponseHopLimit": 2,
                        "HttpEndpoint": "enabled",
                        "HttpProtocolIpv6": "disabled",
                        "InstanceMetadataTags": "disabled"
                    },
                    "EnclaveOptions": {
                        "Enabled": false
                    },
                    "BootMode": "uefi-preferred",
                    "PlatformDetails": "Linux/UNIX",
                    "UsageOperation": "RunInstances",
                    "UsageOperationUpdateTime": "2024-10-14T11:36:15+00:00",
                    "PrivateDnsNameOptions": {
                        "HostnameType": "ip-name",
                        "EnableResourceNameDnsARecord": false,
                        "EnableResourceNameDnsAAAARecord": false
                    },
                    "MaintenanceOptions": {
                        "AutoRecovery": "default"
                    },
                    "CurrentInstanceBootMode": "legacy-bios",
                    "InstanceId": "i-0ac25f651f242cf12",
                    "ImageId": "ami-0866a3c8686eaeeba",
                    "State": {
                        "Code": 16,
                        "Name": "running"
                    },
                    "PrivateDnsName": "ip-10-40-1-29.ec2.internal",
                    "PublicDnsName": "",
                    "StateTransitionReason": "",
                    "KeyName": "Main_Key",
                    "AmiLaunchIndex": 0,
                    "ProductCodes": [],
                    "InstanceType": "t2.micro",
                    "LaunchTime": "2024-10-17T04:11:21+00:00",
                    "Placement": {
                        "GroupName": "",
                        "Tenancy": "default",
                        "AvailabilityZone": "us-east-1a"
                    },
                    "Monitoring": {
                        "State": "disabled"
                    },
                    "SubnetId": "subnet-09261ae91426b5740",
                    "VpcId": "vpc-09e86515a72628a0a",
                    "PrivateIpAddress": "10.40.1.29",
                    "PublicIpAddress": "54.174.187.193"
                }
            ]
        }
    ]
}
root@ip-10-40-1-29:~/.aws# nano credentials
root@ip-10-40-1-29:~/.aws# ls
config  credentials



-----------------------------------------------------------------------------------------------------------------
- REGIONS=('us-east-1''us-east-2''us-west-1''us-west-2')
- PROFILES=("east1" "east2" "west1" "west2")

- for profile in ${PROFILES[@]}; do aws ec2 describe-instances --profile $profile ; echo "==========================================================================================="; done



- 
root@ip-10-40-1-29:~/aws# for profile in ${PROFILES[@]}; do aws ec2 describe-instances --profile $profile ; echo "==========================================================================================="; done
{
    "Reservations": [
        {
            "ReservationId": "r-087fa8420ef772a97",
            "OwnerId": "851725475020",
            "Groups": [],
            "Instances": [
                {
                    "Architecture": "x86_64",
                    "BlockDeviceMappings": [
                        {
                            "DeviceName": "/dev/sda1",
                            "Ebs": {
                                "AttachTime": "2024-10-14T11:36:16+00:00",
                                "DeleteOnTermination": true,
                                "Status": "attached",
                                "VolumeId": "vol-0cf31aebf6924f416"
                            }
                        }
                    ],
                    "ClientToken": "612b2c1a-adb9-4739-9043-fd400b4af318",
                    "EbsOptimized": false,
                    "EnaSupport": true,
                    "Hypervisor": "xen",
                    "NetworkInterfaces": [
                        {
                            "Association": {
                                "IpOwnerId": "amazon",
                                "PublicDnsName": "",
                                "PublicIp": "54.174.187.193"
                            },
                            "Attachment": {
                                "AttachTime": "2024-10-14T11:36:15+00:00",
                                "AttachmentId": "eni-attach-02b6ec9822f46f1eb",
                                "DeleteOnTermination": true,
                                "DeviceIndex": 0,
                                "Status": "attached",
                                "NetworkCardIndex": 0
                            },
                            "Description": "",
                            "Groups": [
                                {
                                    "GroupId": "sg-0dea1a04ef01db7a4",
                                    "GroupName": "uru_SG"
                                }
                            ],
                            "Ipv6Addresses": [],
                            "MacAddress": "12:9f:44:f2:7b:9f",
                            "NetworkInterfaceId": "eni-0269a5a0b920605f7",
                            "OwnerId": "851725475020",
                            "PrivateIpAddress": "10.40.1.29",
                            "PrivateIpAddresses": [
                                {
                                    "Association": {
                                        "IpOwnerId": "amazon",
                                        "PublicDnsName": "",
                                        "PublicIp": "54.174.187.193"
                                    },
                                    "Primary": true,
                                    "PrivateIpAddress": "10.40.1.29"
                                }
                            ],
                            "SourceDestCheck": true,
                            "Status": "in-use",
                            "SubnetId": "subnet-09261ae91426b5740",
                            "VpcId": "vpc-09e86515a72628a0a",
                            "InterfaceType": "interface"
                        }
                    ],
                    "RootDeviceName": "/dev/sda1",
                    "RootDeviceType": "ebs",
                    "SecurityGroups": [
                        {
                            "GroupId": "sg-0dea1a04ef01db7a4",
                            "GroupName": "uru_SG"
                        }
                    ],
                    "SourceDestCheck": true,
                    "Tags": [
                        {
                            "Key": "Name",
                            "Value": "Shell"
                        }
                    ],
                    "VirtualizationType": "hvm",
                    "CpuOptions": {
                        "CoreCount": 1,
                        "ThreadsPerCore": 1
                    },
                    "CapacityReservationSpecification": {
                        "CapacityReservationPreference": "open"
                    },
                    "HibernationOptions": {
                        "Configured": false
                    },
                    "MetadataOptions": {
                        "State": "applied",
                        "HttpTokens": "required",
                        "HttpPutResponseHopLimit": 2,
                        "HttpEndpoint": "enabled",
                        "HttpProtocolIpv6": "disabled",
                        "InstanceMetadataTags": "disabled"
                    },
                    "EnclaveOptions": {
                        "Enabled": false
                    },
                    "BootMode": "uefi-preferred",
                    "PlatformDetails": "Linux/UNIX",
                    "UsageOperation": "RunInstances",
                    "UsageOperationUpdateTime": "2024-10-14T11:36:15+00:00",
                    "PrivateDnsNameOptions": {
                        "HostnameType": "ip-name",
                        "EnableResourceNameDnsARecord": false,
                        "EnableResourceNameDnsAAAARecord": false
                    },
                    "MaintenanceOptions": {
                        "AutoRecovery": "default"
                    },
                    "CurrentInstanceBootMode": "legacy-bios",
                    "InstanceId": "i-0ac25f651f242cf12",
                    "ImageId": "ami-0866a3c8686eaeeba",
                    "State": {
                        "Code": 16,
                        "Name": "running"
                    },
                    "PrivateDnsName": "ip-10-40-1-29.ec2.internal",
                    "PublicDnsName": "",
                    "StateTransitionReason": "",
                    "KeyName": "Main_Key",
                    "AmiLaunchIndex": 0,
                    "ProductCodes": [],
                    "InstanceType": "t2.micro",
                    "LaunchTime": "2024-10-17T04:11:21+00:00",
                    "Placement": {
                        "GroupName": "",
                        "Tenancy": "default",
                        "AvailabilityZone": "us-east-1a"
                    },
                    "Monitoring": {
                        "State": "disabled"
                    },
                    "SubnetId": "subnet-09261ae91426b5740",
                    "VpcId": "vpc-09e86515a72628a0a",
                    "PrivateIpAddress": "10.40.1.29",
                    "PublicIpAddress": "54.174.187.193"
                }
            ]
        }
    ]
}
===========================================================================================
-------------------
|DescribeInstances|
+-----------------+
===========================================================================================
{
    "Reservations": []
}
===========================================================================================
-------------------
|DescribeInstances|
+-----------------+
===========================================================================================


---------------------------------------------------------------------------------------------------------------------------------------------
- sudo apt install -y jq
- #[default]
#region = us-east-1
#output = json

[profile east1]
region = us-east-1
output = json


[profile east2]
region = us-east-2
output = json

[profile west1]
region = us-west-1
output = json

[profile west2]
region = us-west-2
output = json


-----------------------------------------------------------------------


for profile in ${PROFILES[@]}; do aws ec2 describe-instances --profile $profile  | jq ; echo "==========================================================================================="; done
{
  "Reservations": [
    {
      "ReservationId": "r-087fa8420ef772a97",
      "OwnerId": "851725475020",
      "Groups": [],
      "Instances": [
        {
          "Architecture": "x86_64",
          "BlockDeviceMappings": [
            {
              "DeviceName": "/dev/sda1",
              "Ebs": {
                "AttachTime": "2024-10-14T11:36:16+00:00",
                "DeleteOnTermination": true,
                "Status": "attached",
                "VolumeId": "vol-0cf31aebf6924f416"
              }
            }
          ],
          "ClientToken": "612b2c1a-adb9-4739-9043-fd400b4af318",
          "EbsOptimized": false,
          "EnaSupport": true,
          "Hypervisor": "xen",
          "NetworkInterfaces": [
            {
              "Association": {
                "IpOwnerId": "amazon",
                "PublicDnsName": "",
                "PublicIp": "54.174.187.193"
              },
              "Attachment": {
                "AttachTime": "2024-10-14T11:36:15+00:00",
                "AttachmentId": "eni-attach-02b6ec9822f46f1eb",
                "DeleteOnTermination": true,
                "DeviceIndex": 0,
                "Status": "attached",
                "NetworkCardIndex": 0
              },
              "Description": "",
              "Groups": [
                {
                  "GroupId": "sg-0dea1a04ef01db7a4",
                  "GroupName": "uru_SG"
                }
              ],
              "Ipv6Addresses": [],
              "MacAddress": "12:9f:44:f2:7b:9f",
              "NetworkInterfaceId": "eni-0269a5a0b920605f7",
              "OwnerId": "851725475020",
              "PrivateIpAddress": "10.40.1.29",
              "PrivateIpAddresses": [
                {
                  "Association": {
                    "IpOwnerId": "amazon",
                    "PublicDnsName": "",
                    "PublicIp": "54.174.187.193"
                  },
                  "Primary": true,
                  "PrivateIpAddress": "10.40.1.29"
                }
              ],
              "SourceDestCheck": true,
              "Status": "in-use",
              "SubnetId": "subnet-09261ae91426b5740",
              "VpcId": "vpc-09e86515a72628a0a",
              "InterfaceType": "interface"
            }
          ],
          "RootDeviceName": "/dev/sda1",
          "RootDeviceType": "ebs",
          "SecurityGroups": [
            {
              "GroupId": "sg-0dea1a04ef01db7a4",
              "GroupName": "uru_SG"
            }
          ],
          "SourceDestCheck": true,
          "Tags": [
            {
              "Key": "Name",
              "Value": "Shell"
            }
          ],
          "VirtualizationType": "hvm",
          "CpuOptions": {
            "CoreCount": 1,
            "ThreadsPerCore": 1
          },
          "CapacityReservationSpecification": {
            "CapacityReservationPreference": "open"
          },
          "HibernationOptions": {
            "Configured": false
          },
          "MetadataOptions": {
            "State": "applied",
            "HttpTokens": "required",
            "HttpPutResponseHopLimit": 2,
            "HttpEndpoint": "enabled",
            "HttpProtocolIpv6": "disabled",
            "InstanceMetadataTags": "disabled"
          },
          "EnclaveOptions": {
            "Enabled": false
          },
          "BootMode": "uefi-preferred",
          "PlatformDetails": "Linux/UNIX",
          "UsageOperation": "RunInstances",
          "UsageOperationUpdateTime": "2024-10-14T11:36:15+00:00",
          "PrivateDnsNameOptions": {
            "HostnameType": "ip-name",
            "EnableResourceNameDnsARecord": false,
            "EnableResourceNameDnsAAAARecord": false
          },
          "MaintenanceOptions": {
            "AutoRecovery": "default"
          },
          "CurrentInstanceBootMode": "legacy-bios",
          "InstanceId": "i-0ac25f651f242cf12",
          "ImageId": "ami-0866a3c8686eaeeba",
          "State": {
            "Code": 16,
            "Name": "running"
          },
          "PrivateDnsName": "ip-10-40-1-29.ec2.internal",
          "PublicDnsName": "",
          "StateTransitionReason": "",
          "KeyName": "Main_Key",
          "AmiLaunchIndex": 0,
          "ProductCodes": [],
          "InstanceType": "t2.micro",
          "LaunchTime": "2024-10-17T04:11:21+00:00",
          "Placement": {
            "GroupName": "",
            "Tenancy": "default",
            "AvailabilityZone": "us-east-1a"
          },
          "Monitoring": {
            "State": "disabled"
          },
          "SubnetId": "subnet-09261ae91426b5740",
          "VpcId": "vpc-09e86515a72628a0a",
          "PrivateIpAddress": "10.40.1.29",
          "PublicIpAddress": "54.174.187.193"
        }
      ]
    }
  ]
}
===========================================================================================
{
  "Reservations": []
}
===========================================================================================
{
  "Reservations": []
}
===========================================================================================
{
  "Reservations": []
}
===========================================================================================
root@ip-10-40-1-29:~# nano .aws/config

- 
root@ip-10-40-1-29:~# aws ec2 describe-instances --profile $PROFILE
{
    "Reservations": []
}
root@ip-10-40-1-29:~# aws ec2 describe-instances --profile $PROFILE | jq -r '.Reservations[]?.Instances[]?.InstanceId'
root@ip-10-40-1-29:~# aws ec2 describe-instances --profile $PROFILE | jq -r '.Reservations[]?.Instances[]?.InstanceId'
root@ip-10-40-1-29:~# for PROFILE in ${PROFILES[@]}; do
    echo $PROFILE
    INSTANCES=$(aws ec2 describe-instances --profile $PROFILE)
    if [ -z "$INSTANCES" ] || [ "$INSTANCES" == "null" ]; then
        echo "No instances found for profile $PROFILE"
    else
        echo "$INSTANCES" | jq -r '.Reservations[]?.Instances[]?.InstanceId'
    fi
    echo "==================================================="
    sleep 1
done
east1
i-0ac25f651f242cf12
===================================================
east2
===================================================
west1
===================================================
west2
===================================================
root@ip-10-40-1-29:~#


-------------------------------------------------------------------------------------------------------------------------------

root@ip-10-40-1-29:~# for PROFILE in ${PROFILES[@]}; do
    echo $PROFILE
    KEY_PAIRS=$(aws ec2 describe-key-pairs --profile $PROFILE)
    if [ -z "$KEY_PAIRS" ] || [ "$KEY_PAIRS" == "null" ]; then
        echo "No key pairs found for profile $PROFILE"
    else
        echo "$KEY_PAIRS" | jq -r '.KeyPairs[]?.KeyName'
    fi
    echo "==================================================="
    sleep 1
done
east1
eksctl-eksdemo-nodegroup-eksdemo-ng-public-b69mdk+nQaltBzq2xEqMuDlgm6unbM7JG1/WYA752Zo
Main_Key
===================================================
east2
Ohio_Key_pair
===================================================
west1
===================================================
west2
===================================================


---------------------------------List of Key-pairs for different Regions ---------------------------------------------------------------------------------------------


for PROFILE in ${PROFILES[@]}; do
    echo $PROFILE
    aws ec2 describe-key-pairs --profile $PROFILE | jq -r '.KeyPairs[].KeyName'
    echo "========================================"
    sleep 1
done

east1
eksctl-eksdemo-nodegroup-eksdemo-ng-public-b69mdk+nQaltBzq2xEqMuDlgm6unbM7JG1/WYA752Zo
Main_Key
========================================
east2
Ohio_Key_pair
========================================
west1
========================================
west2
========================================
root@ip-10-40-1-29:~#


----------------------------------------List of Instances Id for Different regions -----------------------------------------------------

root@ip-10-40-1-29:~# for PROFILE in ${PROFILES[@]}; do
    echo $PROFILE
    aws ec2 describe-instances --profile $PROFILE | jq -r '.Reservations[].Instances[].InstanceId'
    echo "========================================"
    sleep 1
done
east1
i-0ac25f651f242cf12
========================================
east2
========================================
west1
========================================
west2
========================================
root@ip-10-40-1-29:~#


---------------------------------- List of Regions --------------------------------------------------------------------------------

-  aws ec2 describe-regions --profile east1 | grep -i RegionName
            "RegionName": "ap-south-1",
            "RegionName": "eu-north-1",
            "RegionName": "eu-west-3",
            "RegionName": "eu-west-2",
            "RegionName": "eu-west-1",
            "RegionName": "ap-northeast-3",
            "RegionName": "ap-northeast-2",
            "RegionName": "ap-northeast-1",
            "RegionName": "ca-central-1",
            "RegionName": "sa-east-1",
            "RegionName": "ap-southeast-1",
            "RegionName": "ap-southeast-2",
            "RegionName": "eu-central-1",
            "RegionName": "us-east-1",
            "RegionName": "us-east-2",
            "RegionName": "us-west-1",
            "RegionName": "us-west-2",
 - aws ec2 describe-regions --profile east1 | grep -i RegionName | cut -d ":" -f 2 | tr -d '"'
 ap-south-1,
 eu-north-1,
 eu-west-3,
 eu-west-2,
 eu-west-1,
 ap-northeast-3,
 ap-northeast-2,
 ap-northeast-1,
 ca-central-1,
 sa-east-1,
 ap-southeast-1,
 ap-southeast-2,
 eu-central-1,
 us-east-1,
 us-east-2,
 us-west-1,
 us-west-2,
root@ip-10-40-1-29:~#

-----------------------------------------
root@ip-10-40-1-29:~# for REGION in ${REGIONS[@]}
> do
> echo "the Region Code Is $REGION"
> sleep 1
> done
the Region Code Is us-east-1us-east-2us-west-1us-west-2
root@ip-10-40-1-29:~#



----------------------------------------------------------------
root@ip-10-40-1-29:~# for X in 1 2 3 4 5 6 7 8 9 0
> do
> echo "The  Value of X is $X"
> sleep 2
> done
The  Value of X is 1
The  Value of X is 2
The  Value of X is 3
The  Value of X is 4
The  Value of X is 5
The  Value of X is 6
The  Value of X is 7
The  Value of X is 8
The  Value of X is 9
The  Value of X is 0



--------------------------------------------------------------------
 root@ip-10-40-1-29:~# for X in {1..30}; do
    if [ $((X % 2)) -eq 0 ]; then
        echo "$X is EVEN";
    fi
done
2 is EVEN
4 is EVEN
6 is EVEN
8 is EVEN
10 is EVEN
12 is EVEN
14 is EVEN
16 is EVEN
18 is EVEN
20 is EVEN
22 is EVEN
24 is EVEN
26 is EVEN
28 is EVEN
30 is EVEN


====================================================================
 root@ip-10-40-1-29:~# for (( c=1; c<=5; c++ ))
> do
> echo "Welcome $c times"
> done
Welcome 1 times
Welcome 2 times
Welcome 3 times
Welcome 4 times
Welcome 5 times
root@ip-10-40-1-29:~#


----------------------------------- while loop --------------------------------------------

root@ip-10-40-1-29:~# while [ $C -le 5 ]; do echo "Welcome $C Times"; C=$(( $C + 1 )); done
Welcome 1 Times
Welcome 2 Times
Welcome 3 Times
Welcome 4 Times
Welcome 5 Times
root@ip-10-40-1-29:~#

---------------------------------- while loop for different Key-Pairs -----------------------------------------------


X=0

# Loop while X is less than 5
while [ $X -lt 5 ]; do
    # Run the AWS command using the profile from the PROFILES array
    aws ec2 describe-key-pairs --profile "${PROFILES[$X]}" | jq -r '.KeyPairs[].KeyName'

    # Increment X
    X=$(( X + 1 ))

    # Sleep for 1 second between iterations
    sleep 1
done
eksctl-eksdemo-nodegroup-eksdemo-ng-public-b69mdk+nQaltBzq2xEqMuDlgm6unbM7JG1/WYA752Zo
Main_Key
Ohio_Key_pair
eksctl-eksdemo-nodegroup-eksdemo-ng-public-b69mdk+nQaltBzq2xEqMuDlgm6unbM7JG1/WYA752Zo
Main_Key
root@ip-10-40-1-29:~#



----------------------------------------------------------------------------------

root@ip-10-40-1-29:~# X=0
root@ip-10-40-1-29:~# while [ $X -lt 4 ]; do echo ${PROFILES[$X]}; aws ec2 describe-key-pairs --profile ${PROFILES[$X]} | jq -r '.KeyPairs[].KeyName'; echo "===========================" ; X=$(( $X + 1 )) ; sleep 1; done
east1
eksctl-eksdemo-nodegroup-eksdemo-ng-public-b69mdk+nQaltBzq2xEqMuDlgm6unbM7JG1/WYA752Zo
Main_Key
===========================
east2
Ohio_Key_pair
===========================
west1
===========================
west2
===========================


---------------------------------------------------------------------------------