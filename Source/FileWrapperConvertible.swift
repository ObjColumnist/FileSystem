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
    func fileWrapper() throws -> FileWrapper
}

extension FileWrapperConvertible {
    public func fileWrapper() throws -> FileWrapper {
        return try FileWrapper(url: path.url, options: [])
    }
}
