import databricks.koalas as ks

df = ks.read_csv('.build/dim_feature.csv')
df.to_parquet('.build/parquet/dim_feature')