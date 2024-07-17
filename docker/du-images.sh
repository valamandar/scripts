# !/bin/bash 

docker system df --format "{{.Size}}" | numfmt --to=iec --format="%3f"
