docker build -t awais1331/multi-client:latest -t awais1331/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t awais1331/multi-server:latest -t awais1331/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t awais1331/multi-worker:latest -t awais1331/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push awais1331/multi-client:latest
docker push awais1331/multi-server:latest
docker push awais1331/multi-worker:latest

docker push awais1331/multi-client:$SHA
docker push awais1331/multi-server:$SHA
docker push awais1331/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=awais1331/multi-server:$SHA
kubectl set image deployments/client-deployment client=awais1331/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=awais1331/multi-worker:$SHA