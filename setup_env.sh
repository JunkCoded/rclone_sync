#!/usr/bin/env bash
set -euo pipefail

ENV_FILE=".env"
EXAMPLE_FILE="example.env"

if [[ ! -f "$EXAMPLE_FILE" ]]; then
  echo "Error: $EXAMPLE_FILE not found!"
  exit 1
fi

declare -A env_values

echo "=== Environment variables setup ==="

# Read example.env line by line
while IFS='=' read -r key value; do
  # Skip comments and empty lines
  [[ "$key" =~ ^#.*$ || -z "$key" ]] && continue
  env_values["$key"]="$value"
done < "$EXAMPLE_FILE"

# Ask user for each variable
for key in "${!env_values[@]}"; do
  current="${env_values[$key]}"
  read -rp "Enter value for $key (${current}): " input
  if [[ -n "$input" ]]; then
    env_values[$key]="$input"
  fi
done

# Write new .env file
echo "Saving configuration to $ENV_FILE"
{
  for key in "${!env_values[@]}"; do
    echo "$key=${env_values[$key]}"
  done
} > "$

