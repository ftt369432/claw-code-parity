#!/bin/bash
# Load environment variables from .env file
# Usage: source load-env.sh

if [ -f ".env" ]; then
    echo "Loading environment from .env file..."
    set -a
    source .env
    set +a
    echo "Environment loaded successfully!"
else
    echo "No .env file found. Copy .env.example to .env and configure your API keys."
fi