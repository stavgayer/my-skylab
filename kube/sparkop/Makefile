NAME ?= sparkop
NAMESPACE?=spark-operator
ENV?=dev
KUBECONFIG?=NULL

pre:
	kubectl --kubeconfig=$(KUBECONFIG) create ns $(NAMESPACE) --dry-run -o yaml | kubectl apply -f -
  	# helm repo add spark-operator https://googlecloudplatform.github.io/spark-on-k8s-operator

install: build pre
	helm install $(NAME) --namespace $(NAMESPACE) --kubeconfig=$(KUBECONFIG) --set sparkJobNamespace=$(NAMESPACE) .

upgrade: build pre
	helm upgrade --install $(NAME) --namespace $(NAMESPACE) --kubeconfig=$(KUBECONFIG) --set sparkJobNamespace=$(NAMESPACE) .	

uninstall:
	helm uninstall $(NAME) --namespace $(NAMESPACE) --kubeconfig=$(KUBECONFIG)

build:
	helm template $(NAME)  --namespace $(NAMESPACE) --kubeconfig=$(KUBECONFIG) . > ../../.build/$(NAME).yaml;