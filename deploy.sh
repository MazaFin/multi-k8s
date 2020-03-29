docker build -t mattipa1988/multi-client:latest -t mattipa1988/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t mattipa1988/multi-server:latest -t mattipa1988/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t mattipa1988/multi-worker:latest -t mattipa1988/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push mattipa1988/multi-client:latest
docker push mattipa1988/multi-server:latest
docker push mattipa1988/multi-worker:latest

docker push mattipa1988/multi-client:$SHA
docker push mattipa1988/multi-server:$SHA
docker push mattipa1988/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=mattipa1988/multi-server:$SHA
kubectl set image deployments/client-deployment client=mattipa1988/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=mattipa1988/multi-worker:$SHA