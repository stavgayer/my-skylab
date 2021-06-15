NAME=istio
NAMESPACE=istio-system
KUBECONFIG?=NULL
ENV?=dev
ISTIO_VERSION = 1.10.1

istio_init:
	pushd ../../.build;\
		curl -L https://istio.io/downloadIstio | ISTIO_VERSION=$(ISTIO_VERSION) sh -;\
		cd istio-$(ISTIO_VERSION)*;\
		ls -lah;\
	popd
	kubectl --kubeconfig=$(KUBECONFIG) create ns starship-api --dry-run -o yaml | kubectl apply -f -
	kubectl --kubeconfig=$(KUBECONFIG) label ns starship-api istio-injection=enabled  --overwrite	

pre: istio_init

build: 
	helm template $(NAME)  --namespace $(NAMESPACE) --kubeconfig=$(KUBECONFIG) --values values-$(ENV).yaml . > ../../.build/$(NAME).yaml;

build_istio_1_10_1:
	kubectl --kubeconfig=$(KUBECONFIG) create ns $(NAMESPACE) --dry-run -o yaml | kubectl apply -f -
	cp istio*.yaml ../../.build/istio-$(ISTIO_VERSION);	
	KUBECONFIG=$(KUBECONFIG);\
	pushd ../../.build/$(NAME)-$(ISTIO_VERSION);\
		ls -lah;\
		./bin/istioctl profile dump -f istio.yaml > istio-dump-$(ENV).yaml; \
	popd

install: install_1_10_1 install_others

install_1_10_1: build_istio_1_10_1 
	KUBECONFIG=$(KUBECONFIG);\
	pushd ../../.build/$(NAME)-$(ISTIO_VERSION);\
		./bin/istioctl -n $(NAMESPACE) install -y -f istio-dump-$(ENV).yaml; \
		./bin/istioctl -n $(NAMESPACE) verify-install -f istio-dump-$(ENV).yaml;\
	popd
	
uninstall: un_install_others uninstall_istio_1_10_1
 
uninstall_istio_1_10_1:  
	KUBECONFIG=$(KUBECONFIG);\
	pushd ../../.build/$(NAME)-$(ISTIO_VERSION);\
		./bin/istioctl -n $(NAMESPACE) experimental uninstall -y --purge;\
	popd

install_others: build
	kubectl --kubeconfig=$(KUBECONFIG) --namespace $(NAMESPACE) apply -f ../../.build/$(NAME).yaml;

	pushd ../../.build/$(NAME)-$(ISTIO_VERSION);\
		kubectl --kubeconfig=$(KUBECONFIG)  apply --namespace $(NAMESPACE)  -f samples/addons/prometheus.yaml;\
		kubectl --kubeconfig=$(KUBECONFIG)  apply --namespace $(NAMESPACE)  -f samples/addons/grafana.yaml;\
	popd

un_install_others:
	pushd ../../.build/$(NAME)-$(ISTIO_VERSION);\
		kubectl --kubeconfig=$(KUBECONFIG)  delete --namespace $(NAMESPACE)  -f samples/addons/prometheus.yaml;\
		kubectl --kubeconfig=$(KUBECONFIG)  delete --namespace $(NAMESPACE)  -f samples/addons/grafana.yaml;\
	popd
	kubectl --kubeconfig=$(KUBECONFIG) --namespace $(NAMESPACE) delete -f ../../.build/$(NAME).yaml;