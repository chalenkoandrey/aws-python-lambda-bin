# Lambda Layer Creation Script

This repository contains scripts and files to create a Lambda layer using Docker. The layer packages the Python libraries specified in the `requirements.txt` file.

## Prerequisites

Before running the scripts, ensure that you have the following prerequisites:

- Docker installed on your machine
- Access to the command line or terminal

## Script Files

The repository includes one script file:

`create_layer.sh`: This is a Bash script intended for Unix-based systems (Linux, macOS).


## Requirements File and Dockerfile

The `requirements.txt` file lists the Python libraries that you want to include in your Lambda layer. Each library should be specified on a separate line. In this example, the `requests` library is included.

The `Dockerfile` contains the instructions for building the Docker image that will be used to create the Lambda layer. It specifies the base image, installs the necessary dependencies, copies the `requirements.txt` file, and installs the listed Python libraries.