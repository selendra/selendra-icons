# Selendra Icons

This repository provides token icons for the Selendra blockchain explorer and ecosystem. Icons are automatically fetched and displayed by Blockscout explorer instances running on Selendra network (Chain ID: 1961).

## Repository Structure

This repository is organized into three main directories, each serving a specific purpose:

### 📁 `tokens/`
Contains icons for specific ERC-20/ERC-721 tokens deployed on the Selendra network.

**Structure**: `tokens/<token_contract_address>/logo.[png|svg]`

**Example**:
```
tokens/
├── 0x1234567890abcdef1234567890abcdef12345678/
│   ├── logo.png
│   └── logo.svg
└── 0xabcdef1234567890abcdef1234567890abcdef12/
    ├── logo.png
    └── logo.svg
```

### 📁 `native/`
Contains icons for native Selendra network tokens and core protocol tokens.

**Structure**: `native/<token_address>/logo.[png|svg]`

**Example**:
```
native/
├── 0x0000000000000000000000000000000000000000/  # SEL (native token)
│   ├── logo.png
│   └── logo.svg
└── 0x1111111111111111111111111111111111111111/  # Other native token
    └── logo.svg
```

### 📁 `fallbacks/`
Contains fallback icons used when specific token icons are not available.

**Structure**: `fallbacks/<category>/logo.[png|svg]`

**Example**:
```
fallbacks/
├── default/
│   ├── logo.png
│   └── logo.svg
├── erc20/
│   └── logo.svg
└── erc721/
    └── logo.svg
```

## Usage

### Automatic Integration
When running Blockscout on Selendra network (Chain ID 1961), token icons are automatically fetched in the following priority order:

1. **tokens/** directory (specific token icons)
2. **native/** directory (native protocol tokens)  
3. **fallbacks/** directory (general fallbacks)
4. Default Blockscout icon (if none found)

### Manual Integration
Icons can be manually accessed via GitHub's raw content URLs:

```
https://raw.githubusercontent.com/selendra/selendra-icons/main/tokens/<address>/logo.png
https://raw.githubusercontent.com/selendra/selendra-icons/main/native/<address>/logo.svg
https://raw.githubusercontent.com/selendra/selendra-icons/main/fallbacks/default/logo.png
```

## Contributing

### Adding New Token Icons

1. **Get the token contract address** (ensure it's checksummed)
2. **Create the directory structure**:
   ```bash
   mkdir -p tokens/0xYourTokenAddress
   ```
3. **Add icon files** (preferably both PNG and SVG):
   ```bash
   # Add your logo files
   tokens/0xYourTokenAddress/logo.png  # Recommended: 256x256px
   tokens/0xYourTokenAddress/logo.svg  # Vector format preferred
   ```

### Icon Requirements

- **Format**: PNG or SVG (SVG preferred for scalability)
- **Size**: 256x256px for PNG files
- **Quality**: High-resolution, clear visibility at small sizes
- **Background**: Transparent background preferred
- **File naming**: Must be exactly `logo.png` or `logo.svg`
- **Address format**: Contract addresses must be lowercase

### Validation

Before submitting, ensure:
- [ ] Contract address is valid and deployed on Selendra network
- [ ] Icon displays clearly at 16x16px (minimum size in explorer)
- [ ] File follows naming convention (`logo.png` or `logo.svg`)
- [ ] Directory structure matches specification
- [ ] PNG files are optimized for web delivery

## Network Compatibility

This repository is specifically designed for:
- **Selendra Network** (Chain ID: 1961)
- **Blockscout Explorer** integration
- Compatible with any application following the same directory structure

## API Endpoints

Icons are available via GitHub's raw content API:

**Base URL**: `https://raw.githubusercontent.com/selendra/selendra-icons/main`

**Endpoints**:
- `GET /{directory}/{address}/logo.png`
- `GET /{directory}/{address}/logo.svg`

**Examples**:
- `GET /tokens/0x1234.../logo.png`
- `GET /native/0x0000.../logo.svg`
- `GET /fallbacks/default/logo.png`

## License

This repository contains third-party logos and trademarks. Each icon remains the intellectual property of its respective owner. Usage should comply with individual project licenses and trademark policies.