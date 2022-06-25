FROM pytorch/torchserve:latest

# Copy files over
COPY scripts/init_model.sh /home/model-server/init_model.sh
COPY scripts/download_model.sh /home/model-server/download_model.sh
# Prepare to start server
USER root
RUN chmod +x /home/model-server/download_model.sh
RUN chmod +x /home/model-server/init_model.sh
EXPOSE 8080 8081
RUN pip install torch-model-archiver -q
USER model-server
# For creating models
RUN /home/model-server/download_model.sh
RUN /home/model-server/init_model.sh
