# Change heap options for zookeeper
export KAFKA_HEAP_OPTS=\-Xms512m\ \-Xmx1G
sh ./zookeeper-server-start.sh ../config/zookeeper.properties &
# wait for a few secs
sleep 5s
# Change heap options for broker
export KAFKA_HEAP_OPTS=-\Xms1G\ \-Xmx1G
sh ./kafka-server-start.sh ../config/server.properties

