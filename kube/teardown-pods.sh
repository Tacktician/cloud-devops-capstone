#!/bin/bash

kubectl --kubeconfig=config-aws delete pods,services -l app=dbz-app

kubectl --kubeconfig=config-aws delete pods,services -l app=mongodb

kubectl --kubeconfig=config-aws delete pods,services -l app=loadbalancer