FROM amazonlinux:2

# Install dependencies
RUN yum update -y && \
    yum install -y java-11-amazon-corretto wget unzip tar gzip shadow-utils coreutils curl && \
    yum clean all

# Set environment variables
ENV TOMCAT_VERSION=10.1.54
ENV TOMCAT_HOME=/opt/tomcat
ENV PATH=$PATH:$TOMCAT_HOME/bin

# Create tomcat user
RUN useradd -m -d /opt/tomcat -U -s /bin/false tomcat

# Install Tomcat 10
RUN wget https://downloads.apache.org/tomcat/tomcat-10/v${TOMCAT_VERSION}/bin/apache-tomcat-${TOMCAT_VERSION}.tar.gz && \
    tar -xzf apache-tomcat-${TOMCAT_VERSION}.tar.gz && \
    mv apache-tomcat-${TOMCAT_VERSION}/* $TOMCAT_HOME/ && \
    rm -rf apache-tomcat-${TOMCAT_VERSION} apache-tomcat-${TOMCAT_VERSION}.tar.gz

# ✅ Ensure required directories exist BEFORE permissions
RUN mkdir -p $TOMCAT_HOME/conf && \
    mkdir -p $TOMCAT_HOME/webapps/ROOT

# 🔥 Fix permissions (clean + safe)
RUN chown -R tomcat:tomcat $TOMCAT_HOME && \
    chmod -R 755 $TOMCAT_HOME && \
    chmod -R 775 $TOMCAT_HOME/conf

# Remove default apps
RUN rm -rf $TOMCAT_HOME/webapps/*

# Recreate ROOT directory (after cleanup)
RUN mkdir -p $TOMCAT_HOME/webapps/ROOT && \
    chown -R tomcat:tomcat $TOMCAT_HOME/webapps

# Copy application files
COPY index.jsp $TOMCAT_HOME/webapps/ROOT/index.jsp
COPY server.xml $TOMCAT_HOME/conf/server.xml

# Copy startup script
COPY start.sh /start.sh
RUN chmod +x /start.sh

# Switch to non-root user
USER tomcat

# Expose ports
EXPOSE 8080 8443

# Start container
CMD ["/start.sh"]
