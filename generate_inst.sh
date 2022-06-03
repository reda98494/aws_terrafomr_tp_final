#!/bin/bash

I=0

while read line
do
	if [ $I -gt 0 ]
	then
		if [ ! -z $line ]
		then
			NAME=$(echo $line | cut -d";" -f1)
			KEY_NAME="test_keypair"
			AMI="ami-021d41cbdefc0c994"
			SG_NAME=$(echo $line | cut -d";" -f2)
			SUBNET=$(echo $line | cut -d";" -f3)
			INSTANCE_TYPE=$(echo $line | cut -d";" -f4)
			ASSOCIATE_PUBLIC_IP_ADDRESS=$(echo $line | cut -d";" -f5)
			FILE_SERVICE=$(echo $line | cut -d";" -f6)

			cp instance_template new_instance
		
			sed -i "s|<##INFRA_NAME##>|${1}|g" new_instance
			sed -i "s|<##NAME##>|${NAME}|g" new_instance
			sed -i "s|<##KEY_NAME##>|${KEY_NAME}|g" new_instance
			sed -i "s|<##AMI##>|${AMI}|g" new_instance
			sed -i "s|<##SG_NAME##>|${SG_NAME}|g" new_instance
			sed -i "s|<##SUBNET##>|${SUBNET}|g" new_instance
			sed -i "s|<##INSTANCE_TYPE##>|${INSTANCE_TYPE}|g" new_instance
			sed -i "s|<##ASSOCIATE_PUBLIC_IP_ADDRESS##>|${ASSOCIATE_PUBLIC_IP_ADDRESS}|g" new_instance
			sed -i "s|<##FILE_SERVICE##>|${FILE_SERVICE}|g" new_instance
		
			cat new_instance >> ${NAME}.inst
			echo "" >> ${NAME}.inst
			rm new_instance
			mv ${NAME}.inst GENERATED
		fi
	else
		I=1
	fi
done < flow_matrix_instances
cat GENERATED/*.inst >> ./instances.tf
rm GENERATED/*.inst

