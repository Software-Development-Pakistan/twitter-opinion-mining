.PHONY: cluster build submit cleanup

cluster:
	azure hdinsight cluster create -g ${AZURE_RESOURCE_GROUP} -l "${AZURE_HDINSIGHT_CLUSTER_ZONE}" -y Linux --clusterType Spark --defaultStorageAccountName ${AZURE_STORAGE_ACCOUNT}.blob.core.windows.net --defaultStorageAccountKey ${AZURE_STORAGE_ACCESS_KEY} --defaultStorageContainer ${AZURE_HDINSIGHT_CLUSTERNAME} --workerNodeCount ${AZURE_HDINSIGHT_WORKER_COUNT} --userName ${AZURE_HDINSIGHT_ADMIN} --password ${AZURE_HDINSIGHT_ADMIN_PASSWD} --sshUserName ${AZURE_HDINSIGHT_SSH_ADMIN} --sshPassword ${AZURE_HDINSIGHT_SSH_ADMIN_PASSWD} ${AZURE_HDINSIGHT_CLUSTERNAME}
	echo "azure hdinsight spark"

build:
	sbt assembly
	azure storage blob upload -f ./target/scala-2.10/twitter_opinion_mining.jar -q -a ${AZURE_STORAGE_ACCOUNT} --container ${AZURE_HDINSIGHT_CLUSTERNAME}  -b sentiment-jar/twitter_opinion_mining.jar

submit:
	curl -k --user "${AZURE_HDINSIGHT_ADMIN}:${AZURE_HDINSIGHT_ADMIN_PASSWD}" -v -H "Content-Type: application/json" -X POST -d '{ "file":"wasb:///sentiment-jar/twitter_opinion_mining.jar", "className":"TwitterOpinionMining", "executorMemory":"${AZURE_HDINSIGHT_WORKER_MEMORY}", "driverMemory":"${AZURE_HDINSIGHT_DRIVER_MEMORY}"}' 'https://aaltoms.azurehdinsight.net/livy/batches'


cleanup:
	echo "delete cluster"
	azure hdinsight cluster delete -q -v -g ${AZURE_RESOURCE_GROUP} ${AZURE_HDINSIGHT_CLUSTERNAME}
	echo "cleaning the azure blob"
	azure storage container delete -q -v -a ${AZURE_STORAGE_ACCOUNT} -k ${AZURE_STORAGE_ACCESS_KEY} --container ${AZURE_HDINSIGHT_CLUSTERNAME}
