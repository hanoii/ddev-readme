[![tests](https://github.com/hanoii/ddev-readme/actions/workflows/tests.yml/badge.svg)](https://github.com/hanoii/ddev-readme/actions/workflows/tests.yml)
![project is maintained](https://img.shields.io/maintenance/yes/2024.svg)

## What is ddev-readme?

This is an opinionated approach to keeping README.md a bit standarized
formatter.

It uses [prettier](https://prettier.io/) and
[markdown-toc](https://www.npmjs.com/package/markdown-toc?activeTab=readme).

Once installed and `ddev restart`, it will start up a process watching for
changes on your README.md. If you wish to disable this you can edit take charge
of `config.readme.yaml` or add `DDEV_README_WATCH_DISABLED=true` as en
environment variable for your project.

## TOC

For you toc generation to work automatically, you have to add the following
somewhere on your README.md:

```

<!-- toc -->



<!-- tocstop -->

```

**Contributed and maintained by [@hanoii](https://github.com/hanoii)**
