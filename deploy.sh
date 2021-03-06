#!/bin/bash

echo Deploying Kubernetes
sudo kubeadm init --config=$HOME/kubeadm.conf

echo Setting Credentials for kubectl access
mkdir -p $HOME/.kube
sudo -H cp /etc/kubernetes/admin.conf $HOME/.kube/config
sudo -H chown $(id -u):$(id -g) $HOME/.kube/config
kubectl taint nodes --all=true  node-role.kubernetes.io/master:NoSchedule-

echo Deploying Calico CNI
kubectl apply -f https://docs.projectcalico.org/v2.5/getting-started/kubernetes/installation/hosted/kubeadm/1.6/calico.yaml

# Deploy Istio
kubectl create -f $ISTIO/istio/install/kubernetes/istio.yaml
kubectl create -f $ISTIO/istio/install/kubernetes/addons/prometheus.yaml
kubectl create -f $ISTIO/istio/install/kubernetes/addons/grafana.yaml
kubectl create -f $ISTIO/istio/install/kubernetes/addons/servicegraph.yaml
kubectl create -f $ISTIO/istio/install/kubernetes/addons/zipkin.yaml
kubectl create -f $ISTIO/istio/install/kubernetes/istio-initializer.yaml

echo VERTICAL
