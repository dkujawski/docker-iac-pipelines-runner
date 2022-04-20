FROM ubuntu:20.04

ENV CONFTEST_DOWNLOAD_URL=https://github.com/open-policy-agent/conftest/releases/download/v0.28.2/conftest_0.28.2_Linux_x86_64.tar.gz
ENV CONFTEST_VERSION=0.28.2
ENV OPA_DOWNLOAD_URL=https://github.com/open-policy-agent/opa/releases/download/v0.34.1/opa_linux_amd64
ENV OPA_VERSION=v0.34.1
ENV TFLINT_DOWNLOAD_URL=https://github.com/terraform-linters/tflint/releases/download/v0.35.0/tflint_linux_amd64.zip
ENV TFLINT_VERSION=v0.35.0
ENV TERRAFORM_DOCS_DOWNLOAD_URL=https://github.com/terraform-docs/terraform-docs/releases/download/v0.16.0/terraform-docs-v0.16.0-linux-amd64.tar.gz
ENV TERRAFORM_DOCS_VERSION=v0.16.0
ENV TERRAFORM_VERSION=0.13.5
ENV JQ_DOWNLOAD_URL=https://github.com/stedolan/jq/releases/download/jq-1.6/jq-linux64
ENV JQ_VERSION=1.6

RUN apt-get update && apt-get install -y python3.9 python3.9-dev python3-pip python3-wheel build-essential && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

RUN /bin/sh -c curl -L -o /usr/local/bin/jq $JQ_DOWNLOAD_URL && chmod 755 /usr/local/bin/jq && git clone https://github.com/tfutils/tfenv.git $HOME/.tfenv && echo 'PATH="$HOME/.tfenv/bin:$PATH"' >> $HOME/.bashrc && . $HOME/.bashrc && tfenv install $TERRAFORM_VERSION && tfenv use $TERRAFORM_VERSION && terraform version && chown -R default:0 $HOME/.tfenv && curl -L -o terraform-docs.tar.gz $TERRAFORM_DOCS_DOWNLOAD_URL && tar xzvf terraform-docs.tar.gz -C /usr/local/bin terraform-docs && chmod 755 /usr/local/bin/terraform-docs && curl -L -o tflint.zip $TFLINT_DOWNLOAD_URL && unzip tflint.zip -d /usr/local/bin && chmod 755 /usr/local/bin/tflint && curl -L -o /usr/local/bin/opa $OPA_DOWNLOAD_URL && chmod 755 /usr/local/bin/opa && curl -L -o conftest.tar.gz $CONFTEST_DOWNLOAD_URL && tar xzvf conftest.tar.gz -C /usr/local/bin conftest && chmod 755 /usr/local/bin/conftest && pip3 install awscli pre-commit && rm -fr *.gz *.zip # buildkit

ENV PATH=/opt/app-root/src/.tfenv/bin:/opt/app-root/src/.local/bin/:/opt/app-root/src/bin:/opt/app-root/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

CMD ["/usr/bin/container-entrypoint"]
