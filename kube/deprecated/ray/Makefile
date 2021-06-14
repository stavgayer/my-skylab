NAME=recommenderray
NAMESPACE=workspace
KUBECONFIG?=NULL
ENV?=dev

pre:
	kubectl --kubeconfig=$(KUBECONFIG) create ns $(NAMESPACE) --dry-run -o yaml | kubectl apply -f -

build: build_tpl #build_chart

build_chart:
	mkdir -p ../../.build
	helm package -u -d ../../charts .
	pushd ../../charts;helm repo index .; popd;

build_tpl:
	helm template $(NAME)  --namespace $(NAMESPACE) --kubeconfig=$(KUBECONFIG) . > ../../.build/$(NAME).yaml;

install: build_tpl
	kubectl --kubeconfig=$(KUBECONFIG) apply --namespace $(NAMESPACE) -f ../../.build/$(NAME).yaml;

uninstall:
	kubectl --kubeconfig=$(KUBECONFIG) delete --namespace $(NAMESPACE) -f ../../.build/$(NAME).yaml