//
//  AliasFile.swift
//  FileSystem
//
//  Created by Spencer MacDonald on 21/10/2016.
//  Copyright © 2016 Square Bracket Software. All rights reserved.
//

import Foundation

/// `AliasFile` is a `struct` that is used to represent an alias.
public struct AliasFile: File {
    public var path: Path
    
    /// Creates a `AliasFile` instance with the specified path.
    ///
    /// - parameter path: The path for the alias file.
    ///
    /// - returns: A new `AliasFile` instance or nil if the `AliasFile` does not exist at the specified path.
    public init?(path: Path) {
        do {
            let resourceValues = try path.url.resourceValues(forKeys: [.isAliasFileKey])
            
            if let isAliasFile = resourceValues.isAliasFile, isAliasFile {
                self.init(path: path)
            } else {
                return nil
            }
            
        } catch _ {
            return nil
        }
    }
    
    /// Creates a `AliasFile` instance with the specified path.
    ///
    /// - parameter path: The path for the alias file.
    ///
    /// - returns: A new `AliasFile` instance.
    public init(_ path: Path) {
        self.path = path
    }
    
    /// Returns an `Aliasable` destination if `path` is a valid alias, otherise throws an `Error`.
    ///
    /// - throws: a `URLError`.
    ///
    /// - returns: An `Aliasable`.
    public func destination() throws -> Aliasable {
        let destinationURL = try NSURL(resolvingAliasFileAt: self.path.url, options: []) as URL
        if let destination = Path(destinationURL).item as? Aliasable {
            return destination
        } else {
            throw URLError(.fileDoesNotExist)
        }
    }
}
