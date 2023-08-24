# build environment
#FROM node:9.6.1 as builder
#RUN mkdir -p /usr/src/app
#WORKDIR /usr/src/app
#ENV PATH /usr/src/app/node_modules/.bin:$PATH
#COPY package.json /usr/src/app/package.json
#RUN npm install 
#RUN npm install react-scripts@latest
#COPY . /usr/src/app
#RUN npm run build

# npm install react-scripts@1.1.1 -g --silent

# production environment
#FROM nginx:1.13.9-alpine
#COPY --from=builder /usr/src/app/build /usr/share/nginx/html
#EXPOSE 80
#CMD ["nginx", "-g", "daemon off;"]

# Use the official Node.js image as the base image
FROM node:14

# Set the working directory inside the container
WORKDIR /usr/src/app

# Copy package.json and package-lock.json to the working directory
COPY package*.json ./

# Install project dependencies
RUN npm install

# Install a specific version of PostgreSQL client (pg_dump)
#RUN apt-get update && apt-get install -y postgresql-client-12=12.15-0+deb10u1 || apt-get install -y postgresql-client


# Copy the rest of the application code to the working directory
COPY . .

# Build the application
RUN npm run build

# Expose a port (if needed)
# EXPOSE 80

# Start the application when the container runs
CMD [ "npm", "start" ]
