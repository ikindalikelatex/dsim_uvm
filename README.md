# UVM Simulation using DSim

## Requisites
- Oracle Linux >=8.4
  - Can use WSL + VSCode
- [DSim 2025.1](https://altairone.com/Marketplace?tab=Download&app=DSim)

### DSim Installation
- Update Oracle Linux for dependencies in case of a clean/fresh install
```bash
# Java and common devtools
sudo dnf install -y java-11-openjdk
sudo dnf groupinstall -y "Development Tools"

# Github-cli
sudo dnf config-manager --add-repo https://cli.github.com/packages/rpm/gh-cli.repo
sudo dnf install -y gh

# CMake
sudo dnf install -y cmake
```
- Use the DSim `.bin` installer
```bash
sudo ./AltairDSim2025.1_linux64.bin -i console
```
**Note:** Use `/home/user/AltairDSim/version` as the installation path instead of the default `/root/` one

### DSim licensing
License must be generated with a registered account. Free license only allows a single DSim instance on local hardware, but its better than nothing and seems to have full UVM support.
1. Login to [Altair DSim Cloud Licensing](https://app.metricsvcloud.com/security/licenses)
2. Generate DSim license
3. Install
  - Using installed VSCode `DSim Studio` extension: Click on the monitor button
    - Automatically saves license to `$HOME/metrics-ca/dsim-license.json`
  - Manually download `dsim-license.json` and store on a path that is visible
4. Configure environment to use license, can be added to `~/.bashrc`
```bash
export DSIM_LICENSE=$HOME/metrics-ca/dsim-license.json
```

## Running DSim
Assuming DSim installation path is `$DSIM_HOME`, for example `$DSIM_HOME=/home/isaac/AltairDSim/2025.1`
### Shell Environment
DSim provides a bash script to set up the terminal. License must be installed and set up before calling environment setup. You can include the License `export` + the setup source on your `~/.bashrc` for ease of use.
```bash
source $DSIM_HOME/shell_activate.bash
```

## CMake flow
Refer to top [`CMakeLists.txt`](CMakeLists.txt). Compilation relies on chained `filelist.f` files that ensure correct compilation order.
- Top `.f` file [`src/filelist.f`](src/filelist.f)
- `C++` code has its own [`src/cpp/CMakeLists.txt`](src/cpp/CMakeLists.txt)
  - Configures sources, linking options and shared library for usage with DSim
### CMake config
```bash
cmake -S . -B build
```

### CMake build
```bash
cmake --build build --target dsim_[build/run]
```
- `dsim_build`
  - Builds `C++` code and creates a shared lib `cpp_lib`
  - Compiles and elaborates any SystemVerilog code
  - Creates an `image` for later simulation
- `dsim_run`
  - Runs simulation on a previously elaborated `image`
  - Collects coverage and creates database with 