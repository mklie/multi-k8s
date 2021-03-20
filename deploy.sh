docker build -t mklie/multi-client-k8s:latest -t mklie/multi-client-k8s:$SHA -f ./client/Dockerfile ./client
docker build -t mklie/multi-server-k8s-pgfix:latest -t mklie/multi-server-k8s-pgfix:$SHA -f ./server/Dockerfile ./server
docker build -t mklie/multi-worker-k8s:latest -t mklie/multi-worker-k8s:$SHA -f ./worker/Dockerfile ./worker

docker push mklie/multi-client-k8s:latest
docker push mklie/multi-server-k8s-pgfix:latest
docker push mklie/multi-worker-k8s:latest

docker push mklie/multi-client-k8s:$SHA
docker push mklie/multi-server-k8s-pgfix:$SHA
docker push mklie/multi-worker-k8s:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=mklie/multi-server-k8s-pgfix:$SHA
kubectl set image deployments/client-deployment client=mklie/multi-client-k8s:$SHA
kubectl set image deployments/worker-deployment worker=mklie/multi-worker-k8s:$SHA
