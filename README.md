# Testify Plumber

## Purpose

Testify plumber is a collection of scripts that can be used to generate the boilerplate code for mocking with Testify

## Usage

To generate an interface for a struct file

```shell
./generate_interface.sh user_repository.go
```

To generate a mock

```shell
./generate_testify_boilerplate.sh user_repository.go MockUserRepository > mock_user_repository.go
```
