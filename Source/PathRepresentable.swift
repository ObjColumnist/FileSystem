//
//  PathRepresentable.swift
//  FileSystem
//
//  Created by Spencer MacDonald on 21/09/2016.
//  Copyright © 2016 Square Bracket Software. All rights reserved.
//

import Foundation

public protocol PathRepresentable {
    var path: Path { get }
    
    init?(path: Path)
}
