# storj.dart
Dart wrapper for the Uplink (Storj) GO library


This repository relies on you to compile a verision of [uplink-c](https://github.com/storj/uplink-c)

General steps:
1. install go
2. clone uplink-c to a directory of your choice
3. `run go build -o libuplinkc.so -buildmode=c-shared`
4. for building on windows, see https://github.com/storj-thirdparty/uplink-python#initial-set-up-important
5. Copy the resulting binaries to this directory (inside storj.dart repository)