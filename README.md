## Setup

* Grant your gcloud user permission to create access tokens (for impersonation)
* Then run ```gcloud auth application-default login```


## Build and run load script

```
docker build -t dezoomcamp:hw4 .
```

```
docker run -it --rm \
    -v ~/.config/gcloud:/root/.config/gcloud \
    -e GOOGLE_APPLICATION_CREDENTIALS=/root/.config/gcloud/application_default_credentials.json \
    dezoomcamp:hw4
```

