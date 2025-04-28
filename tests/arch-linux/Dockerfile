FROM archlinux:base-20250420.0.338771

RUN pacman -Sy --noconfirm sudo

ENV HOME="/home/user"
ARG SETUP_DIR="$HOME/.miautawn-setup"

COPY . $SETUP_DIR
WORKDIR $SETUP_DIR

ENTRYPOINT ["/bin/bash", "-c"]
CMD ["echo 'Hello from the default command!'"]