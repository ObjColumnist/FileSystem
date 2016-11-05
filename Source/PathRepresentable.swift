//
//  PathRepresentable.swift
//  FileSystem
//
//  Created by Spencer MacDonald on 21/09/2016.
//  Copyright © 2016 Square Bracket Software. All rights reserved.
//

import Foundation

/// `PathRepresentable` can be adopted by anything that can be represented by a `Path`.
public protocol PathRepresentable {
    var path: Path { get }
    
    init?(path: Path)
}
