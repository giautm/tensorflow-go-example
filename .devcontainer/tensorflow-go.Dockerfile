FROM golang:1.16.1-buster

RUN apt-get update && \
  export DEBIAN_FRONTEND=noninteractive && \
  apt-get -y install --no-install-recommends curl unzip

ENV PROTOC_VERSION "3.14.0"
ENV PROTOC_GEN_GO_VERSION "1.4.3"

# Install protoc
RUN curl -sfLo protoc.zip "https://github.com/protocolbuffers/protobuf/releases/download/v${PROTOC_VERSION}/protoc-${PROTOC_VERSION}-linux-x86_64.zip" && \
  mkdir protoc && \
  unzip -q -d protoc protoc.zip && \
  cp ./protoc/bin/protoc /usr/local/bin/protoc && \
  cp -r ./protoc/include/google /usr/local/include/google && \
  rm protoc.zip

# Install gen-go
RUN git clone -q https://github.com/golang/protobuf && \
  cd protobuf && \
  git checkout -q tags/v${PROTOC_GEN_GO_VERSION} -b build && \
  go build -o /go/bin/protoc-gen-go ./protoc-gen-go && \
  rm -rf ./protobuf

ENV TF_VERSION "2.4.1"

RUN curl -sfLo libtensorflow.tar.gz \
  "https://storage.googleapis.com/tensorflow/libtensorflow/libtensorflow-cpu-linux-x86_64-${TF_VERSION}.tar.gz" && \
  tar -C /usr/local -xzf libtensorflow.tar.gz && \
  ldconfig

WORKDIR $GOPATH/src/github.com/tensorflow
RUN git clone --depth 1 --branch v$TF_VERSION \
  https://github.com/tensorflow/tensorflow.git

# switch go modules to "auto" for run go genarate in GOPATH
RUN go env -w GO111MODULE=auto
RUN go generate github.com/tensorflow/tensorflow/tensorflow/go/op

# Support go modules
WORKDIR $GOPATH/src/github.com/tensorflow/tensorflow
RUN go mod init github.com/tensorflow/tensorflow
RUN cp -r \
  ./tensorflow/go/vendor/github.com/tensorflow/tensorflow/tensorflow/go/core \
  ./tensorflow/go/vendor/github.com/tensorflow/tensorflow/tensorflow/go/stream_executor \
  ./tensorflow/go && \
  rm -rf ./vendor
