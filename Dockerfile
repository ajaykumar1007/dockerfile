# Use an official Node.js runtime as the base image
FROM node:14-alpine

# Set the working directory inside the container
WORKDIR /app

# Copy package.json and package-lock.json to the working directory
COPY package*.json ./

# Install the project dependencies
RUN npm install

# Copy the rest of the application code to the working director
COPY . .

# Build the React app for production
RUN npm run build

# Use the official Nginx image as the base image for serving the React app
FROM nginx:alpine

# Copy the built React app from the previous stage to the Nginx webroot directory
COPY --from=0 /app/build /usr/share/nginx/html

# Expose port 80 to make the app accessible from the host
EXPOSE 80

# Start Nginx when the container starts
CMD ["nginx", "-g", "daemon off;"]
