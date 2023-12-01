FROM owncloud/server:latest

ENV PATH="/mnt/data/:${PATH}"

RUN apt-get update

CMD ["/bin/bash"]

COPY entrypoint.sh /usr/local/bin/

RUN chmod +x /usr/local/bin/entrypoint.sh

CMD ["/usr/local/bin/entrypoint.sh"]
