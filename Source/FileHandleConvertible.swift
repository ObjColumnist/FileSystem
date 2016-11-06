//
//  FileHandleConvertible.swift
//  FileSystem
//
//  Created by Spencer MacDonald on 03/11/2016.
//  Copyright © 2016 Square Bracket Software. All rights reserved.
//

import Foundation

/// `FileHandleConvertible` `protocol` for an `Item` that can be converted into a `FileHandle` for either reading, writing or updating (both reading and writing).
public protocol FileHandleConvertible: Item {
    func fileHandleForReading() throws -> FileHandle
    func fileHandleForWriting() throws -> FileHandle
    func fileHandleForUpdating() throws -> FileHandle
}

extension FileHandleConvertible {
    /// Returns a `FileHandle` for Reading.
    ///
    /// - throws: An `Error`.
    ///
    /// - returns: A `FileHandle` for reading.
    public func fileHandleForReading() throws -> FileHandle {
        return try FileHandle(forReadingFrom: path.url)
    }

    /// Returns a `FileHandle` for Writing.
    ///
    /// - throws: An `Error`.
    ///
    /// - returns: A `FileHandle` for writing.
    public func fileHandleForWriting() throws -> FileHandle {
        return try FileHandle(forWritingTo: path.url)
    }

    /// Returns a `FileHandle` for Updating.
    ///
    /// - throws: An `Error`.
    ///
    /// - returns: A `FileHandle` for updating (both reading and writing).
    public func fileHandleForUpdating() throws -> FileHandle {
        return try FileHandle(forUpdating: path.url)
    }
}
