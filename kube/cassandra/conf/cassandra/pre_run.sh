echo "  ** this is pre_run.sh script executed before run.sh **"

grep max_hints_delivery_threads /etc/cassandra/cassandra.yaml
sed -i 's/max_hints_delivery_threads: 2/max_hints_delivery_threads: 8/' /etc/cassandra/cassandra.yaml
grep max_hints_delivery_threads /etc/cassandra/cassandra.yaml

grep num_tokens /etc/cassandra/cassandra.yaml
sed -i 's/num_tokens: 256/num_tokens: 32/' /etc/cassandra/cassandra.yaml
grep num_tokens /etc/cassandra/cassandra.yaml

grep memtable_allocation_type /etc/cassandra/cassandra.yaml
sed -i 's/memtable_allocation_type: offheap_objects/memtable_allocation_type: offheap_buffers/' /etc/cassandra/cassandra.yaml
grep memtable_allocation_type /etc/cassandra/cassandra.yaml

echo "  ** end of pre_run.sh script, continue with run.sh **"