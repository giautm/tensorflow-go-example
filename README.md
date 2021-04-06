# tensorflow-go-example

## First run step

You need to build `tensorflow-go:dev` in local by run the following command:

```sh
docker build -f ./.devcontainer/tensorflow-go.Dockerfile -t tensorflow-go:dev .
```

Then, reopen project with Cmd + Shift + P > "Remote Container: Rebuild and Reopen in Container"

Extra steps for new project
> Init Go modules with `go mod init giautm.dev/awesome-go`.
>
> In `go.mod` replace tensorflow with local version.
>
> ```
> module giautm.dev/awesome-go
> 
> go 1.16
> 
> replace github.com/tensorflow/tensorflow => /go/src/github.com/tensorflow/tensorflow
> ```

## Testing workspace

Run `go mod tidy` to test result

```sh
vscode ➜ /workspaces/tensorflow-go-example $ go mod tidy
go: found github.com/tensorflow/tensorflow/tensorflow/go in github.com/tensorflow/tensorflow v0.0.0-00010101000000-000000000000
go: found github.com/tensorflow/tensorflow/tensorflow/go/op in github.com/tensorflow/tensorflow v0.0.0-00010101000000-000000000000
go: finding module for package google.golang.org/protobuf/types/known/durationpb
go: finding module for package google.golang.org/protobuf/reflect/protoreflect
```

run `go run hello_tf.go` to check TensorFlow version
```sh
vscode ➜ /workspaces/tensorflow-go-example (master ✗) $ go run ./hello_tf.go 
2021-04-06 22:31:15.568705: I tensorflow/core/platform/cpu_feature_guard.cc:142] This TensorFlow binary is optimized with oneAPI Deep Neural Network Library (oneDNN) to use the following CPU instructions in performance-critical operations:  AVX2 FMA
To enable them in other operations, rebuild TensorFlow with the appropriate compiler flags.
2021-04-06 22:31:15.621638: I tensorflow/core/platform/profile_utils/cpu_utils.cc:112] CPU Frequency: 2400000000 Hz
Hello from TensorFlow version 2.4.1
```
