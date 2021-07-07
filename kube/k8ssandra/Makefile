NAME=cassandra
NAMESPACE=starship-cassandra
KUBECONFIG?=NULL
ENV?=dev

pre:
	# helm repo add k8ssandra https://helm.k8ssandra.io/stable
	# helm repo update

	kubectl --kubeconfig=$(KUBECONFIG) create ns $(NAMESPACE) --dry-run -o yaml | kubectl apply -f -

install: build
	helm install $(NAME) --kubeconfig=$(KUBECONFIG) --namespace $(NAMESPACE) .;

upgrade: build
	helm upgrade $(NAME) --kubeconfig=$(KUBECONFIG) --namespace $(NAMESPACE) .;	

uninstall: build
	helm uninstall $(NAME) --kubeconfig=$(KUBECONFIG) --namespace $(NAMESPACE);

build:
	helm template $(NAME)  --namespace $(NAMESPACE) --kubeconfig=$(KUBECONFIG) . > ../../.build/$(NAME).yaml;