# 🔒 Private Dispenser

<p align="left">
  <a href="https://github.com/bass-dev-core/onchain-bridge-dispenser"><img src="https://img.shields.io/badge/Project%20Stage-Development-indigo?style=for-the-badge&logo=github&logoColor=white" alt="Project Stage" /></a>
  <a href="https://prettier.io/"><img src="https://img.shields.io/badge/Code_Style-Prettier-f7b93e?style=for-the-badge&logo=prettier&logoColor=white" alt="Code Style: Prettier" /></a>
  <a href="https://nextjs.org/"><img src="https://img.shields.io/badge/Next.js-000?style=for-the-badge&logo=nextdotjs&logoColor=white" alt="Next.js" /></a>
  <a href="https://www.typescriptlang.org/"><img src="https://img.shields.io/badge/TypeScript-3178c6?style=for-the-badge&logo=typescript&logoColor=white" alt="TypeScript" /></a>
  <a href="https://tailwindcss.com/"><img src="https://img.shields.io/badge/Tailwind_CSS-38bdf8?style=for-the-badge&logo=tailwind-css&logoColor=white" alt="Tailwind CSS" /></a>
  <a href="https://book.getfoundry.sh/"><img src="https://img.shields.io/badge/Foundry-e4b45a?style=for-the-badge&logo=foundry&logoColor=white" alt="Foundry" /></a>
  <a href="https://rainbowkit.com/"><img src="https://img.shields.io/badge/RainbowKit-7b3fe4?style=for-the-badge&logo=rainbow&logoColor=white" alt="RainbowKit" /></a>
  <a href="https://wagmi.sh/"><img src="https://img.shields.io/badge/Wagmi-1e202a?style=for-the-badge&logo=ethereum&logoColor=white" alt="Wagmi" /></a>
  <a href="https://viem.sh/"><img src="https://img.shields.io/badge/Viem-ffb300?style=for-the-badge&logo=viem&logoColor=white" alt="Viem" /></a>
  <a href="https://github.com/bass-dev-core/onchain-bridge-dispenser/actions/workflows/ci.yml"><img src="https://img.shields.io/github/actions/workflow/status/bass-dev-core/onchain-bridge-dispenser/ci.yml?style=for-the-badge&logo=github&label=CI" alt="CI Status" /></a>
  <a href="https://github.com/bass-dev-core/onchain-bridge-dispenser/actions/workflows/style-check.yml"><img src="https://img.shields.io/github/actions/workflow/status/bass-dev-core/onchain-bridge-dispenser/style-check.yml?style=for-the-badge&logo=github&label=Style%20Check" alt="Style Check Status" /></a>
  <a href="https://github.com/bass-dev-core/onchain-bridge-dispenser/actions/workflows/foundry.yml"><img src="https://img.shields.io/github/actions/workflow/status/bass-dev-core/onchain-bridge-dispenser/foundry.yml?style=for-the-badge&logo=github&label=Foundry" alt="Foundry Status" /></a>
</p>

## 📝 Abstract

Private Dispenser is a decentralized solution for cross-chain token distribution, enabling secure and efficient multi-recipient transfers across different blockchain networks. The project addresses critical challenges in the current DeFi landscape:

### Key Advantages

- **Non-Custodial Architecture**: Eliminates counterparty risk by removing centralized intermediaries
- **Atomic Multi-Transfer**: Enables single-transaction distribution to multiple addresses across chains
- **Gas Optimization**: Implements Multicall pattern for batch operations, reducing transaction costs
- **Bridge Aggregation**: Dynamically selects optimal bridge routes based on real-time conditions
- **On-Chain Governance**: Provides transparent and verifiable distribution records

### Technical Innovation

- **Zero-Knowledge Proof Integration**: Ensures privacy while maintaining auditability
- **Smart Contract Upgradability**: Implements UUPS proxy pattern for future-proof functionality
- **Cross-Chain State Management**: Maintains consistent state across multiple networks
- **Automated Fee Optimization**: Calculates optimal gas and bridge fees in real-time

This project represents a paradigm shift in cross-chain asset distribution, combining security, efficiency, and decentralization in a single solution.

## 🚀 Features

- Cross-chain token distribution
- Proxy contract for upgradeability
- Support for multiple bridges (LiFi, Bungee, Across)
- Modern Next.js frontend with TypeScript
- Tailwind CSS for styling
- Viem + Wagmi for Web3 integration

## 🛠️ Tech Stack

- **Smart Contracts**: Solidity + Foundry
- **Frontend**: Next.js + TypeScript
- **Web3**: Viem + Wagmi
- **Styling**: Tailwind CSS
- **Testing**: Foundry

## 📦 Installation

### 📋 Prerequisites

- Node.js (v18 or later)
- Foundry
- pnpm (recommended) or npm

### 🛠️ Foundry Installation

#### 🐧 Linux

1. Install Foundry:

```bash
curl -L https://foundry.paradigm.xyz | bash
source ~/.bashrc
foundryup
```

2. Initialize the project:

```bash
# Create lib directory
mkdir lib

# Initialize git repository
git init

# Install forge-std
forge install foundry-rs/forge-std --no-commit
```

#### 🪟 Windows (WSL)

1. Install WSL (Windows Subsystem for Linux):

```powershell
wsl --install
```

2. Open WSL terminal and install Foundry:

```bash
curl -L https://foundry.paradigm.xyz | bash
source ~/.bashrc
foundryup
```

3. Initialize the project:

```bash
# Create lib directory
mkdir lib

# Initialize git repository
git init

# Install forge-std
forge install foundry-rs/forge-std --no-commit
```

### 🚀 Project Setup

1. Clone the repository:

```bash
# Using HTTPS
git clone https://github.com/bass-dev-core/onchain-bridge-dispenser.git
cd onchain-bridge-dispenser

# Or using SSH
git clone git@github.com:bass-dev-core/onchain-bridge-dispenser.git
cd onchain-bridge-dispenser
```

2. Install dependencies:

```bash
# Install Foundry dependencies
forge install

# Install frontend dependencies
cd frontend
pnpm install
```

### 💻 Development

1. Start local blockchain:

```bash
anvil
```

2. Deploy contracts:

```bash
forge script script/Deploy.s.sol
```

3. Start frontend development server:

```bash
cd frontend
pnpm dev
```

### 🧪 Testing

Run Foundry tests:

```bash
forge test
```

## 📁 Project Structure

```
├── contracts/           # Smart contracts
│   ├── src/            # Source contracts
│   ├── test/           # Foundry tests
│   └── script/         # Deployment scripts
├── frontend/           # Next.js application
│   ├── components/     # React components
│   ├── pages/         # Next.js pages
│   ├── styles/        # CSS styles
│   └── utils/         # Utility functions
└── lib/               # Foundry dependencies
```

## 📜 Smart Contracts

### 🔄 Proxy Contract

The proxy contract enables upgradeability of the implementation contract while maintaining the same address and state.

### 💰 Dispenser Contract

The main contract that handles cross-chain token distribution through various bridges.

## 🖥️ Frontend

The frontend is built with Next.js and provides a user-friendly interface for:

- Connecting wallets
- Selecting target networks
- Inputting recipient addresses
- Choosing bridge providers
- Initiating token distribution

## 🔒 Security

[![FOSSA Status](https://app.fossa.com/api/projects/git%2Bgithub.com%2Fbass-dev-core%2Fonchain-bridge-dispenser.svg?type=shield&issueType=security)](https://app.fossa.com/projects/git%2Bgithub.com%2Fbass-dev-core%2Fonchain-bridge-dispenser?ref=badge_shield&issueType=security)

For detailed information about our security practices, vulnerability reporting, and security-related concerns, please refer to our [SECURITY.md](SECURITY.md).

### Smart Contract Security

- Access control for authorized users
- Reentrancy protection
- Input validation
- Safe math operations
- Bridge fee calculations
- Minimum amount checks

### Frontend Security

- Wallet connection validation
- Input sanitization
- Rate limiting
- Error handling
- Secure API calls

### Best Practices

- Regular security audits
- Test coverage
- Documentation
- Code reviews
- Dependency updates

## 📄 License

[![FOSSA Status](https://app.fossa.com/api/projects/git%2Bgithub.com%2Fbass-dev-core%2Fonchain-bridge-dispenser.svg?type=shield&issueType=license)](https://app.fossa.com/projects/git%2Bgithub.com%2Fbass-dev-core%2Fonchain-bridge-dispenser?ref=badge_shield&issueType=license)

This project is licensed under the [MIT License](LICENSE). Some components are licensed under the [Mozilla Public License 2.0](http://mozilla.org/MPL/2.0/). See [NOTICE.md](NOTICE.md) for details about third-party software notices and licenses.

<a href="https://app.fossa.com/projects/git%2Bgithub.com%2Fbass-dev-core%2Fonchain-bridge-dispenser?ref=badge_large&issueType=license">
  <img src="https://app.fossa.com/api/projects/git%2Bgithub.com%2Fbass-dev-core%2Fonchain-bridge-dispenser.svg?type=large&issueType=license" alt="FOSSA Status"/>
</a>

## 🤝 Contributing

We welcome contributions! Please see our [CONTRIBUTING.md](.github/CONTRIBUTING.md) for guidelines on how to contribute to this project.

## 📞 Support

For support, please open an [issue](https://github.com/bass-dev-core/onchain-bridge-dispenser/issues) or contact us at [support@bassbot.fun](mailto:support@bassbot.fun)
