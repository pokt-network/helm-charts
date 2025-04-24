# This Dockerfile provides a pre-built image with snapshot tools
# As an alternative to installing packages at runtime in the StatefulSet

FROM ubuntu:22.04

# Install dependencies for snapshot downloading and extraction
RUN apt-get update && \
    apt-get install -y \
    curl \
    wget \
    aria2 \
    zstd \
    tar \
    jq \
    ca-certificates \
    findutils \
    bash && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Set up a non-root user (optional, matches the user you'll run as in Kubernetes)
RUN useradd -u 1000 -m -s /bin/bash pocket

WORKDIR /opt/snapshot

# Basic health check
HEALTHCHECK --interval=5m --timeout=3s \
  CMD curl -f https://snapshots.us-nj.poktroll.com || exit 1

# Use bash as the entrypoint to allow for easier script execution
ENTRYPOINT ["/bin/bash"]
CMD ["-c", "echo 'Snapshot container is ready to use'"]

# Note: This Dockerfile is provided as a reference implementation.
# The helm chart now installs packages directly in the StatefulSet
# for simplicity, but you can build this image if you prefer to
# avoid installing packages at runtime. 