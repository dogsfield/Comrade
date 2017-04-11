//
//  BatteryUsageDataChunk.swift
//  Comrade
//
//  Created by Michal Miedlarz on 12.03.2017.
//  Copyright © 2017 DogsField. All rights reserved.
//

import UIKit

public class BatteryUsageDataChunk: DataChunk
{
    public let level: Float
    public let state: UIDeviceBatteryState
    
    init(level: Float, state: UIDeviceBatteryState)
    {
        self.level = level
        self.state = state
    }
}
