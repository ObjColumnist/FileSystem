# Changelog

## 0.2.1

This version of `FileSystem` was focused on increasing the documentation of protocols.

## 0.2

This version of `FileSystem` predominately focused on improving the documentation of the code base, in addition to the following changes:

- Created `FileHandleConvertible` `protocol` for an `Item` that can be converted into a `FileHandle` for either reading, writing or updating (both reading and writing).
- Created `FileWrapperConvertible` `protocol` for an `Item` that can be converted into a `FileWrapper`.
- Created `Aliasable` `protocol` for an `Item` that can be aliased, making it consistent with `SymbolicLinkable`.
- When linking an `Item` using the `Linkable` `protocol`, the created `Linkable` is now returned, making it consistent with the `SymbolicLinkable` `protocol`.
- `FileSystem` no longer uses `NSWorkspace` on macOS and therefore no longer links against `Cocoa.framework`. This only effected the `Volume` unmounting APIs.
- Added additional APIs to access system directories.
- `RegularFile` creation APIs have been removed due to them making too many assumptions.

## 0.1

Initial release of `FileSystem`.

`FileSystem` 0.1 is written using Swift 3.0.

`FileSystem` 0.1 has the following minimum deployment targets:

- iOS 8.0
- watchOS 2.0
- tvOS 9.0
- macOS 10.10

`FileSystem` 0.1 can be intergrated with following dependancy managers:

- CocoaPods
- Carthage
- Swift Package Manager
