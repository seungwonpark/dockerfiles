# dockerfiles

## build

```bash
DOCKER_BUILDKIT=1 docker build -f audio.dockerfile .
DOCKER_BUILDKIT=1 docker build --build_arg BASE_IMAGE=<base_image> -f audio.dockerfile .
```

## some references
- https://github.com/pytorch/pytorch/blob/master/Dockerfile
- https://github.com/jessfraz/dockerfiles
