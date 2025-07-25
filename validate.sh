#!/bin/bash

# Selendra Icons Validation Script
# This script validates the structure and content of the selendra-icons repository

set -e

echo "🔍 Validating Selendra Icons Repository Structure..."

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Counters
ERRORS=0
WARNINGS=0
VALIDATED=0

# Function to print colored output
print_error() {
    echo -e "${RED}❌ ERROR: $1${NC}"
    ((ERRORS++))
}

print_warning() {
    echo -e "${YELLOW}⚠️  WARNING: $1${NC}"
    ((WARNINGS++))
}

print_success() {
    echo -e "${GREEN}✅ $1${NC}"
    ((VALIDATED++))
}

# Set working directory
REPO_DIR="${1:-$(pwd)}"
cd "$REPO_DIR" || {
    print_error "Cannot access directory: $REPO_DIR"
    exit 1
}

# Check if we're in the right directory
if [ ! -f "README.md" ] || [ ! -d "tokens" ] || [ ! -d "native" ] || [ ! -d "fallbacks" ]; then
    print_error "Not in selendra-icons repository root directory: $REPO_DIR"
    exit 1
fi

echo "📁 Validating directory structure..."

# Check main directories exist
for dir in "tokens" "native" "fallbacks"; do
    if [ -d "$dir" ]; then
        print_success "Directory '$dir' exists"
    else
        print_error "Missing required directory: $dir"
    fi
done

# Function to validate token directory
validate_token_dir() {
    local base_dir="$1"
    local token_dir="$2"
    local full_path="$base_dir/$token_dir"
    
    echo "  🔍 Validating $full_path..."
    
    # Check if it's a valid Ethereum address (40 hex chars after 0x)
    if [[ ! "$token_dir" =~ ^0x[a-fA-F0-9]{40}$ ]] && [[ "$token_dir" != "default" ]] && [[ "$token_dir" != "erc20" ]] && [[ "$token_dir" != "erc721" ]]; then
        print_error "$full_path: Invalid address format (must be 0x followed by 40 hex characters)"
        return
    fi
    
    # Check if address is lowercase (except for fallbacks)
    if [[ "$base_dir" != "fallbacks" ]] && [[ "$token_dir" =~ [A-F] ]]; then
        print_warning "$full_path: Address should be lowercase for consistency"
    fi
    
    # Check for logo files
    local has_png=false
    local has_svg=false
    
    if [ -f "$full_path/logo.png" ]; then
        has_png=true
        
        # Check PNG dimensions if imagemagick is available
        if command -v identify >/dev/null 2>&1; then
            local dimensions=$(identify -format "%wx%h" "$full_path/logo.png" 2>/dev/null || echo "unknown")
            if [ "$dimensions" != "256x256" ] && [ "$dimensions" != "unknown" ]; then
                print_warning "$full_path/logo.png: Recommended size is 256x256px (current: $dimensions)"
            fi
        fi
        
        print_success "$full_path/logo.png found"
    fi
    
    if [ -f "$full_path/logo.svg" ]; then
        has_svg=true
        
        # Basic SVG validation
        if ! head -n 1 "$full_path/logo.svg" | grep -q "<?xml\|<svg"; then
            print_error "$full_path/logo.svg: Not a valid SVG file"
        else
            print_success "$full_path/logo.svg found"
        fi
    fi
    
    # At least one logo file should exist
    if [ "$has_png" = false ] && [ "$has_svg" = false ]; then
        print_error "$full_path: No logo files found (logo.png or logo.svg required)"
    fi
    
    # Check for extra files
    local file_count=$(find "$full_path" -type f | wc -l)
    local logo_count=0
    [ "$has_png" = true ] && ((logo_count++))
    [ "$has_svg" = true ] && ((logo_count++))
    
    if [ "$file_count" -gt "$logo_count" ]; then
        print_warning "$full_path: Contains extra files (only logo.png and logo.svg should be present)"
    fi
}

# Validate tokens directory
echo "🪙 Validating tokens directory..."
if [ -d "tokens" ]; then
    token_count=0
    for token_dir in tokens/*/; do
        if [ -d "$token_dir" ]; then
            token_name=$(basename "$token_dir")
            validate_token_dir "tokens" "$token_name"
            ((token_count++))
        fi
    done
    
    if [ "$token_count" -eq 0 ]; then
        print_warning "No tokens found in tokens/ directory"
    else
        print_success "Validated $token_count token(s)"
    fi
fi

# Validate native directory
echo "🏠 Validating native directory..."
if [ -d "native" ]; then
    native_count=0
    for native_dir in native/*/; do
        if [ -d "$native_dir" ]; then
            native_name=$(basename "$native_dir")
            validate_token_dir "native" "$native_name"
            ((native_count++))
        fi
    done
    
    if [ "$native_count" -eq 0 ]; then
        print_warning "No native tokens found in native/ directory"
    else
        print_success "Validated $native_count native token(s)"
    fi
fi

# Validate fallbacks directory
echo "🔄 Validating fallbacks directory..."
if [ -d "fallbacks" ]; then
    fallback_count=0
    for fallback_dir in fallbacks/*/; do
        if [ -d "$fallback_dir" ]; then
            fallback_name=$(basename "$fallback_dir")
            validate_token_dir "fallbacks" "$fallback_name"
            ((fallback_count++))
        fi
    done
    
    if [ "$fallback_count" -eq 0 ]; then
        print_warning "No fallbacks found in fallbacks/ directory"
    else
        print_success "Validated $fallback_count fallback(s)"
    fi
fi

# Check for required files
echo "📄 Validating documentation..."
for file in "README.md" "CONTRIBUTING.md"; do
    if [ -f "$file" ]; then
        print_success "$file exists"
    else
        print_error "Missing required file: $file"
    fi
done

# Summary
echo ""
echo "📊 Validation Summary:"
echo "  ✅ Validated: $VALIDATED"
echo "  ⚠️  Warnings: $WARNINGS"
echo "  ❌ Errors: $ERRORS"

if [ "$ERRORS" -eq 0 ]; then
    echo ""
    print_success "Repository validation completed successfully! 🎉"
    exit 0
else
    echo ""
    print_error "Repository validation failed with $ERRORS error(s)"
    exit 1
fi