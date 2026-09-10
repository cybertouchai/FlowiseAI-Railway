FROM node:18-alpine

USER root

RUN apk add --no-cache git
RUN apk add --no-cache python3 py3-pip make g++
# needed for pdfjs-dist
RUN apk add --no-cache build-base cairo-dev pango-dev

# Install Chromium
RUN apk add --no-cache chromium

ENV PUPPETEER_SKIP_DOWNLOAD=true
ENV PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium-browser

# Try Flowise v1.1.0 - early version without heavy undici dependency
RUN npm install -g flowise@1.1.0

# Create .flowise directory with proper permissions
RUN mkdir -p /root/.flowise && chmod 755 /root/.flowise

WORKDIR /data

# Set environment variables
ENV PORT=8080

# Expose the specified port
EXPOSE ${PORT}

# Start the application with a delay
CMD /bin/sh -c "sleep 3; flowise start"

