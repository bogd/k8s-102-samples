#!/bin/bash

kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v0.35.0/deploy/static/provider/baremetal/deploy.yaml

kubectl patch -n ingress-nginx svc ingress-nginx-controller -p '{"spec":{"ports":[{"port":80, "nodePort":31080}, {"port":443, "nodePort":31443}]}}'


# Not mandatory, but recommended:
# https://kubernetes.github.io/ingress-nginx/deploy/
# The first time the ingress controller starts, two Jobs create the SSL Certificate used by the admission webhook. 
# For this reason, there is an initial delay of up to two minutes until it is possible to create and validate Ingress definitions.
kubectl wait --namespace ingress-nginx \
  --for=condition=ready pod \
  --selector=app.kubernetes.io/component=controller \
  --timeout=120s
