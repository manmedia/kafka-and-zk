# kafka-and-zk
Packages a single node Apache Kafka with Zookeeper - Volumes can be mounted to transfer rearrange log files. You can start your application and point to the running container for messaging.

# How to start
1. Downlod the source code using git clone.
2. On Windows or Linux:
   a) Navigate to source folder.
   b) type - docker build -t kafka-w-zk .
3. On Windows (make sure you have created the directories beforehand):
   a) type - docker run --rm -ti \
      --name mykafka -p 2181 -p 9092\
      -v C:/kafka:/tmp/kafka -v C:/zookeeper:/tmp/zookeeper \
      -d kafka-w-zk
4. On Linux (make sure you have created the directories beforehand, and chmod it to have 777 permission)
   a) type - docker run --rm -ti \
      --name mykafka \
      -v /kafka:/tmp/kafka -v /zookeeper:/tmp/zookeeper \
      -d kafka-w-zk
5. Create some topics interactively:
   a) type - docker exec -ti mykafka bash
   b) you should see root@CONTAINERID: prompt
   c) type - cd /opt/kafka/bin
   d) type - ./kafka-topics.sh --create \
   --topic test --partitions 1 --replication-factor 1 \
   --zookeeper localhost:2181
   c) You should see the confirmation "Created topic test".
   
  Now send some messages and enjoy :)
