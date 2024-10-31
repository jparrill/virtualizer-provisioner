###
# Helm
###
# helm repo add kubeinvaders https://lucky-sideburn.github.io/helm-charts/
# helm repo update
# helm install kubeinvaders --set-string config.target_namespace="targets" -n kubeinvaders kubeinvaders/kubeinvaders --set ingress.enabled=true --set ingress.hostName=kubeinvaders.apps.hosted.hypershiftbm.lab --set deployment.image.tag=v1.9.6
###

kubectl create namespace kubeinvaders
oc create ns targets
oc apply -f render.yaml
oc adm policy add-scc-to-user anyuid -z kubeinvaders
kubectl create deployment -n targets --replicas 30 targets --image=${REGISTRY}/e2e-test-images/agnhost:2.39 -- /agnhost netexec --http-port=8080
