//
//  RegularFile.swift
//  FileSystem
//
//  Created by Spencer MacDonald on 21/10/2016.
//  Copyright © 2016 Square Bracket Software. All rights reserved.
//

import Foundation

/// `RegularFile` is a `struct` that is used to represent a regular file i.e. not a symlink or alias.
public struct RegularFile: File, Aliasable, FileHandleConvertible, FileWrapperConvertible {
    public var path: Path
    
    /// Creates a `RegularFile` instance with the specified path.
    ///
    /// - parameter path: The path for the regular file.
    ///
    /// - returns: A new `RegularFile` instance or nil if the `RegularFile` does not exist at the specified path.
    public init?(path: Path) {
        do {
            let resourceValues = try path.url.resourceValues(forKeys: [.isRegularFileKey])
            
            if let isRegularFile = resourceValues.isRegularFile, isRegularFile {
                self.init(path: path)
            } else {
                return nil
            }
            
        } catch _ {
            return nil
        }
    }
    
    /// Creates a `RegularFile` instance with the specified path.
    ///
    /// - parameter path: The path for the regular file.
    ///
    /// - returns: A new `RegularFile` instance.
    public init(_ path: Path) {
        self.path = path
    }
    
    /// Returns the contents of the file in bytes
    public func size() throws -> Int {
        let values = try path.url.resourceValues(forKeys: [.fileSizeKey])
        return values.fileSize!
    }
}
