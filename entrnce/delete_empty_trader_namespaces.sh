# Set the context to the test cluster
kubectl config use-context tst

# Get all namespaces that start with 'trader-'
namespaces=$(kubectl get ns --no-headers -o custom-columns=":metadata.name" | grep '^trader-')

# Iterate through each namespace individually in parallel
echo "$namespaces" | while read -r ns; do
  (
    # Check if there are any running pods in the namespace
    running_pods=$(kubectl get pods -n $ns --field-selector=status.phase=Running --no-headers)

    # If there are no running pods, delete the namespace
    if [ -z "$running_pods" ]; then
      echo "Deleting namespace: $ns"
      kubectl delete ns $ns
    else
      echo "Namespace $ns has running pods, skipping..."
    fi
  ) &
done

# Wait for all background jobs to finish
wait