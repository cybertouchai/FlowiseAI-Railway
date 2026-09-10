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

# Restore exact version: v1.4.3 (original deployed version)
RUN npm install -g flowise@1.4.3

WORKDIR /data

# Set environment variables
ENV PORT=8080

# Expose the specified port
EXPOSE ${PORT}

# Start the application with a delay
CMD /bin/sh -c "sleep 3; flowise start"

