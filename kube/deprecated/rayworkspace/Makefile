NAME=rayworkspace
NAMESPACE=workspace
KUBECONFIG?=NULL
ENV?=dev
GPU?=""

pre:
	kubectl  --kubeconfig=$(KUBECONFIG) apply -f ../../.build/ray-chart/crds/cluster_crd.yaml
	kubectl --kubeconfig=$(KUBECONFIG) create ns $(NAMESPACE) --dry-run -o yaml | kubectl apply -f -

build: build_tpl

build_tpl:
	helm template $(NAME)  --namespace $(NAMESPACE) --kubeconfig=$(KUBECONFIG) --values=values$(GPU).yaml  --values=secrets.yaml  . > ../../.build/$(NAME).yaml;

install: build_tpl
	kubectl --kubeconfig=$(KUBECONFIG) apply --namespace $(NAMESPACE) -f ../../.build/$(NAME).yaml;

uninstall:
	kubectl --kubeconfig=$(KUBECONFIG) delete --namespace $(NAMESPACE) -f ../../.build/$(NAME).yaml