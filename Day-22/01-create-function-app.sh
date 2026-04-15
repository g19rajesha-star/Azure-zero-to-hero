#!/usr/bin/env bash

set -euo pipefail

# =========================================================
# Azure Function App Deployment Script (Python - Linux Consumption Plan)
# =========================================================
# This script:
# 1. Creates a resource group
# 2. Creates a storage account
# 3. Creates a Python Azure Function App
#
# Prerequisites:
# - Azure CLI installed
# - Logged in via: az login
# - Subscription set if needed: az account set --subscription "<SUBSCRIPTION_ID>"
# =========================================================

# -----------------------------
# Configurable variables
# -----------------------------
LOCATION="${1:-eastus}"
PYTHON_VERSION="${2:-3.9}"   # Allowed: 3.7, 3.8, 3.9
SKU_STORAGE="Standard_LRS"
FUNCTIONS_VERSION="4"
TAG="create-function-app-consumption-python"

# -----------------------------
# Validation
# -----------------------------
if [[ ! "$PYTHON_VERSION" =~ ^3\.(7|8|9)$ ]]; then
  echo "Error: Invalid Python version '$PYTHON_VERSION'. Allowed values: 3.7, 3.8, 3.9"
  exit 1
fi

if ! command -v az >/dev/null 2>&1; then
  echo "Error: Azure CLI is not installed."
  exit 1
fi

if ! az account show >/dev/null 2>&1; then
  echo "Error: You are not logged in to Azure CLI. Run: az login"
  exit 1
fi

# -----------------------------
# Generate unique names
# -----------------------------
RANDOM_IDENTIFIER="$(date +%s)$RANDOM"

RESOURCE_GROUP="abhi-azure-functions-rg-$RANDOM_IDENTIFIER"
STORAGE_ACCOUNT="abhi${RANDOM_IDENTIFIER}"
FUNCTION_APP="abhi-serverless-python-function-$RANDOM_IDENTIFIER"

# Storage account name rules:
# - between 3 and 24 characters
# - lowercase letters and numbers only
STORAGE_ACCOUNT="$(echo "$STORAGE_ACCOUNT" | tr '[:upper:]' '[:lower:]' | cut -c1-24)"

echo "======================================"
echo "Azure Function App Deployment Started"
echo "======================================"
echo "Location           : $LOCATION"
echo "Python Version     : $PYTHON_VERSION"
echo "Resource Group     : $RESOURCE_GROUP"
echo "Storage Account    : $STORAGE_ACCOUNT"
echo "Function App       : $FUNCTION_APP"
echo "Tag                : $TAG"
echo "======================================"

# -----------------------------
# Create resource group
# -----------------------------
echo "Creating resource group..."
az group create \
  --name "$RESOURCE_GROUP" \
  --location "$LOCATION" \
  --tags "$TAG" \
  --output table

# -----------------------------
# Create storage account
# -----------------------------
echo "Creating storage account..."
az storage account create \
  --name "$STORAGE_ACCOUNT" \
  --location "$LOCATION" \
  --resource-group "$RESOURCE_GROUP" \
  --sku "$SKU_STORAGE" \
  --allow-blob-public-access false \
  --output table

# -----------------------------
# Create function app
# -----------------------------
echo "Creating Azure Function App..."
az functionapp create \
  --name "$FUNCTION_APP" \
  --storage-account "$STORAGE_ACCOUNT" \
  --consumption-plan-location "$LOCATION" \
  --resource-group "$RESOURCE_GROUP" \
  --os-type Linux \
  --runtime python \
  --runtime-version "$PYTHON_VERSION" \
  --functions-version "$FUNCTIONS_VERSION" \
  --output table

# -----------------------------
# Output summary
# -----------------------------
echo ""
echo "======================================"
echo "Deployment completed successfully"
echo "======================================"
echo "Resource Group : $RESOURCE_GROUP"
echo "Storage Account: $STORAGE_ACCOUNT"
echo "Function App   : $FUNCTION_APP"
echo ""
echo "Function App URL:"
echo "https://${FUNCTION_APP}.azurewebsites.net"
echo ""
echo "To clean up resources later, run:"
echo "az group delete --name \"$RESOURCE_GROUP\" --yes --no-wait"
echo "======================================"
