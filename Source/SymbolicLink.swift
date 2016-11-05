//
//  SymbolicLink.swift
//  FileSystem
//
//  Created by Spencer MacDonald on 21/10/2016.
//  Copyright © 2016 Square Bracket Software. All rights reserved.
//

import Foundation

/// `SymbolicLink` is a `struct` that is used to represent a symbolic link.
public struct SymbolicLink: File, FileWrapperConvertible {
    public var path: Path
    
    /// Creates a `SymbolicLink` instance with the specified path.
    ///
    /// - parameter path: The path for the symbolic link.
    ///
    /// - returns: A new `SymbolicLink` instance or nil if the `SymbolicLink` does not exist at the specified path.
    public init?(path: Path) {
        do {
            let resourceValues = try path.url.resourceValues(forKeys: [.isSymbolicLinkKey])
            
            if let isSymbolicLink = resourceValues.isSymbolicLink, isSymbolicLink {
                self.init(path: path)
            } else {
                return nil
            }
            
        } catch _ {
            return nil
        }
    }
    
    /// Creates a `SymbolicLink` instance with the specified path.
    ///
    /// - parameter path: The path for the symbolic link.
    ///
    /// - returns: A new `SymbolicLink` instance.
    public init(_ path: Path) {
        self.path = path
    }
    
    /// Returns a `SymbolicLinkable` destination if `path` is a valid symbolic link, otherise throws an `Error`.
    ///
    /// - throws: An `URLError`.
    ///
    /// - returns: A `SymbolicLinkable`.
    public func destination() throws -> SymbolicLinkable {
        let destinationURL = try FileManager.default.destinationOfSymbolicLink(atPath: path.rawValue)
        if let destination = Path(destinationURL).item as? SymbolicLinkable {
            return destination
        } else {
            throw URLError(.fileDoesNotExist)
        }
    }
}
