CREATE KEYSPACE IF NOT EXISTS starship
    WITH REPLICATION = { 'class' : 'NetworkTopologyStrategy', '{{.Values.datacenter}}' : 3 };

CREATE KEYSPACE IF NOT EXISTS reaper_db WITH replication = {'class': 'NetworkTopologyStrategy', '{{.Values.datacenter}}' : 3 };    
    
CREATE TABLE IF NOT EXISTS starship.init (
    init text PRIMARY KEY
);