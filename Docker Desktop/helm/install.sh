RELEASE="${1:-eoloplanner-release}"
CLUSTERIP="${2:-cluster-ip}"
helm install ${RELEASE} ./eoloplanner --set ingress.hosts.host=${CLUSTERIP}