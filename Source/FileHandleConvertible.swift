//
//  FileHandleConvertible.swift
//  FileSystem
//
//  Created by Spencer MacDonald on 03/11/2016.
//  Copyright © 2016 Square Bracket Software. All rights reserved.
//

import Foundation

/// `FileHandleConvertible` `protocol` for an `Item` that can be converted into a `FileHandle` for reading, writing or updating (both reading and writing).
public protocol FileHandleConvertible: Item {
    func fileHandleForReading() throws -> FileHandle
    func fileHandleForWriting() throws -> FileHandle
    func fileHandleForUpdating() throws -> FileHandle
}

extension FileHandleConvertible {
    public func fileHandleForReading() throws -> FileHandle {
        return try FileHandle(forReadingFrom: path.url)
    }

    public func fileHandleForWriting() throws -> FileHandle {
        return try FileHandle(forWritingTo: path.url)
    }

    public func fileHandleForUpdating() throws -> FileHandle {
        return try FileHandle(forUpdating: path.url)
    }
}
