# Copyright 2017-2018 Amazon.com, Inc. or its affiliates. All Rights Reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License"). You
# may not use this file except in compliance with the License. A copy of
# the License is located at
#
#     http://aws.amazon.com/apache2.0/
#
# or in the "license" file accompanying this file. This file is
# distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF
# ANY KIND, either express or implied. See the License for the specific
# language governing permissions and limitations under the License.

# For more information on creating a Dockerfile
# https://docs.docker.com/compose/gettingstarted/#step-2-create-a-dockerfile
# https://github.com/awslabs/amazon-sagemaker-examples/master/advanced_functionality/pytorch_extending_our_containers/pytorch_extending_our_containers.ipynb
ARG REGION=us-west-2

# SageMaker PyTorch image
FROM 763104351884.dkr.ecr.us-west-2.amazonaws.com/pytorch-training:1.8.1-gpu-py36-cu111-ubuntu18.04
ENV PATH="/opt/ml/code:${PATH}"
RUN pip install ninja

# /opt/ml and all subdirectories are utilized by SageMaker, we use the /code subdirectory to store our user code.
COPY /stylegan2-ada-pytorch /opt/ml/code
COPY changehostname.c /opt/ml/code
COPY start_with_right_hostname.sh /usr/local/bin/start_with_right_hostname.sh

# this environment variable is used by the SageMaker PyTorch container to determine our user code directory.
ENV SAGEMAKER_SUBMIT_DIRECTORY /opt/ml/code

# this environment variable is used by the SageMaker PyTorch container to determine our program entry point
# for training and serving.
# For more information: https://github.com/aws/sagemaker-pytorch-container
ENV SAGEMAKER_PROGRAM train.py