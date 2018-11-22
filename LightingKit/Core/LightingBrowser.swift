//
//  LightingBrowser.swift
//  LightingKit
//
//  Created by Peter Morris on 22/11/2018.
//  Copyright © 2018 Pete Morris. All rights reserved.
//

import Foundation
import HomeKit

/// Used to find new lighting accessories, which have yet to be setup for use with HomeKit.
class LightingBrowser: NSObject {
    typealias AccessoryCompletion = ((HMAccessory) -> Void)
    /// The `HMAccessoryBrowser` to search to perfom the accessory search.
    private let browser: HMAccessoryBrowser
    /// An array of new `HMAccessory` objects that have been found.
    private (set) public var newAccessories: [HMAccessory] = []
    /// The closure to execute when a new acccessory is found
    private var completion: AccessoryCompletion? {
        didSet {
            newAccessories.forEach {
                completion?($0)
            }
        }
    }
    /**
     Configures the object via HomeKit.
     - Parameters:
     - browser: The `HMAccessoryBrowser` to use for finding new accessories.
     - returns: An initialized `LightingBrowser` object.
     */
    init(browser: HMAccessoryBrowser = HMAccessoryBrowser()) {
        self.browser = browser
        super.init()
        self.browser.delegate = self
    }
    /**
     Begins a search for new lighting accessories.
     - Parameters:
     - complete: The closure to execute when a new accessory is found.
     - Warning: The `completion` closure is escaping, retained, and a reference to it is held for the
     lifetime of the object. Any objects used within should be declared `weak` or `unowned`.
     */
    func findNewLights(completion: @escaping AccessoryCompletion) {
        browser.stopSearchingForNewAccessories()
        newAccessories.removeAll()
        self.completion = completion
        browser.startSearchingForNewAccessories()
    }
    /**
     Ends the search for new lighting accessories.
     - Note: The `completion` passed in `findNewLights` will be nullified as a result.
     */
    func stop() {
        browser.stopSearchingForNewAccessories()
        completion = nil
    }
}

extension LightingBrowser: HMAccessoryBrowserDelegate {
    func accessoryBrowser(_ browser: HMAccessoryBrowser, didFindNewAccessory accessory: HMAccessory) {
        if accessory.isLighting {
            newAccessories.append(accessory)
            completion?(accessory)
        }
    }
    func accessoryBrowser(_ browser: HMAccessoryBrowser, didRemoveNewAccessory accessory: HMAccessory) {
        newAccessories.removeAll { $0 == accessory }
    }
}
