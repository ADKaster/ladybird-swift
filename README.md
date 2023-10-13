### Ladybird Swift

Experimental SwiftUI build of Ladybird

## Building

1. Install a static library build of Lagom into third_party/lagom

```console
cmake -GNinja -S ../serenity/Meta/Lagom -B Build/lagom-static -DCMAKE_INSTALL_PREFIX=$PWD/third_party/lagom -DBUILD_SHARED_LIBS=OFF
ninja -C Build/lagom-static install
```

2. Either use the swift package manager or cmake to build the project

a. `swift run`

b. `cmake -B Build/swift -GNinja -DCMAKE_PREFIX_PATH=$PWD/third_party/lagom; ninja -C Build/swift; ./Build/swift/bin/View`
