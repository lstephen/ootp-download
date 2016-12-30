# ootp-download

This script is designed to download an OOTP league file and extract it into the Wineskin app package.

## Disclaimer

This has not been tested outside my own use. I make no claims or take any responsibility for what it does/does not do.

## Assumptions

  * `curl` is installed and present on the path
  * `unzip` is installed and present on the path
  * The OOTP wineskin packages are installed under `/Applications`. (TODO: Make this directory configurable)
  
## Usage

  1. Download and extract (or clone) the contents of this repository
  1. In that directory run `ruby download.rb HFTC` (replace `HFTC` with other leagues if necessary)
  
## Configuration

TODO

