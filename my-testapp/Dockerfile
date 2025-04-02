# Use a stable Node.js version
FROM node:18-alpine 

# Set the working directory
WORKDIR /app

# Use the public NPM registry
RUN npm config set registry https://registry.npmjs.org/

# Copy package files and install dependencies
COPY package*.json ./

RUN npm install 

# Copy the rest of the app files
COPY . .

# Expose the port and start the app
EXPOSE 3000
CMD ["npm", "start"]
