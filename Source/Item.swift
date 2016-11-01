//
//  Item.swift
//  FileSystem
//
//  Created by Spencer MacDonald on 21/09/2016.
//  Copyright © 2016 Square Bracket Software. All rights reserved.
//

import Foundation

public protocol Item: PathRepresentable, CustomStringConvertible, CustomDebugStringConvertible {
    var path: Path { get set }
    
    init(_ path: Path)
}

extension Item /* CustomStringConvertible*/ {
    public var description: String {
        return "\(type(of: self)) \(path.rawValue)"
    }
}

extension Item /* CustomDebugStringConvertible */ {
    public var debugDescription: String {
        return description
    }
}

extension Item {
    public func exists() throws -> Bool {
        return FileManager.default.fileExists(atPath: path.rawValue)
    }
    
    public func localizedName() throws -> String {
        let values = try path.url.resourceValues(forKeys: [.localizedNameKey])
        return values.localizedName!
    }
    
    public func isReadable() throws -> Bool {
        let values = try path.url.resourceValues(forKeys: [.isReadableKey])
        return values.isReadable!
    }
    
    public func isWritable() throws -> Bool {
        let values = try path.url.resourceValues(forKeys: [.isWritableKey])
        return values.isWritable!
    }
    
    public func isExecutable() throws -> Bool {
        let values = try path.url.resourceValues(forKeys: [.isExecutableKey])
        return values.isExecutable!
    }
    
    public func isHidden() throws -> Bool {
        let values = try path.url.resourceValues(forKeys: [.isHiddenKey])
        return values.isHidden!
    }
    
    public func isPackage() throws -> Bool {
        let values = try path.url.resourceValues(forKeys: [.isPackageKey])
        return values.isPackage!
    }
    
    @available(iOS 9.0, tvOS 9.0, watchOS 2.0, macOS 10.11, *)
    public func isApplication() throws -> Bool {
        let values = try path.url.resourceValues(forKeys: [.isApplicationKey])
        return values.isApplication!
    }
    
    public func isAlias() throws -> Bool {
        let values = try path.url.resourceValues(forKeys: [.isAliasFileKey])
        return values.isAliasFile!
    }
    
    public func isSymbolicLink() throws -> Bool {
        let values = try path.url.resourceValues(forKeys: [.isSymbolicLinkKey])
        return values.isSymbolicLink!
    }
    
    public func creationDate() throws -> Date {
        let values = try path.url.resourceValues(forKeys: [.creationDateKey])
        return values.creationDate!
    }
    
    public func contentAccessDate() throws -> Date  {
        let values = try path.url.resourceValues(forKeys: [.contentAccessDateKey])
        return values.contentAccessDate!
    }
    
    public func contentModificationDate() throws -> Date  {
        let values = try path.url.resourceValues(forKeys: [.contentModificationDateKey])
        return values.contentModificationDate!
    }
    
    public func attributeModificationDate() throws -> Date  {
        let values = try path.url.resourceValues(forKeys: [.attributeModificationDateKey])
        return values.attributeModificationDate!
    }
    
    public func attributes() throws -> [FileAttributeKey: Any]  {
        return try FileManager.default.attributesOfItem(atPath: path.rawValue)
    }
    
    public func setAttributes(_ attributes: [FileAttributeKey: Any]) throws {
        return try FileManager.default.setAttributes(attributes, ofItemAtPath: path.rawValue)
    }
}
