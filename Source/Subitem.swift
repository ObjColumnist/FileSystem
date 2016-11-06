//
//  Subitem.swift
//  FileSystem
//
//  Created by Spencer MacDonald on 23/10/2016.
//  Copyright © 2016 Square Bracket Software. All rights reserved.
//

import Foundation

/// `Subitem` `protocol` for an `Item` that can be a subitem of another `Item`.
public protocol Subitem: Item {
    func rootVolume() throws -> Volume
    func parentDirectory() throws -> Directory?
}

extension Subitem {
    /// Returns the root `Volume` for an `Item`.
    ///
    /// - throws: An `Error`.
    ///
    /// - returns: A `Volume`
    public func rootVolume() throws -> Volume {
        let values = try path.url.resourceValues(forKeys: [.volumeURLKey])
        return Volume(Path(values.volume!))
    }
    
    /// Returns the parent `Directory` for an `Item` or nil if the directory is the root directory of a volume.
    ///
    /// - throws: An `Error`.
    ///
    /// - returns: A `Directory` or nil
    public func parentDirectory() throws -> Directory? {
        do {
            let values = try path.url.resourceValues(forKeys: [.parentDirectoryURLKey])
            
            guard let parentDirectoryURL = values.parentDirectory else {
                return nil
            }
            
            return Directory(path: Path(parentDirectoryURL))
        } catch {
            return nil
        }
    }
}
