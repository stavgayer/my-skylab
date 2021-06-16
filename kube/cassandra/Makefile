
NAME=cassandra
NAMESPACE=starship-cassandra
ENV?=dev
KUBECONFIG?=NULL
.EXPORT_ALL_VARIABLES:

pre:
	kubectl --kubeconfig=$(KUBECONFIG) create ns $(NAMESPACE) --dry-run -o yaml | kubectl apply -f -

install: build
	kubectl --kubeconfig=$(KUBECONFIG) apply --namespace $(NAMESPACE) -f ../../.build/$(NAME).yaml ;

uninstall: build
	kubectl --kubeconfig=$(KUBECONFIG) delete --namespace $(NAMESPACE) -f ../../.build/$(NAME).yaml;

build:
	helm template $(NAME)  --namespace $(NAMESPACE) --kubeconfig=$(KUBECONFIG) . > ../../.build/$(NAME).yaml;