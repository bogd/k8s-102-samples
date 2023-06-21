#!/bin/bash

kubectl patch pv wordpress-00-01 -p '{"spec":{"claimRef": null}}'
kubectl patch pv wordpress-00-02 -p '{"spec":{"claimRef": null}}'
