docker build -t bcp24521/multi-client:latest -t bcp24521/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t bcp24521/multi-server:latest -t bcp24521/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t bcp24521/multi-worker:latest -t bcp24521/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push bcp24521/multi-client:latest
docker push bcp24521/multi-server:latest
docker push bcp24521/multi-worker:latest

docker push bcp24521/multi-client:$SHA
docker push bcp24521/multi-server:$SHA
docker push bcp24521/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=bcp24521/multi-server:$SHA
kubectl set image deployments/client-deployment client=bcp24521/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=bcp24521/multi-worker:$SHA