# homebrew-tap

Homebrew tap for [Flash](https://github.com/aymericbeaumet/flash), a macOS app,
and [squeeze](https://github.com/aymericbeaumet/squeeze), a text extraction CLI.

Install the stable squeeze formula:

```sh
brew install aymericbeaumet/tap/squeeze
```

For the latest squeeze changes, install `aymericbeaumet/tap/squeeze-nightly`
instead. The squeeze release workflow updates the stable formula's version,
source URL, and checksum; pushes to squeeze's main branch update the nightly formula.

Install the nightly cask:

```sh
brew install --cask aymericbeaumet/tap/flash@nightly
```
