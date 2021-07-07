import databricks.koalas as ks

df = ks.read_csv('../../build/small.csv')
df.to_parquet('../../parquet/small')