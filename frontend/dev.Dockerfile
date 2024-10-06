FROM node:18-alpine

WORKDIR /app

# Install dependencies based on the preferred package manager
COPY package.json yarn.lock* package-lock.json* pnpm-lock.yaml* ./

# Enable preferred package manager
RUN \
  if [ -f yarn.lock ]; then corepack enable yarn; \
  elif [ -f pnpm-lock.yaml ]; then corepack enable pnpm; \
  # Allow install without lockfile, so example works even without Node.js installed locally
  else echo "Warning: Lockfile not found. It is recommended to commit lockfiles to version control." && corepack enable yarn; \
  fi

# Install packages
RUN \
  if [ -f yarn.lock ]; then yarn --frozen-lockfile; \
  elif [ -f package-lock.json ]; then npm ci; \
  elif [ -f pnpm-lock.yaml ]; then corepack enable pnpm && pnpm i; \
  # Allow install without lockfile, so example works even without Node.js installed locally
  else echo "Warning: Lockfile not found. It is recommended to commit lockfiles to version control." && yarn install; \
  fi

# Copy all config files.
COPY *config.* .

# Disable Next.js telemetry
RUN \
  if [ -f yarn.lock ]; then yarn next telemetry disable; \
  elif [ -f package-lock.json ]; then npx next telemetry disable; \
  elif [ -f pnpm-lock.yaml ]; then pnpm exec next telemetry disable; \
  else npx next telemetry disable; \
  fi

# Start Next.js in development mode based on the preferred package manager
CMD \
  if [ -f yarn.lock ]; then yarn dev; \
  elif [ -f package-lock.json ]; then npm run dev; \
  elif [ -f pnpm-lock.yaml ]; then pnpm dev; \
  else npm run dev; \
  fi
