#!/bin/bash
# Danilo Nunes Melo
# Creation date 01/08/2021
# Update date 01/09/2021
# Spark Installation Automated
# Version 1.0

if [[ ${EUID} -eq 0 ]]
     then
       echo "You have root access"
     else
       echo "Root permission required to install"
       exit
fi

url_spark='https://downloads.apache.org/spark/spark-3.0.1/'
spark_version=$(curl --silent ${url_spark} | grep gz | awk -F '"' '{ print $6 }' | grep gz$) 1>/dev/null 2>&1

# TODO *Verify previous Spark Installation


# Set PS3 prompt
PS3="Enter the Spark Version to install : "

# set shuttle list
select spk_vrn in ${spark_version}
do
    echo "${spk_vrn} selected"
    break;
done

echo "===Downloading the package ${spk_vrn}==="

wget ${url_spark}${spk_vrn} -P /tmp

if [[ $? -eq 0 ]]
     then
       echo "Spark Downloaded successfully"
     else
       echo "Download not completed"
       exit
fi

echo "===Starting unpacking==="

tar -xvf /tmp/${spk_vrn} -C /usr/local/

if [[ $? -eq 0 ]]
     then
       echo "Files unzipped successfully"
     else
       echo "Error while unzipping"
       exit
fi


#echo "Starting configuration Pyspark"

## TODO *Verify env varialbles for R Spark

#sudo ln -s /usr/local/spark3.0/ /usr/local/spark

#sudo chown -RH spark: /usr/local/spark

#sudo sh -c 'chmod +x /usr/local/spark/bin/*.sh'

#export SPARK_HOME=/usr/local/spark
#export PYSPARK_DRIVER_PYTHON=jupyter
#export PYSPARK_DRIVER_PYTHON_OPTS='notebook'
#export PYSPARK_PYTHON=python3


