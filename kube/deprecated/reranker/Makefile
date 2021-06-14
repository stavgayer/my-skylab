NAME?=reranker
NAMESPACE=ray-reranker
KUBECONFIG?=NULL
ENV?=dev

pre:
	kubectl --kubeconfig=$(KUBECONFIG) create ns $(NAMESPACE) --dry-run -o yaml | kubectl apply -f -;

build:
	helm template $(NAME)  --namespace $(NAMESPACE) --kubeconfig=$(KUBECONFIG) --values=secrets.yaml . > ../../.build/$(NAME).yaml;

install: build
	kubectl --kubeconfig=$(KUBECONFIG) apply --namespace $(NAMESPACE) -f ../../.build/$(NAME).yaml;

uninstall:
	kubectl --kubeconfig=$(KUBECONFIG) delete --namespace $(NAMESPACE) -f ../../.build/$(NAME).yaml