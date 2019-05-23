docker build -t miguelgmedina/multi-client:latest -t miguelgmedina/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t miguelgmedina/multi-server:latest -t miguelgmedina/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t miguelgmedina/multi-worker:latest -t miguelgmedina/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push miguelgmedina/multi-client:latest
docker push miguelgmedina/multi-server:latest
docker push miguelgmedina/multi-worker:latest
docker push miguelgmedina/multi-client:$SHA
docker push miguelgmedina/multi-server:$SHA
docker push miguelgmedina/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/client-deployment client=miguelgmedina/multi-client:$SHA
kubectl set image deployments/server-deployment server=miguelgmedina/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=miguelgmedina/multi-worker:$SHA
