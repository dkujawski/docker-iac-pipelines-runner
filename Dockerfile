FROM registry.access.redhat.com/ubi8/python-39:1-35

USER root

ENV CONFTEST_DOWNLOAD_URL=https://github.com/open-policy-agent/conftest/releases/download/v0.28.2/conftest_0.28.2_Linux_x86_64.tar.gz
ENV CONFTEST_VERSION=0.28.2
ENV OPA_DOWNLOAD_URL=https://github.com/open-policy-agent/opa/releases/download/v0.34.1/opa_linux_amd64
ENV OPA_VERSION=v0.34.1
ENV TFLINT_DOWNLOAD_URL=https://github.com/terraform-linters/tflint/releases/download/v0.35.0/tflint_linux_amd64.zip
ENV TFLINT_VERSION=v0.35.0
ENV TERRAFORM_DOCS_DOWNLOAD_URL=https://github.com/terraform-docs/terraform-docs/releases/download/v0.16.0/terraform-docs-v0.16.0-linux-amd64.tar.gz
ENV TERRAFORM_DOCS_VERSION=v0.16.0
ENV TERRAFORM_DOWNLOAD_URL=https://releases.hashicorp.com/terraform/0.13.5/terraform_0.13.5_linux_amd64.zip
ENV TERRAFORM_VERSION=0.13.5

SHELL ["/bin/bash", "-c"]

RUN \
    echo "direct install other tools" && \
    curl --silent --location --output terraform-docs.tar.gz $TERRAFORM_DOCS_DOWNLOAD_URL && \
    tar xzvf terraform-docs.tar.gz -C /usr/local/bin terraform-docs && chmod 755 /usr/local/bin/terraform-docs && \
    curl --silent --location --output tflint.zip $TFLINT_DOWNLOAD_URL && \
    unzip tflint.zip -d /usr/local/bin && chmod 755 /usr/local/bin/tflint && \
    curl --silent --location --output terraform.zip $TERRAFORM_DOWNLOAD_URL && \
    unzip terraform.zip -d /usr/local/bin && chmod 755 /usr/local/bin/terraform && terraform version &&\
    curl --silent --location --output /usr/local/bin/opa $OPA_DOWNLOAD_URL && chmod 755 /usr/local/bin/opa && \
    curl --silent --location --output conftest.tar.gz $CONFTEST_DOWNLOAD_URL && \
    tar xzvf conftest.tar.gz -C /usr/local/bin conftest && chmod 755 /usr/local/bin/conftest && \
    echo "pip installs" && pip --version && \
    pip install pre-commit && \
    echo "final cleanup" && \
    rm -fr *.gz *.zip && \
    echo "exit 0" > entrypoint.sh && chmod 755 entrypoint.sh

USER default

CMD ["entrypoint.sh"]
