# Dockerfile
FROM node:18

# Create app directory
WORKDIR /app

# Copy only package.json & lock first for caching
COPY package*.json ./

# Install dependencies
RUN npm install --production

# Copy rest of the code
COPY . .

# Expose the port your app runs on
EXPOSE 3000

# Default command
CMD ["npm", "start"]
