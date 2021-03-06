//
//  Room.swift
//  LightingKit
//
//  Created by Peter Morris on 21/11/2018.
//  Copyright © 2018 Pete Morris. All rights reserved.
//

import Foundation
import HomeKit

/// Represents a HomeKit room
public struct Room: LightingKitObject {
    /// The name of the room.
    public let name: String
    /// The unique identifier for the room.
    public let uuid: UUID
    /**
     Initializes a `Room` object.
     - Parameters:
     - name: The name of the light.
     - id: The unique identifier for the light.
     - returns: An initialized `Room` object.
     */
    public init(name: String, uuid: UUID) {
        self.name = name
        self.uuid = uuid
    }
}

extension Room: Equatable {
    static func == (lhs: Room, rhs: HomeKitObjectProtocol) -> Bool {
        return lhs.uuid == rhs.uniqueIdentifier
    }
}
