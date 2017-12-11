#!/bin/bash
# Install virtualbox prior to running this deployment script

echo Deploying Kubernetes in Minikube
minikube start --cpus 4 --memory 4096 --kubernetes-version v1.8.5 --vm-driver virtualbox --bootstrapper kubeadm --feature-gates=CustomResourceValidation=true --extra-config=apiserver.authorization-mode=RBAC --extra-config=apiserver.admission-control="Initializers,NamespaceLifecycle,LimitRanger,ServiceAccount,DefaultStorageClass,GenericAdmissionWebhook,ResourceQuota,PodPreset"
kubectl taint nodes --all=true  node-role.kubernetes.io/master:NoSchedule-

# Deploy Istio
kubectl apply -f $ISTIO/istio/install/kubernetes/istio.yaml
#kubectl apply -f $ISTIO/istio/install/kubernetes/addons/prometheus.yaml
#kubectl apply -f $ISTIO/istio/install/kubernetes/addons/grafana.yaml
#kubectl apply -f $ISTIO/istio/install/kubernetes/addons/servicegraph.yaml
#kubectl apply -f $ISTIO/istio/install/kubernetes/addons/zipkin.yaml

echo VERTICAL
