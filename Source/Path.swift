//
//  Path.swift
//  FileSystem
//
//  Created by Spencer MacDonald on 21/09/2016.
//  Copyright © 2016 Square Bracket Software. All rights reserved.
//

import Foundation

/// Path represents a file system location on disk.
public struct Path: Equatable, RawRepresentable {
    /// Alias for the underlying raw value of a path.
    public typealias RawValue = String
    
    /// String representation of the path
    public let rawValue: RawValue
    /// URL representation of the path
    public let url: URL

    /// Creates a `Path` instance with the specified raw value.
    ///
    /// - parameter rawValue: The raw string value for the path.
    ///
    /// - returns: A new path instance.
    public init?(rawValue: RawValue) {
        self.rawValue = rawValue
        self.url = URL(fileURLWithPath: rawValue)
    }
    
    /// Creates a `Path` instance with the specified raw value.
    ///
    /// - parameter rawValue: The raw string value for the path.
    ///
    /// - returns: A new path instance.
    public init(_ rawValue: String) {
        self.rawValue = rawValue
        self.url = URL(fileURLWithPath: rawValue)
    }
    
    /// Creates a `Path` instance with the specified components.
    ///
    /// - parameter components: The components for the path.
    ///
    /// - returns: A new path instance.
    public init(components: [String]) {
        let fileURL = NSURL.fileURL(withPathComponents: components)! as URL
        self.init(fileURL)
    }
    
    /// Creates a `Path` instance with the specified components.
    ///
    /// - parameter url: The url for the path.
    ///
    /// - returns: A new path instance.
    public init(_ url: URL) {
        self.rawValue = url.path
        self.url = url
    }
    
    /// Returns the path extension.
    public var `extension`: String {
        return url.pathExtension
    }
    
    /// Returns the path components.
    public var components: [String] {
        return url.pathComponents
    }
    
    /// Returns the last path component.
    public var lastComponent: String {
        return url.lastPathComponent
    }
    
    /// Returns an array of localized path components or nil if the path does not exist.
    public var componentsToDisplay: [String]? {
        return FileManager.default.componentsToDisplay(forPath: rawValue)
    }
    
    /// Returns wether the path exists.
    public var exists: Bool {
        return FileManager.default.fileExists(atPath: rawValue)
    }
    
    /// Returns Path with any symlinks resolved.
    public var resolved: Path {
        return Path(url.resolvingSymlinksInPath())
    }
    
    /// Return a standardized Path
    public var standardized: Path {
        return Path(url.standardizedFileURL)
    }
    
    /// Returns a Path constructed by appending the given path component to self.
    ///
    /// - note: This function performs a file system operation to determine if the path component is a directory. If so, it will append a trailing `/`.
    /// - parameter component: The path component to add.
    public func appendingComponent(_ component: String) -> Path {
        let url = self.url.appendingPathComponent(component)
        return Path(url)
    }
    
    /// Returns a Path constructed by removing the last path component of self.
    public func deletingLastComponent() -> Path {
        let url = self.url.deletingLastPathComponent()
        return Path(url)
    }
    
    /// Returns a Path constructed by replacing the last path component of self.
    ///
    /// - parameter component: The path component to used to replace the current last path component.
    public func replacingLastComponent(with component: String) -> Path {
        var pathComponents = components
        pathComponents.removeLast()
        pathComponents.append(component)
        let fileURL = NSURL.fileURL(withPathComponents: pathComponents)! as URL
        return Path(fileURL)
    }
}

extension Path: CustomStringConvertible {
    /// A textual representation of this instance, returning the `rawValue`.
    public var description: String {
        return rawValue
    }
}

extension Path: CustomDebugStringConvertible {
    /// A textual representation of this instance, returning the `rawValue`.
    public var debugDescription: String {
        return rawValue
    }
}

extension Path: ExpressibleByStringLiteral {
    /// Creates an instance initialized to the given string value.
    public init(stringLiteral value: StringLiteralType) {
        self.rawValue = value
        self.url = URL(fileURLWithPath: value)
    }
    
    /// Creates an instance initialized to the given value.
    public init(extendedGraphemeClusterLiteral value: StringLiteralType) {
        self.rawValue = value
        self.url = URL(fileURLWithPath: value)
    }
    
    /// Creates an instance initialized to the given value.
    public init(unicodeScalarLiteral value: StringLiteralType) {
        self.rawValue = value
        self.url = URL(fileURLWithPath: value)
    }
}

extension Path {
    /// Returns the item located at self or nil if one does not exist.
    public var item: Item? {
        do {
            let resourceValues = try url.resourceValues(forKeys: [.isDirectoryKey, .isVolumeKey, .isSymbolicLinkKey, .isAliasFileKey, .isRegularFileKey])
            
            if let isVolume = resourceValues.isVolume, isVolume {
                return Volume(self)
            } else if let isDirectory = resourceValues.isDirectory, isDirectory {
                return Directory(self)
            } else if let isSymbolicLink = resourceValues.isSymbolicLink, isSymbolicLink {
                return SymbolicLink(self)
            } else if let isAliasFile = resourceValues.isAliasFile, isAliasFile {
                return AliasFile(self)
            } else if let isRegularFile = resourceValues.isRegularFile, isRegularFile {
                return RegularFile(self)
            } else {
                return nil
            }
        } catch _ {
            return nil
        }
    }
}

extension Path: Hashable {
    /// Return the hash value of the raw value.
    public var hashValue: Int {
        return rawValue.hashValue
    }
}

/// Returns if the specified paths are equal according to there standardized paths.
public func ==(lhs: Path, rhs: Path) -> Bool {
    return lhs.url.standardizedFileURL == rhs.url.standardizedFileURL
}
