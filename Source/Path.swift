//
//  Path.swift
//  FileSystem
//
//  Created by Spencer MacDonald on 21/09/2016.
//  Copyright © 2016 Square Bracket Software. All rights reserved.
//

import Foundation

public struct Path: Equatable, RawRepresentable {
    public typealias RawValue = String
    
    public let rawValue: RawValue
    public let url: URL

    public init?(rawValue: RawValue) {
        self.rawValue = rawValue
        self.url = URL(fileURLWithPath: rawValue)
    }
    
    public init(_ rawValue: String) {
        self.rawValue = rawValue
        self.url = URL(fileURLWithPath: rawValue)
    }
    
    public init(components: [String]) {
        let fileURL = NSURL.fileURL(withPathComponents: components)! as URL
        self.init(fileURL)
    }
    
    public init(_ url: URL) {
        self.rawValue = url.path
        self.url = url
    }
    
    public var `extension`: String {
        return url.pathExtension
    }
    
    public var components: [String] {
        return url.pathComponents
    }
    
    public var lastComponent: String {
        return url.lastPathComponent
    }
    
    public var componentsToDisplay: [String] {
        return FileManager.default.componentsToDisplay(forPath: rawValue) ?? []
    }
    
    public var exists: Bool {
        return FileManager.default.fileExists(atPath: rawValue)
    }
    
    public var resolved: Path {
        return Path(url.resolvingSymlinksInPath())
    }
    
    public var standardized: Path {
        return Path(url.standardizedFileURL)
    }
    
    public func appendingComponent(_ component: String) -> Path {
        let url = self.url.appendingPathComponent(component)
        return Path(url)
    }
    
    public func deletingLastComponent() -> Path {
        let url = self.url.deletingLastPathComponent()
        return Path(url)
    }
    
    public func replacingLastComponent(with component: String) -> Path {
        var pathComponents = components
        pathComponents.removeLast()
        pathComponents.append(component)
        let fileURL = NSURL.fileURL(withPathComponents: pathComponents)! as URL
        return Path(fileURL)
    }
}

extension Path: CustomStringConvertible {
    public var description: String {
        return rawValue
    }
}

extension Path: CustomDebugStringConvertible {
    public var debugDescription: String {
        return rawValue
    }
}

extension Path: ExpressibleByStringLiteral {
    public init(extendedGraphemeClusterLiteral value: StringLiteralType) {
        self.rawValue = value
        self.url = URL(fileURLWithPath: value)
    }
    
    public init(stringLiteral value: StringLiteralType) {
        self.rawValue = value
        self.url = URL(fileURLWithPath: value)
    }
    
    public init(unicodeScalarLiteral value: StringLiteralType) {
        self.rawValue = value
        self.url = URL(fileURLWithPath: value)
    }
}

extension Path {
    public var item: Item? {
        do {
            let resourceValues = try url.resourceValues(forKeys: [.isDirectoryKey, .isVolumeKey, .isSymbolicLinkKey, .isAliasFileKey, .isRegularFileKey])
            
            if let isVolume = resourceValues.isVolume, isVolume {
                return Volume(path: self)
            } else if let isDirectory = resourceValues.isDirectory, isDirectory {
                return Directory(path: self)
            } else if let isSymbolicLink = resourceValues.isSymbolicLink, isSymbolicLink {
                return SymbolicLink(path: self)
            } else if let isAliasFile = resourceValues.isAliasFile, isAliasFile {
                return Alias(path: self)
            } else if let isRegularFile = resourceValues.isRegularFile, isRegularFile {
                return RegularFile(path: self)
            } else {
                return nil
            }
        } catch _ {
            return nil
        }
    }
}

extension Path: Hashable {
    public var hashValue: Int {
        return rawValue.hashValue
    }
}

public func ==(lhs: Path, rhs: Path) -> Bool {
    return lhs.url.standardizedFileURL == rhs.url.standardizedFileURL
}
