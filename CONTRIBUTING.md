# Contributing to Selendra Icons

Thank you for contributing to the Selendra Icons repository! This document provides guidelines for adding and maintaining token icons.

## Quick Start

1. **Fork** this repository
2. **Create** the appropriate directory structure for your token
3. **Add** your icon files (PNG and/or SVG)
4. **Submit** a pull request

## Directory Structure

Icons must be placed in the correct directory based on token type:

- **`tokens/`** - For ERC-20/ERC-721 tokens on Selendra network
- **`native/`** - For native Selendra protocol tokens
- **`fallbacks/`** - For fallback icons by category

## File Requirements

### Icon Specifications
- **Formats**: PNG (256x256px) and/or SVG
- **Background**: Transparent
- **Quality**: High-resolution, crisp at small sizes (16x16px)
- **File naming**: Exactly `logo.png` or `logo.svg`

### Directory Naming
- **Token addresses**: Must be lowercase
- **Valid addresses only**: Ensure token is deployed on Selendra network
- **One directory per token**: `tokens/0xaddress/`

## Validation Checklist

Before submitting your PR:

- [ ] Token contract is deployed and verified on Selendra network
- [ ] Directory name matches token contract address (lowercase)
- [ ] Icon files are named `logo.png` and/or `logo.svg`
- [ ] PNG files are 256x256px with transparent background
- [ ] SVG files are optimized and scalable
- [ ] Icons are clearly visible at 16x16px size
- [ ] No copyrighted material without permission

## Submission Process

1. **Fork** this repository to your GitHub account
2. **Clone** your fork locally
3. **Create** a new branch: `git checkout -b add-token-YOUR_TOKEN_NAME`
4. **Add** your token directory and icon files
5. **Commit** your changes: `git commit -m "Add icons for YOUR_TOKEN_NAME"`
6. **Push** to your fork: `git push origin add-token-YOUR_TOKEN_NAME`
7. **Create** a pull request to the main repository

## Pull Request Template

When creating a PR, please include:

```
## Token Information
- **Token Name**: [Token Name]
- **Symbol**: [TOKEN_SYMBOL]
- **Contract Address**: [0x...]
- **Token Type**: [ERC-20/ERC-721/Native]
- **Network**: Selendra (Chain ID: 1961)

## Icon Details
- **Format(s)**: PNG/SVG
- **Source**: [Official website/brand kit/etc.]
- **License**: [If known]

## Verification
- [ ] Contract address verified on Selendra network
- [ ] Icon displays correctly at small sizes
- [ ] Transparent background
- [ ] Proper file naming convention
- [ ] No trademark violations
```

## Quality Standards

### Visual Requirements
- Icons should be the official logo of the token/project
- Clear visibility at minimum 16x16px display size
- Consistent style with existing icons when possible
- No low-quality or pixelated images

### Technical Requirements
- PNG files: Exactly 256x256px, 32-bit RGBA
- SVG files: Optimized, valid XML, scalable
- File sizes: Reasonable (PNG < 50KB, SVG < 20KB preferred)
- Transparent backgrounds required

## Common Issues

### ❌ Incorrect Structure
```
tokens/MyToken/icon.png          # Wrong filename
tokens/0xABC.../mylogo.svg       # Wrong filename
tokens/0xABC123.../logo.png      # Address not full length
```

### ✅ Correct Structure
```
tokens/0x1234567890abcdef1234567890abcdef12345678/logo.png
tokens/0x1234567890abcdef1234567890abcdef12345678/logo.svg
```

## Review Process

1. **Automated checks** validate file structure and naming
2. **Manual review** ensures quality and compliance
3. **Community feedback** period for popular tokens
4. **Merge** after approval from maintainers

## Support

- **Issues**: Report bugs or request features via GitHub Issues
- **Questions**: Use GitHub Discussions for general questions
- **Security**: Email security@selendra.org for sensitive issues

## License Compliance

- Ensure you have rights to use the icon
- Respect trademark and copyright laws
- When in doubt, contact the token project directly
- Include attribution if required by the original license