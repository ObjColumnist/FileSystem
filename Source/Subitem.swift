//
//  Subitem.swift
//  FileSystem
//
//  Created by Spencer MacDonald on 23/10/2016.
//  Copyright © 2016 Square Bracket Software. All rights reserved.
//

import Foundation

public protocol Subitem: Item {
    func rootVolume() throws -> Volume
    func parentDirectory() throws -> Directory?
}

extension Subitem {
    public func rootVolume() throws -> Volume {
        let values = try path.url.resourceValues(forKeys: [.volumeURLKey])
        return Volume(Path(values.volume!))
    }
    
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
