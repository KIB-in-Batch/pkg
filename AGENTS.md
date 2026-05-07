# AGENTS.md

Guidance for AI coding agents working in this repository.

## Repository Purpose

This repository is the package repository for KIB in Batch. It stores package definitions, package metadata, installer scripts, uninstaller scripts, and bundled package files.

The default development branch for this repository is `devel`. Do not make direct changes on `main`. Changes intended for `main` must go through a pull request.

## Workflow Rules

- Base all work on `devel`, not `main`.
- Use pull requests for changes that should reach `main`.
- Keep changes focused on the requested package or repository metadata.
- Do not rewrite history, reset branches, or discard existing user changes unless explicitly asked.
- Review `git status` before and after edits so unrelated local changes are not accidentally included.

## Repository Layout

- `packages.list` lists package names available under `packages/`.
- `packages-kib11.list` lists package names available under `packages-kib11/`.
- `packages/` contains the main package set.
- `packages-kib11/` contains KIB 11 package definitions.
- Each package directory should follow the format documented in `README.md`.

Expected package structure:

```text
package-name/
    INSTALL.sh
    UNINSTALL.sh
    README.md
    LICENSE.txt
    DEPENDENCIES.txt
    VERSION.txt
    DESCRIPTION.txt
    MAXVER.txt
    files/
```

`DESCRIPTION.txt` and `files/` may be optional for some packages, but prefer following the complete structure used by existing packages.

## Package Maintenance

- When adding a package under `packages/`, add the package name to `packages.list`.
- When adding a package under `packages-kib11/`, add the package name to `packages-kib11.list`.
- Keep package names consistent between the directory name and the relevant list file.
- Use semantic versions in `VERSION.txt`, for example `2.5.8`.
- Use `DEPENDENCIES.txt` for dependency names, one dependency per line.
- Use `MAXVER.txt` for the maximum supported major version of KIB in Batch.
- Prefer copying `hello-world` as a starting point for new packages, then update every metadata file and script.

## Script Guidance

- `INSTALL.sh` and `UNINSTALL.sh` are POSIX shell scripts. Keep them simple and portable.
- Be careful with destructive commands in uninstall scripts. Only remove files that the package installed.
- Package payload files that should be available without remote downloads belong in the package `files/` directory.
- Batch files in package payloads should follow the style of nearby `.bat` files.

## Validation

There is no central build system in this repository. Before finishing, check the relevant files manually:

- Confirm the package appears in the correct package list.
- Confirm all expected metadata files exist.
- Confirm install and uninstall paths match.
- Confirm scripts reference files that actually exist under `files/`.
- Run `git diff` to verify only intended changes are included.

## Documentation

- Update the package `README.md` when behavior, commands, bundled files, or usage changes.
- Keep top-level documentation changes concise and consistent with the existing README style.
- Preserve existing licenses and notices for bundled third-party files.

## Testing locally

You need an [installation of KIB in Batch](https://kib-in-batch.github.io). For `packages-kib11`, use version 11 and for `packages` use the stable version.

Once you have copied or symlinked the package files (`packages[-kib11]/<package>`) to a directory in the KIB in Batch root, go to the package direcory and run `install.sh`.