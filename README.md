# Vault-debianzier

A project to easily grab released binaries from Hashicorp's vault releases and bundle them up into a deb package.

It works by
1. Grabbing the list of tags from HashiCorp Vault's github repo (https://github.com/hashicorp/vault)
1. Filterout any `beta` releases
1. Download the corresponding `linux_amd64` zip file from https://releases.hashicorp.com/vault/
1. Build a debian changelog formatted file from the contents of CHANGELOG.md
1. Execute the `dpkg-buildpakcage` command

# How to use:
## TL;DR
A shortcut script can be found at `cicd/build.sh`, which you can use to just build with:
1. `cicd/build.sh <optional version>`

## Manual
General process is to do the following:
1. Run the `./get_release <Optional version>` script, redirecting it's stdout to debian/changelog, If no version is specific then the latest version is auto-discovered from HashiCorp's github project
1. Copy the copyright doc into place: `cp docs/LICENSE debian/copyright`
1. Run `dpkg-buildpackage -us -uc`
