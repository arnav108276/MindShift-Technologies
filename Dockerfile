# Use Node.js base image
FROM node:14

# Set the working directory inside the container
WORKDIR /app

# Copy package.json and install dependencies
COPY package*.json ./
RUN npm install

# Copy the entire project to the container
COPY . .

# Expose the port the app will run on
EXPOSE 80

# Run the app
CMD ["npm", "start"]
