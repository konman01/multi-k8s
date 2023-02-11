docker build -t konman01/multi-client:latest -t konman01/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t konman01/multi-server:latest -t konman01/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t konman01/multi-worker:latest -t konman01/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push konman01/multi-client:latest
docker push konman01/multi-server:latest
docker push konman01/multi-worker:latest

docker push konman01/multi-client:$SHA
docker push konman01/multi-server:$SHA
docker push konman01/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=konman01/multi-server:$SHA
kubectl set image deployments/client-deployment client=konman01/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=konman01/multi-worker:$SHA

