//
//  Directory.swift
//  FileSystem
//
//  Created by Spencer MacDonald on 21/09/2016.
//  Copyright © 2016 Square Bracket Software. All rights reserved.
//

import Foundation

/// `Directory` is a `struct` that is used to represent a directory.
public struct Directory: Item, Parent, Subitem, Copyable, CopyableSubitem, Moveable, MoveableSubitem, Renameable, Removeable, Trashable, SymbolicLinkable, FileWrapperConvertible {
    public var path: Path
    
    /// Creates a `Directory` instance with the specified path.
    ///
    /// - parameter path: The path for the directory.
    ///
    /// - returns: A new `Directory` instance or nil if the `Directory` does not exist at the specified path.
    public init?(path: Path) {
        do {
            let resourceValues = try path.url.resourceValues(forKeys: [.isDirectoryKey])
            
            if let isDirectory = resourceValues.isDirectory, isDirectory {
                self.init(path: path)
            } else {
                return nil
            }
            
        } catch _ {
            return nil
        }
    }
    
    /// Creates a `Directory` instance with the specified path.
    ///
    /// - parameter path: The path for the directory.
    ///
    /// - returns: A new `Directory` instance
    public init(_ path: Path) {
        self.path = path
    }
    
    @available(iOS 10.0, tvOS 10.0, watchOS 3.0, macOS 10.12, *)
    /// Returns a Temporary `Directory`.
    public static var temporary: Directory {
        let url = FileManager.default.temporaryDirectory
        return Directory(Path(url))
    }
    
    /// Returns the Document `Directory` in the current users home directory.
    public static var document: Directory {
        let documentUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return Directory(Path(documentUrl))
    }
    
    /// Returns the Library `Directory` in the current users home directory.
    public static var library: Directory {
        let libraryUrl = FileManager.default.urls(for: .libraryDirectory, in: .userDomainMask).first!
        return Directory(Path(libraryUrl))
    }
    
    /// Returns the Caches `Directory` in the current users home directory.
    public static var caches: Directory {
        let cachesUrl = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!
        return Directory(Path(cachesUrl))
    }
    
    /// Returns the Application(s) `Directory` in the current users home directory.
    public static var application: Directory {
        let applicationUrl = FileManager.default.urls(for: .applicationDirectory, in: .userDomainMask).first!
        return Directory(Path(applicationUrl))
    }
    
    /// Returns the Downloads `Directory` in the current users home directory.
    public static var applicationSupport: Directory {
        let applicationSupportUrl = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).first!
        return Directory(Path(applicationSupportUrl))
    }
  
    /// Returns the Desktop `Directory` in the current users home directory.
    public static var desktop: Directory {
        let desktopUrl = FileManager.default.urls(for: .desktopDirectory, in: .userDomainMask).first!
        return Directory(Path(desktopUrl))
    }
    
    /// Returns the Downloads `Directory` in the current users home directory.
    public static var downloads: Directory {
        let downloadsUrl = FileManager.default.urls(for: .downloadsDirectory, in: .userDomainMask).first!
        return Directory(Path(downloadsUrl))
    }
    
    /// Returns the Movies `Directory` in the current users home directory.
    public static var movies: Directory {
        let moviesUrl = FileManager.default.urls(for: .moviesDirectory, in: .userDomainMask).first!
        return Directory(Path(moviesUrl))
    }
    
    /// Returns the Music `Directory` in the current users home directory.
    public static var music: Directory {
        let musicUrl = FileManager.default.urls(for: .moviesDirectory, in: .userDomainMask).first!
        return Directory(Path(musicUrl))
    }
    
    /// Returns the Pictures `Directory` in the current users home directory.
    public static var pictures: Directory {
        let picturesUrl = FileManager.default.urls(for: .picturesDirectory, in: .userDomainMask).first!
        return Directory(Path(picturesUrl))
    }
    
    /// Returns all directories where applications can be stored in the current users home directory.
    public static var applications: [Directory] {
        let applicationUrls = FileManager.default.urls(for: .allApplicationsDirectory, in: .userDomainMask)
        return applicationUrls.map( { Directory(Path($0)) } )
    }
    
    /// Returns all libaries where applications can be stored in the current users home directory.
    public static var libraries: [Directory] {
        let libraryUrls = FileManager.default.urls(for: .allLibrariesDirectory, in: .userDomainMask)
        return libraryUrls.map( { Directory(Path($0)) } )
    }
    
    /// Creates and returns a `Directory` at the specified path
    ///
    /// - parameter path: The path to create a directory at.
    /// - parameter withIntermediateDirectories: Passing `true` for withIntermediateDirectories will create any necessary intermediate directories.
    ///
    /// - throws: An `Error`
    ///
    /// - returns: A `Directory` or throws an `Error`.
    public static func create(at path: Path, withIntermediateDirectories: Bool = false) throws -> Directory {
        try FileManager.default.createDirectory(at: path.url, withIntermediateDirectories: withIntermediateDirectories, attributes: nil)
        return Directory(path)
    }
    
    public func relationship(to item: Item) throws -> FileManager.URLRelationship {
        var urlRelationship: FileManager.URLRelationship = .other
        try FileManager.default.getRelationship(&urlRelationship, ofDirectoryAt: path.url, toItemAt: item.path.url)
        return urlRelationship
    }
}

#if os(macOS)
extension Directory {
    /// Returns the home `Directory` for the current user.
    ///
    /// - returns: A `Directory`.
    @available(macOS 10.12, *)
    public static var home: Directory {
        let url = FileManager.default.homeDirectoryForCurrentUser
        return Directory(Path(url))
    }

    /// Returns the home `Directory` for the specified user.
    ///
    /// - parameter user: The user for the home directory.
    ///
    /// - returns: A `Directory` or nil if there is no home directory for the specified user.
    @available(macOS 10.12, *)
    public static func home(forUser user: String) -> Directory? {
        guard let url = FileManager.default.homeDirectory(forUser: user) else {
            return nil
        }
        return Directory(Path(url))
    }
}
#endif
