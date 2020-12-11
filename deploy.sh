docker build -t kebap/multi-client:latest -t kebap/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t kebap/multi-server:latest -t kebap/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t kebap/multi-worker:latest -t kebap/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push kebap/multi-client:latest
docker push kebap/multi-server:latest
docker push kebap/multi-worker:latest

docker push kebap/multi-client:$SHA
docker push kebap/multi-server:$SHA
docker push kebap/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=kebap/multi-server:$SHA
kubectl set image deployments/client-deployment client=kebap/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=kebap/multi-worker:$SHA
