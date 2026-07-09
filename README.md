# homebrew-rama

Homebrew tap for [Rama](https://github.com/plabayo/rama), a tool to move and
transform network packets.

## Install

Install the latest stable Rama release:

```sh
brew install plabayo/rama/rama
```

Install a maintained older stable line:

```sh
brew install plabayo/rama/rama@0.2
```

Versioned formulae are keg-only so they can coexist with the latest `rama`
formula. To run one directly:

```sh
$(brew --prefix plabayo/rama/rama@0.2)/bin/rama --version
```

## Maintainer Workflow

This tap is maintained from the upstream Rama GitHub releases.

- `Formula/rama.rb` tracks the latest stable release.
- `Formula/rama@<major>.<minor>.rb` tracks previous stable minor lines.
- Pre-releases such as alpha, beta, and release-candidate builds are skipped.
- macOS Apple Silicon uses the `aarch64-apple-darwin` upstream archive.
- macOS Intel uses the `x86_64-apple-darwin` upstream archive.

To update locally:

```sh
ruby scripts/update-formula.rb
brew tap --custom-remote plabayo/rama "$PWD"
brew style plabayo/rama/rama plabayo/rama/rama@0.2
brew audit --strict --online --formula plabayo/rama/rama plabayo/rama/rama@0.2
```

To update a specific stable release:

```sh
ruby scripts/update-formula.rb --version 0.3.0
```

## Automation

The `Update Rama Formulae` workflow can be run manually from this tap. The same
workflow also accepts a `repository_dispatch` event named `rama-release`, which
lets the main Rama release flow open a Homebrew update pull request after a
release is published.

Example dispatch from `plabayo/rama`:

```sh
gh api repos/plabayo/homebrew-rama/dispatches \
  --method POST \
  --field event_type=rama-release \
  --raw-field client_payload='{"version":"0.3.0","versioned":true}'
```

When dispatching from the main Rama repository, use a token that is allowed to
write repository dispatch events to `plabayo/homebrew-rama`; the source
repository's default `GITHUB_TOKEN` usually cannot operate on a different
repository.

If no version is supplied, the updater picks the newest non-draft,
non-prerelease Rama release.

Please file tap issues in the
[main Rama repository](https://github.com/plabayo/rama/issues).
