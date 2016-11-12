//
//  FileWrapperConvertible.swift
//  FileSystem
//
//  Created by Spencer MacDonald on 02/11/2016.
//  Copyright © 2016 Square Bracket Software. All rights reserved.
//

import Foundation

/// `FileWrapperConvertible` `protocol` for an `Item` that can be converted into a `FileWrapper`.
public protocol FileWrapperConvertible: Item {
    /// Returns a file wrapper instantiated with the instance of the conforming type.
    func fileWrapper() throws -> FileWrapper
}

extension FileWrapperConvertible {
    /// Returns a `FileWrapper` for the `Item`.
    ///
    /// - throws: An `Error`.
    ///
    /// - returns: A `FileWrapper`.
    public func fileWrapper() throws -> FileWrapper {
        return try FileWrapper(url: path.url, options: [])
    }
}
