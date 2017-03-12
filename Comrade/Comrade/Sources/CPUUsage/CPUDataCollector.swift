//
//  CPUDataCollector.swift
//  Comrade
//
//  Created by Nomtek on 12.03.2017.
//  Copyright © 2017 DogsField. All rights reserved.
//

import UIKit

class CPUDataCollector: NSObject, DataCollector
{
    weak var delegate: DataCollectorDelegate?
    
    var isModuleRunning = false
    
    public func start()
    {
        isModuleRunning = true
    }
    
    public func stop()
    {
        isModuleRunning = false
    }
    
    public func isRunning() -> Bool
    {
        return isModuleRunning
    }

}
