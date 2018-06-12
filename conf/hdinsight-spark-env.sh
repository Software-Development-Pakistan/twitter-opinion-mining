#!/bin/bash

###
  #  Copyright 2016 Aalto University, Ahmed Hussnain
  #
  #  Licensed under the Apache License, Version 2.0 (the "License");
  #  you may not use this file except in compliance with the License.
  #  You may obtain a copy of the License at
  #
  #     http://www.apache.org/licenses/LICENSE-2.0
  #
  #  Unless required by applicable law or agreed to in writing, software
  #  distributed under the License is distributed on an "AS IS" BASIS,
  #  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  #  See the License for the specific language governing permissions and
  #  limitations under the License.

#####################################################
########Configuration file for the project###########
#If you change some settings then please also refer##
#to the ./src/main/resources/config.json ############
#You will have to modify setting in config json#######
#####################################################



### Azure storage account settings you can get from Azure management portal
export AZURE_STORAGE_ACCOUNT=aaltospark       
export AZURE_STORAGE_ACCESS_KEY=

### Azure HDInsight cluster setup variables. You can set them as you want. Becare full about the Azure specific settings for example AZURE ZONES. 
export AZURE_RESOURCE_GROUP=msspark
export AZURE_HDINSIGHT_CLUSTERNAME=aaltoms   
export AZURE_HDINSIGHT_CLUSTER_ZONE="East US"   # only change if you need to create the cluster in a different zone. For optimal use the zone should be same as the blob storage.
export AZURE_HDINSIGHT_WORKER_COUNT=2 
export AZURE_HDINSIGHT_ADMIN=aaltoadmin
export AZURE_HDINSIGHT_SSH_ADMIN=aaltossh
export AZURE_HDINSIGHT_ADMIN_PASSWD=
export AZURE_HDINSIGHT_SSH_ADMIN_PASSWD=

### Livy Spark job parameters. Consider the availability of resources before configuring these parameters

export AZURE_HDINSIGHT_WORKER_MEMORY="10g"       # per worker
export AZURE_HDINSIGHT_DRIVER_MEMORY="4g" 


##############NOT SUPPORTED AT THE MOMENT##################
##############USE ./src/main/resources/config.json########
##############to configure DB settings####################
### Azure SQL DB

#export AZURE_DB_ADMIN=aaltoadmin          #Azure SQL DB instance admin
#export AZURE_DB_CLUSTER_NAME=aaltoms      # Azure SQL DB Cluster Name
#export AZURE_DB_NAME=ms-twitter           # Azure SQL DB Name
#export AZURE_DB_PASSWD=        # Azure SQL DB password
