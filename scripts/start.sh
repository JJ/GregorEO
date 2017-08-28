
KAFKA_PATH=/usr/local/kafka_2.12-0.11.0.0/
THIS_DIR=$PWD
cd $KAFKA_PATH; bin/zookeeper-server-start.sh $THIS_DIR/assets/zookeeper.properties & bin/kafka-server-start.sh $THIS_DIR/assets/server.properties &
