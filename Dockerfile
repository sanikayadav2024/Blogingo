# Use official Tomcat 9 image as the base
FROM tomcat:9.0

# Remove default Tomcat apps
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy your JSP app into Tomcat’s ROOT directory
COPY . /usr/local/tomcat/webapps/ROOT/

# Expose the default Tomcat HTTP port
EXPOSE 8080

# Start Tomcat when the container launches
CMD ["catalina.sh", "run"]
