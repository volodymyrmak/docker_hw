# Use alpine:latest as a base image
FROM alpine:latest

# Provide port "80"
EXPOSE 80

# Set bindpoint as an ENV variable
ENV BIND_POINT="/home/network/bind_point/"

# Create separate user for isolation of the network responsibilities
# and create bindpoint dir for testing communication between containers
RUN adduser -D network \
    && mkdir ${BIND_POINT}
