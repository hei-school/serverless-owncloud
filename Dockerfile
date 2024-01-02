FROM scratch
ARG RELEASE
ARG LAUNCHPAD_BUILD_ARCH
LABEL org.opencontainers.image.ref.name="ubuntu"
LABEL org.opencontainers.image.version="20.04"
ADD file:4809da414c2d478b4d991cbdaa2df457f2b3d07d0ff6cf673f09a66f90833e81 in / 
CMD ["/bin/bash"]