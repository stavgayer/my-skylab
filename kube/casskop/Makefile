
NAME=casskop
NAMESPACE=starship-cassandra
CASSKOP_VERSION=0.5.3
.EXPORT_ALL_VARIABLES:
KUBECONFIG?=NULL

pre:
	# helm repo add orange-incubator https://orange-kubernetes-charts-incubator.storage.googleapis.com
	helm repo add orange-incubator https://orange-kubernetes-charts-incubator.storage.googleapis.com
	helm repo update
	kubectl --kubeconfig=$(KUBECONFIG) create ns $(NAMESPACE) --dry-run -o yaml | kubectl apply -f -

install:
	# You have to create the namespace before executing following commands
	kubectl --kubeconfig=$(KUBECONFIG) apply -f https://raw.githubusercontent.com/Orange-OpenSource/casskop/master/deploy/crds/db.orange.com_cassandraclusters_crd.yaml 
	kubectl --kubeconfig=$(KUBECONFIG) apply -f https://raw.githubusercontent.com/Orange-OpenSource/casskop/master/deploy/crds/db.orange.com_cassandrabackups_crd.yaml 
	kubectl --kubeconfig=$(KUBECONFIG) apply -f https://raw.githubusercontent.com/Orange-OpenSource/casskop/master/deploy/crds/db.orange.com_cassandrarestores_crd.yaml

	helm install $(NAME) --namespace=$(NAMESPACE) --kubeconfig=$(KUBECONFIG) orange-incubator/cassandra-operator

uninstall:
	helm uninstall $(NAME) --namespace=$(NAMESPACE) --kubeconfig=$(KUBECONFIG) 

	# kubectl delete crd cassandraclusters.db.orange.com