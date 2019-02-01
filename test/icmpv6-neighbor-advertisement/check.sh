#!/bin/bash
TEST_NAME=icmpv6-neighbor-advertisement

C='\033[1;34m'
NC='\033[0m'

echo -e "${C}RUNNING: $TEST_NAME${NC}"

PORT_OPTIONS="dpdk:eth_pcap0,rx_pcap=data/icmpv6_neighbor_advertisement.pcap,tx_pcap=data/out.pcap"

../../build.sh run $TEST_NAME -p $PORT_OPTIONS -c 1 --dur 1

tcpdump -tner /tmp/out.pcap | tee /dev/tty | diff - data/expect_icmpv6_neighbor_advertisement.out
TEST_NEIGHBOR_ADVERTISEMENT=$?

echo ----
if [[ $TEST_NEIGHBOR_ADVERTISEMENT != 0 ]]; then
    echo "FAIL: Neighbor Advertisement Test - $TEST_NEIGHBOR_ADVERTISEMENT"
    exit 1
else
    echo "PASS"
fi