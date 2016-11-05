//
//  Volume.swift
//  FileSystem
//
//  Created by Spencer MacDonald on 21/09/2016.
//  Copyright © 2016 Square Bracket Software. All rights reserved.
//

import Foundation

/// `Volume` is a `struct` that is used to represent a volume.
public struct Volume: Item, Parent, Renameable, Linkable, SymbolicLinkable {
    public var path: Path
    
    /// Creates a `Volume` instance with the specified path.
    ///
    /// - parameter path: The path for the volume.
    ///
    /// - returns: A new `Volume` instance or nil if the `Volume` does not exist at the specified path.
    public init?(path: Path) {
        do {
            let resourceValues = try path.url.resourceValues(forKeys: [.isVolumeKey])
            
            if let isVolume = resourceValues.isVolume, isVolume {
                self.init(path: path)
            } else {
                return nil
            }
            
        } catch _ {
            return nil
        }
    }
    
    /// Creates a `Volume` instance with the specified path.
    ///
    /// - parameter path: The path for the volume.
    ///
    /// - returns: A new `Volume` instance.
    public init(_ path: Path) {
        self.path = path
    }
    
    /// Returns mounted volumes
    public static var mounted: [Volume] {        
        guard let volumeURLs = FileManager.default.mountedVolumeURLs(includingResourceValuesForKeys: [], options: []), volumeURLs.isEmpty == false else {
            return []
        }
        
        var volumes: [Volume] = []
        
        for volumeURL in volumeURLs {
            let volume = Volume(Path(volumeURL))
            volumes.append(volume)
        }
        
        return volumes
    }
    
    /// Returns if total capacity of the volume in bytes.
    public func totalCapacity() throws -> Int {
        let values = try path.url.resourceValues(forKeys: [.volumeTotalCapacityKey])
        return values.volumeTotalCapacity!
    }
    
    /// Returns if available capacity of the volume in bytes.
    public func availableCapacity() throws -> Int {
        let values = try path.url.resourceValues(forKeys: [.volumeAvailableCapacityKey])
        return values.volumeAvailableCapacity!
    }
    
    /// Returns if used capacity of the volume in bytes.
    public func usedCapacity() throws -> Int {
        let total = try totalCapacity()
        let available = try availableCapacity()
        return total - available
    }
    
    /// Returns if the volume is ejectable.
    public func isEjectable() throws -> Bool {
        let values = try path.url.resourceValues(forKeys: [.volumeIsEjectableKey])
        return values.volumeIsEjectable!
    }
    
    /// Returns if the volume is removeable.
    public func isRemovable() throws -> Bool {
        let values = try path.url.resourceValues(forKeys: [.volumeIsRemovableKey])
        return values.volumeIsRemovable!
    }
    
    /// Returns if the volume is internal.
    public func isInternal() throws -> Bool {
        let values = try path.url.resourceValues(forKeys: [.volumeIsInternalKey])
        return values.volumeIsInternal!
    }
    
    /// Returns if the volume is local.
    public func isLocal() throws -> Bool {
        let values = try path.url.resourceValues(forKeys: [.volumeIsLocalKey])
        return values.volumeIsLocal!
    }
    
    /// Returns if the volume is read only.
    public func isReadOnly() throws -> Bool {
        let values = try path.url.resourceValues(forKeys: [.volumeIsReadOnlyKey])
        return values.volumeIsReadOnly!
    }
}

#if os(macOS)
extension Volume {
    /// Unmounts the volume
    ///
    /// - parameter options: An array of `FileManager.UnmountOptions` used to unmount the volume.
    /// - parameter completionHandler: The completion handler will be executed when the operation is complete, error will be nil the volume was unmounted.
    @available(macOS 10.11, *)
    public func unmount(withOptions options: FileManager.UnmountOptions = [], completionHandler: @escaping (Error?) -> Void) {
        FileManager.default.unmountVolume(at: path.url, options: options, completionHandler: completionHandler)
    }
}
#endif
