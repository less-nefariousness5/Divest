# Project Sylvanas SimC Parser

A tool to convert SimulationCraft APL (Action Priority Lists) into Project Sylvanas Lua rotations.

## Overview

This tool parses SimulationCraft APL files and generates optimized Lua rotation code compatible with the Project Sylvanas API.

## Features

- Parse SimC APL files
- Generate PS-compatible Lua rotations
- Support for complex conditions and variable handling
- Built-in optimization and validation

## Installation

```bash
git clone https://github.com/less-nefariousness5/ps-simc-parser.git
cd ps-simc-parser
pip install -e .
```

## Usage

```bash
python -m ps_simc_parser input.simc output.lua
```

## Documentation

See the [docs](./docs) directory for detailed documentation.

## Contributing

Contributions are welcome! Please read our [Contributing Guidelines](./CONTRIBUTING.md) first.

## License

This project is licensed under the MIT License - see the [LICENSE](./LICENSE) file for details. 