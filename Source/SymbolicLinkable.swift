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
    func symbolicLink(to path: Path) throws -> SymbolicLink
}

extension SymbolicLinkable {
    public func symbolicLink(to path: Path) throws -> SymbolicLink {
        try FileManager.default.createSymbolicLink(at: self.path.url, withDestinationURL: path.url)
        return SymbolicLink(path)
    }
}
