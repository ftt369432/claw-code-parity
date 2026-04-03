#!/bin/bash
# Test script to verify Claw Code configuration
# Usage: ./test-config.sh [model-name]

MODEL=${1:-"llama3.1-70b-8192"}

echo "Testing Claw Code configuration..."
echo "Model: $MODEL"
echo "OpenAI API Key: ${OPENAI_API_KEY:+SET (length: ${#OPENAI_API_KEY})}"
echo "OpenAI Base URL: ${OPENAI_BASE_URL:-NOT SET}"
echo ""

if [ -z "$OPENAI_API_KEY" ]; then
    echo "❌ OPENAI_API_KEY not set. Please configure your .env file."
    exit 1
fi

if [ -z "$OPENAI_BASE_URL" ]; then
    echo "❌ OPENAI_BASE_URL not set. Please configure your .env file."
    exit 1
fi

echo "✅ Configuration looks good!"
echo ""
echo "Testing with a simple prompt..."

# Build if needed
if [ ! -f "target/debug/claw" ]; then
    echo "Building Claw Code..."
    cargo build
fi

# Run a test prompt
echo "Running: cargo run -p rusty-claude-cli -- --model $MODEL prompt 'Say hello in 5 words'"
timeout 30 cargo run -p rusty-claude-cli -- --model "$MODEL" prompt "Say hello in 5 words" 2>/dev/null || echo "❌ Test failed - check your API key and network connection"

echo ""
echo "If the test worked, you can now run:"
echo "cargo run -p rusty-claude-cli -- --model $MODEL"