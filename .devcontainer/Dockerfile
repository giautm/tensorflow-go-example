# See here for image contents: https://github.com/microsoft/vscode-dev-containers/tree/v0.163.1/containers/go/.devcontainer/base.Dockerfile

# [Choice] Go version: 1, 1.16, 1.15
ARG VARIANT="1"
FROM tensorflow-go:dev as builder

FROM mcr.microsoft.com/vscode/devcontainers/go:0-${VARIANT}

COPY --from=builder /usr/local/lib/libtensorflow* /usr/local/lib
COPY --from=builder /go/src/github.com/tensorflow/tensorflow/ \
  $GOPATH/src/github.com/tensorflow/tensorflow/

RUN ldconfig

# [Optional] Uncomment this section to install additional OS packages.
# RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
#     && apt-get -y install --no-install-recommends <your-package-list-here>

# [Optional] Uncomment the next line to use go get to install anything else you need
# RUN go get -x <your-dependency-or-tool>
