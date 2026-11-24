FROM node:22-alpine

WORKDIR /app

# Copy dependency manifests first to cache npm install layers
COPY package*.json ./
RUN npm ci
RUN npm ci && npm install --no-save @types/node

# Copy the rest of the repository
COPY . .

EXPOSE 3000

# Bind to 0.0.0.0 so the dev server is accessible outside the container
CMD ["npm", "run", "start", "--", "--host", "0.0.0.0"]
