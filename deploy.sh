docker build -t matipadocker/multi-client:latest -t matipadocker/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t matipadocker/multi-server:latest -t matipadocker/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t matipadocker/multi-worker:latest -t matipadocker/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push matipadocker/multi-client:latest
docker push matipadocker/multi-server:latest
docker push matipadocker/multi-worker:latest
docker push matipadocker/multi-client:$SHA
docker push matipadocker/multi-server:$SHA
docker push matipadocker/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=matipadocker/multi-server:$SHA
kubectl set image deployments/client-deployment client=matipadocker/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=matipadocker/multi-worker:$SHA
