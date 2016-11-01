# FileSystem

![Language](https://img.shields.io/badge/language-Swift%203.0-orange.svg)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![Cocoapods Compatible](https://cocoapod-badges.herokuapp.com/v/FileSystem/badge.png)](https://cocoapods.org)
[![Platform](https://img.shields.io/cocoapods/p/FileSystem.svg?style=flat)](http://cocoadocs.org/docsets/FileSystem)

`FileSystem` is a simple and concise protocol orientated framework for dealing with the file system on iOS, tvOS, watchOS and macOS.

For safety and consistency all of the `Item` based APIs are implemented as functions that can throw an error. This is predominately driven by the fact the other processes outside of an app's control can modify the file system at any time, coupled with the fact that Swift 3 has no concept of properties that can throw an error.

## Types

The main Types in `FileSystem` are listed below with _protocols being emphasised_:

- Path
- _PathRepresentable_
- _Parent_
- _Subitem_
- _Copyable_
- _CopyableSubitem_
- _Moveable_
- _MoveableSubitem_
- _Renameable_
- _Removable_
- _Trashable_
- _Linkable_
- _SymbolicLinkable_
- _Item_
- _File_
- RegularFile
- SymbolicLink
- Alias
- Directory
- Volume

### Path

`Path` is used to represent a location on disk, meaning that you no longer have to keep switching between `String` and `URL`.

`Path` is `RawRepresentable` by a `String`, so can it be initialised using the default initialiser (which will return nil if the `rawValue` is invalid):

```swift
let path = Path(rawValue: "/")
```

As this is so common you can omit the `rawValue` parameter label:

```swift
let path = Path("/")
```

Path adopts `ExpressibleByStringLiteral`, meaning that when the type can be inferred by the compiler you can omit the initialiser altogether:

```swift
let path: Path = "/"
```

As mentioned before the current APIs use a mixture of `String` and `URL` representations, so to make things easier `Path` can also be initialised with a file URL:

```swift
let path = Path(url)
```

`Path` has various APIs for accessing its components:

```swift
public var components: [String]
public var lastComponent: String
public var componentsToDisplay: [String]
```

In addition to creating new paths based on its existing components:

```swift
public func appendingComponent(_ component: String) -> Path
public func deletingLastComponent() -> Path
public func replacingLastComponent(with component: String) -> Path
```

There is an API to access the path’s extension:

```swift
public var `extension`: String
```

There are APIs to resolve and standardise a `Path`:

```swift
 public var resolved: Path
 public var standardized: Path
```
 
 In addition to seeing if a `Path` already exists:
 
```swift
public var exists: Bool
```

To access the `Item` at a given path you can use the item property:

```swift
public var item: Item?
```

### PathRepresentable

`PathRepresentable` can be adopted by anything that can be represented by a `Path`.

```swift
var path: Path { get }

init?(path: Path)
```

The initializer *should* return nil if the `PathRepresentable` does not exist or if it is not of the correct type.

### Item

`Item` is the base `protocol` for all file system items that can be represented by `Path`. `Item` adopts `PathRepresentable`, `CustomStringConvertible` and ` CustomDebugStringConvertible`.

`Item` adds an additonal initailzer that doesn't the check to see if the `Item` exists at the given `Path`, which is used internally by the `FileSystem` framework for efficiency (e.g. when a valid path representation has been returned by a system API):

```swift
init(_ path: Path)
```

It also requires that the path property can be set:

```swift
var path: Path { get set }
``` 

`Item` has the following APIs:

```swift
public func exists() throws -> Bool
public func localizedName() throws -> String
public func isReadable() throws -> Bool
public func isWritable() throws -> Bool
public func isExecutable() throws -> Bool
public func isHidden() throws -> Bool
public func isPackage() throws -> Bool
public func isApplication() throws -> Bool
public func isAlias() throws -> Bool
public func isSymbolicLink() throws -> Bool
public func creationDate() throws -> Date
public func contentAccessDate() throws -> Date
public func contentModificationDate() throws -> Date
public func attributeModificationDate() throws -> Date
public func attributes() throws -> [FileAttributeKey: Any]
public func setAttributes(_ attributes: [FileAttributeKey: Any]) throws
```

 ### Parent

`Parent` `protocol` for an `Item` that can be a parent of another `Item`.

The `Parent` `protocol` provides APIs for accessing its subitems:

```swift
func subitems() throws -> [Subitem]
func isEmpty() throws -> Bool
func contains(_ subitem: Subitem) throws -> Bool
```

### Subitem

`Subitem` `protocol` for an `Item` that can be a subitem of another `Item`.

The `Subitem` `protocol` provides APIs to access its root volume and parent directory:

```swift
func rootVolume() throws -> Volume
func parentDirectory() throws -> Directory?
```


### Copyable

`Copyable` `protocol` for an `Item` that can be a copied.

```swift
func copy(to path: Path) throws -> Self
```

### CopyableSubitem

`CopyableSubitem` `protocol` for an `Item` that adopts `Copyable` and `Subitem`.

```swift
func copy(into parent: Parent) throws -> Self
```

### Moveable

`Moveable` `protocol` for an `Item` that can be moved to another `Path`.

```swift
mutating func move(to path: Path) throws
```

### MoveableSubitem

`MoveableSubitem` `protocol` for an `Item` that adopts `Moveable` and `Subitem`.

```swift
mutating func move(into parent: Parent) throws
```

### Renameable

`Renameable` `protocol` for an `Item` that can be renamed.

```swift 
mutating func rename(to name: String) throws
```
 
### Removeable
 
`Renameable` `protocol` for an `Item` that can be removed, *note that the item is removed instantly*.

```swift
 func remove() throws
```

### Trashable

`Trashable` `protocol` for an `Item` that can be trashed, on macOS the Item is moved to the Trash on iOS, tvOS and watchOS this is equivalent to the `Removeable` `protocol`.

```swift
mutating func trash() throws
```
 
### Linkable

`Linkable` `protocol` for an `Item` that can be hard linked to a `Path`.

```swift
func link(to path: Path) throws
```

### SymbolicLinkable

`SymbolicLinkable` `protocol` for an `Item` that can be symbolic linked to a `Path`.

```swift
func symbolicLink(to path: Path) throws -> SymbolicLink
```

### File

`File` is the base `protocol` for a single file and adopts `Item`, `Subitem`, `Copyable`, `CopyableSubitem`, `Moveable`, `MoveableSubitem`, `Renameable`, `Removeable`, `Trashable`, `Linkable` and `SymbolicLinkable`.

`File` has the following APIs:

```swift
public func contents() throws -> Data?
public func size() throws -> Int
public func isContentEqual(to file: Self) -> Bool
```

### RegularFile

`RegularFile` is a `struct` that adopts the `File` `protocol` and is used to represent a regular file i.e. not a symlink or alias.

`RegularFile` has an API to create a file at a `Path`:

```swift
static public func create(at path: Path) throws -> RegularFile
```

### SymbolicLink

`SymbolicLink` is a `struct` that adopts the `File` `protocol` and is used to represent a symbolic link.

`SymbolicLink` includes an API to retrieve its destination:

```swift
public func destination() throws -> SymbolicLinkable
```

### Alias

`Alias` is a `struct` that adopts the `File` `protocol` and is used to represent an alias.

`Alias` includes an API to retrieve its destination:

```swift
public func destination() throws -> Item
```

### Directory

`Directory` is a `struct` that adopts `Item`, `Parent`, `Subitem`, `Copyable`, `CopyableSubitem`, `Moveable`, `MoveableSubitem`, `Renameable`, `Removeable`, `Trashable`, `Linkable` and`SymbolicLinkable`

`Directory` has APIs to access system directories:

```swift
public static var temporary: Directory
public static var document: Directory    
public static var library: Directory
public static var caches: Directory
```

`Directory` has an API to access its relationship to another `Item`:

```swift
public func relationship(to item: Item) throws -> FileManager.URLRelationship
```

In addition to an API for creating a `Directory` at a `Path:

```swift
static public func create(at path: Path, withIntermediateDirectories: Bool = false) throws -> Directory
```

### Volume

`Volume` is a `struct` that adopts `Item`, `Parent`, `Renameable`, `Linkable` and `SymbolicLinkable`.

`Volume` provides an an API to access all of the mounted volumes:

```swift
public static var mounted: [Volume]
```

In addition to APIs to access information about the `Volume` itself:

```swift
public func totalCapacity() throws -> Int 
public func availableCapacity() throws -> Int 
public func usedCapacity() throws -> Int
public func isEjectable() throws -> Bool
public func isRemovable() throws -> Bool
public func isInternal() throws -> Bool
public func isLocal() throws -> Bool
public func isReadOnly() throws -> Bool
```

On macOS you can also unmount and eject the `Volume`:

```swift
public func unmountAndEject() throws
```
