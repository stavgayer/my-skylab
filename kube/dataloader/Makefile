NAME = dataloader
NAMESPACE = starship-cassandra
ENV?=dev
KUBECONFIG?=NULL

pre:
	kubectl --kubeconfig=$(KUBECONFIG) create ns $(NAMESPACE) --dry-run -o yaml | kubectl apply -f -

install: build
	kubectl --kubeconfig=$(KUBECONFIG) apply  -f ../../.build/$(NAME).yaml;
	
build: pre
	helm template $(NAME)  --namespace $(NAMESPACE) --kubeconfig=$(KUBECONFIG) --set env=$(ENV) . > ../../.build/$(NAME).yaml;

uninstall:
	kubectl --kubeconfig=$(KUBECONFIG) delete  -f ../../.build/$(NAME).yaml;