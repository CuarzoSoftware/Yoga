
<h1 style="margin-top:0px;padding-top:0px">Yoga</h1>

<p align="left">
  <a href="https://github.com/CuarzoSoftware/Skia/blob/main/LICENSE">
    <img src="https://img.shields.io/badge/license-MIT-blue.svg" alt="Yoga is released under the MIT license." />
  </a>
  <a href="https://github.com/CuarzoSoftware/yoga">
    <img src="https://img.shields.io/badge/version-3.2.0-brightgreen" alt="Current Yoga version." />
  </a>
</p>

## Fedora

Install from [cuarzo/software](https://copr.fedorainfracloud.org/coprs/cuarzo/software/) COPR:

```bash
$ sudo dnf copr enable cuarzo/software
$ sudo dnf install cuarzo-yoga-devel
```

## Manual installation

It is also possible to manually build yoga. We use a simple `cmake` wrapper
that will fetch the correct branch from the office `yoga` repository, build and
install the target.

It is enough to run:

```
$ make
```

You can check if yoga is correctly installed by running:

```
$ cmake --find-package -DNAME=yoga -DCOMPILER_ID=GNU -DLANGUAGE=CXX -DMODE=EXIST
```
