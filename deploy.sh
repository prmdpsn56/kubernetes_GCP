docker build -t prmdpsn56/multi-client:latest -t prmdpsn56/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t prmdpsn56/multi-server:latest -t prmdpsn56/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t prmdpsn56/multi-worker:latest -t prmdpsn56/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push prmdpsn56/multi-client:latest
docker push prmdpsn56/multi-server:latest
docker push prmdpsn56/multi-worker:latest

docker push prmdpsn56/multi-client:$SHA
docker push prmdpsn56/multi-server:$SHA
docker push prmdpsn56/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=prmdpsn56/multi-server:$SHA
kubectl set image deployments/client-deployment client=prmdpsn56/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=prmdpsn56/multi-worker:$SHA