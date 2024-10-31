#!/bin/bash

CILIUM_VERSION=${CILIUM:-v1.14.5}

function deploy_cilium() {
	if [[ -d ./cilium ]];then 
	       rm -rf ./cilium
	fi

	curl -Lk --create-dirs https://raw.githubusercontent.com/isovalent/olm-for-cilium/main/manifests/cilium.${CILIUM_VERSION}/cluster-network-03-cilium-ciliumconfigs-crd.yaml -o ./cilium/cluster-network-03-cilium-ciliumconfigs-crd.yaml
	curl -Lk --create-dirs https://raw.githubusercontent.com/isovalent/olm-for-cilium/main/manifests/cilium.${CILIUM_VERSION}/cluster-network-06-cilium-00000-cilium-namespace.yaml -o ./cilium/cluster-network-06-cilium-00000-cilium-namespace.yaml
	curl -Lk --create-dirs https://raw.githubusercontent.com/isovalent/olm-for-cilium/main/manifests/cilium.${CILIUM_VERSION}/cluster-network-06-cilium-00001-cilium-olm-serviceaccount.yaml -o ./cilium/cluster-network-06-cilium-00001-cilium-olm-serviceaccount.yaml
	curl -Lk --create-dirs https://raw.githubusercontent.com/isovalent/olm-for-cilium/main/manifests/cilium.${CILIUM_VERSION}/cluster-network-06-cilium-00002-cilium-olm-deployment.yaml -o ./cilium/cluster-network-06-cilium-00002-cilium-olm-deployment.yaml
	curl -Lk --create-dirs https://raw.githubusercontent.com/isovalent/olm-for-cilium/main/manifests/cilium.${CILIUM_VERSION}/cluster-network-06-cilium-00003-cilium-olm-service.yaml -o ./cilium/cluster-network-06-cilium-00003-cilium-olm-service.yaml
	curl -Lk --create-dirs https://raw.githubusercontent.com/isovalent/olm-for-cilium/main/manifests/cilium.${CILIUM_VERSION}/cluster-network-06-cilium-00004-cilium-olm-leader-election-role.yaml -o ./cilium/cluster-network-06-cilium-00004-cilium-olm-leader-election-role.yaml
	curl -Lk --create-dirs https://raw.githubusercontent.com/isovalent/olm-for-cilium/main/manifests/cilium.${CILIUM_VERSION}/cluster-network-06-cilium-00005-cilium-olm-role.yaml -o ./cilium/cluster-network-06-cilium-00005-cilium-olm-role.yaml
	curl -Lk --create-dirs https://raw.githubusercontent.com/isovalent/olm-for-cilium/main/manifests/cilium.${CILIUM_VERSION}/cluster-network-06-cilium-00006-leader-election-rolebinding.yaml -o ./cilium/cluster-network-06-cilium-00006-leader-election-rolebinding.yaml
	curl -Lk --create-dirs https://raw.githubusercontent.com/isovalent/olm-for-cilium/main/manifests/cilium.${CILIUM_VERSION}/cluster-network-06-cilium-00007-cilium-olm-rolebinding.yaml -o ./cilium/cluster-network-06-cilium-00007-cilium-olm-rolebinding.yaml
	curl -Lk --create-dirs https://raw.githubusercontent.com/isovalent/olm-for-cilium/main/manifests/cilium.${CILIUM_VERSION}/cluster-network-06-cilium-00008-cilium-cilium-olm-clusterrole.yaml -o ./cilium/cluster-network-06-cilium-00008-cilium-cilium-olm-clusterrole.yaml
	curl -Lk --create-dirs https://raw.githubusercontent.com/isovalent/olm-for-cilium/main/manifests/cilium.${CILIUM_VERSION}/cluster-network-06-cilium-00009-cilium-cilium-clusterrole.yaml -o ./cilium/cluster-network-06-cilium-00009-cilium-cilium-clusterrole.yaml
	curl -Lk --create-dirs https://raw.githubusercontent.com/isovalent/olm-for-cilium/main/manifests/cilium.${CILIUM_VERSION}/cluster-network-06-cilium-00010-cilium-cilium-olm-clusterrolebinding.yaml -o ./cilium/cluster-network-06-cilium-00010-cilium-cilium-olm-clusterrolebinding.yaml
	curl -Lk --create-dirs https://raw.githubusercontent.com/isovalent/olm-for-cilium/main/manifests/cilium.${CILIUM_VERSION}/cluster-network-06-cilium-00011-cilium-cilium-clusterrolebinding.yaml -o ./cilium/cluster-network-06-cilium-00011-cilium-cilium-clusterrolebinding.yaml
	sync_images
	PODCIDR=$(oc get network cluster -o jsonpath='{.spec.clusterNetwork[0].cidr}')
	HOSTPREFIX=$(oc get network cluster -o jsonpath='{.spec.clusterNetwork[0].hostPrefix}')
	sed -i "s/quay.io/${REGISTRY}/g" ./cilium/cluster-network-06-cilium-00002-cilium-olm-deployment.yaml
	sed -i "s/registry.connect.redhat.com/${REGISTRY}/g" ./cilium/cluster-network-06-cilium-00002-cilium-olm-deployment.yaml
	oc apply -f ./cilium
	curl -Lk --create-dirs https://raw.githubusercontent.com/isovalent/olm-for-cilium/main/manifests/cilium.${CILIUM_VERSION}/cluster-network-07-cilium-ciliumconfig.yaml -o ./cilium/cluster-network-07-cilium-ciliumconfig_RAW.yaml
	oc patch --local=true -f ./cilium/cluster-network-07-cilium-ciliumconfig_RAW.yaml -p "{\"spec\": {\"ipam\": {\"operator\":{\"clusterPoolIPv4PodCIDRList\":\"${PODCIDR}\",\"clusterPoolIPv4MaskSize\": \"${HOSTPREFIX}\"}}}}" --type merge -o yaml > ./cilium/cluster-network-07-cilium-ciliumconfig.yaml
	oc apply -f ./cilium/cluster-network-07-cilium-ciliumconfig.yaml
	rm -f ./cilium/cluster-network-07-cilium-ciliumconfig_RAW.yaml
}

function sync_images() {
	for image in $(cat ./cilium/cluster-network-06-cilium-00002-cilium-olm-deployment.yaml | egrep 'quay|redhat' | awk '{print $2}')
	do 
		echo "Syncing image: $image"
		IMG=${image#*/}
		NEW_IMG=${REGISTRY}/${IMG}
		skopeo copy --authfile $PULL_SECRET_PATH --all docker://${image} docker://${NEW_IMG}
	done
}


deploy_cilium
