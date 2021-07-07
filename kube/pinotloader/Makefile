NAME=pinotloader
NAMESPACE?=workspace
KUBECONFIG?=NULL
ENV?=dev

pre:
	kubectl --kubeconfig=$(KUBECONFIG) create ns $(NAMESPACE) --dry-run -o yaml | kubectl apply -f -

build: upload_ippandimfeature upload_smalldimfeature upload_small
	helm template $(NAME)  --namespace $(NAMESPACE) --kubeconfig=$(KUBECONFIG) . > ../../.build/$(NAME).yaml;

install: build
	kubectl --kubeconfig=$(KUBECONFIG) apply --namespace $(NAMESPACE) -f ../../.build/$(NAME).yaml;

uninstall: clean_ippandimfeature clean_smalldimfeature clean_small
	kubectl --kubeconfig=$(KUBECONFIG) delete --namespace $(NAMESPACE) -f ../../.build/$(NAME).yaml

upload_small:
	aws s3 cp ../../.build/parquet/small/ s3://unext-datascience/jobs/stargazer/etl/small/ --recursive


upload_smalldimfeature:
	aws s3 cp ../../.build/parquet/small_dim_feature/ s3://unext-datascience/jobs/stargazer/etl/small_dim_feature/ --recursive


upload_ippandimfeature:
	aws s3 cp ../../.build/parquet/dim_feature/ s3://unext-datascience/jobs/stargazer/etl/dim_feature/ --recursive

clean_ippandimfeature:
	aws s3 rm s3://unext-datascience/starship/ippanDimFeature/staging/ --recursive
	aws s3 rm s3://unext-datascience/jobs/stargazer/etl/dim_feature/ --recursive
	aws s3 rm s3://unext-datascience/starship/ippanDimFeature/output/ --recursive

clean_smalldimfeature:
	aws s3 rm s3://unext-datascience/jobs/stargazer/etl/small_dim_feature/ --recursive
	aws s3 rm s3://unext-datascience/starship/smallDimFeature/staging/ --recursive
	aws s3 rm s3://unext-datascience/starship/smallDimFeature/output/ --recursive

clean_small:
	aws s3 rm s3://unext-datascience/jobs/stargazer/etl/small/ --recursive
	aws s3 rm s3://unext-datascience/starship/small/staging/ --recursive
	aws s3 rm s3://unext-datascience/starship/small/output/ --recursive