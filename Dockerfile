# Use an official Node.js image as the base image
FROM node:14

# Set the working directory in the container
WORKDIR /app

# Install dbdocs globally using npm
RUN npm install -g dbdocs

# Expose the port used by dbdocs (default is 8080)
EXPOSE 8080

# Command to run dbdocs (customize as needed)
CMD ["dbdocs", "build", "/app/sample.dbml"]
