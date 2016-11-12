//
//  SymbolicLinkable.swift
//  FileSystem
//
//  Created by Spencer MacDonald on 23/10/2016.
//  Copyright © 2016 Square Bracket Software. All rights reserved.
//

import Foundation

/// `SymbolicLinkable` `protocol` for an `Item` that can be symbolic linked to a `Path`.
public protocol SymbolicLinkable: Item {
    /// Symbolic links the instance of the conforming type to the specified path, returning the symbolic link.
    func symbolicLink(to path: Path) throws -> SymbolicLink
}

extension SymbolicLinkable {
    /// Returns a `SymbolicLink` created at the specified `Path`.
    ///
    /// - parameter path: The path to create thw symbolic link at.
    ///
    /// - throws: An `Error`.
    ///
    /// - returns: The created `SymbolicLink`.
    public func symbolicLink(to path: Path) throws -> SymbolicLink {
        try FileManager.default.createSymbolicLink(at: self.path.url, withDestinationURL: path.url)
        return SymbolicLink(path)
    }
}
