FROM ubuntu:16.04

RUN apt-get -qq -y update && \
    apt-get -qq -y install openjdk-8-jdk ant curl && \
    rm -rf /var/cache/apt /var/lib/apt/lists/*

# Your deployment script here

# Copy sources to tmp directory
COPY . /tmp/build

# build and clean up 
RUN ant -buildfile /tmp/build/build.xml && \
    mkdir /app && \
    mv /tmp/build/dist /app && \
    rm -rf /tmp/build 

# Expose port 8080 to hosts interface
EXPOSE 8080

# Run app 
CMD [ "java", "-cp", "/app/dist/amazon-keyword-estimate.jar:/app/dist/lib/*:dist/conf", "com.keyword.KeywordMain" ]