FROM ubuntu:latest
RUN apt-get update && apt-get install -y gnupg
RUN apt-get install -y wget
RUN wget https://get.helm.sh/helm-v3.5.2-linux-amd64.tar.gz
RUN tar -zxvf helm-v3.5.2-linux-amd64.tar.gz
RUN mv linux-amd64/helm /usr/local/bin/helm
RUN apt install -y unzip
RUN wget "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip"
RUN unzip awscli-exe-linux-x86_64.zip
RUN ./aws/install -i /usr/local/aws-cli -b /usr/local/bin
RUN wget https://storage.googleapis.com/kubernetes-release/release/v1.7.0/bin/linux/amd64/kubectl
RUN chmod +x ./kubectl
RUN mv ./kubectl /usr/local/bin/kubectl
RUN wget https://amazon-eks.s3.us-west-2.amazonaws.com/1.19.6/2021-01-05/bin/linux/amd64/aws-iam-authenticator
RUN chmod +x ./aws-iam-authenticator
RUN mv ./aws-iam-authenticator /usr/local/bin/aws-iam-authenticator
RUN gpg --version
