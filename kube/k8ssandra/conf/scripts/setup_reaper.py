#! /usr/bin/python3

import requests
import datetime
from urllib.parse import quote

r = requests.put('http://cassandra-cassandra-reaper:8080/cluster/cassandra?seedHost=cassandra.starship-cassandra')
print(f"Finished adding cluster: {r.__dict__}",)

today=datetime.date.today()+datetime.timedelta(days=1)
scheduleTriggerTime=today.strftime("%Y-%m-%dT19:00:00") # 5AM JST

r=requests.post(f"http://cassandra-cassandra-reaper:8080/repair_schedule?clusterName=cassandra&keyspace=starship&owner=admin&scheduleTriggerTime={scheduleTriggerTime}&scheduleDaysBetween=3&incrementalRepair=false&repairThreadCount=1")
print(f"Finished adding cluster repair schedule: {r.__dict__}")
