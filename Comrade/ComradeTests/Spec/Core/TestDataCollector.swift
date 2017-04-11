//
//  TestDataCollector.swift
//  Comrade
//
//  Created by Michal Miedlarz on 27.02.2017.
//  Copyright © 2017 DogsField. All rights reserved.
//

import UIKit
import Comrade

class TestDataCollector: DataCollector
{
    weak public var delegate: DataCollectorDelegate?
    private var running = false
    
    public func isRunning() -> Bool
    {
        return running
    }

    public func start()
    {
        running = true
    }

    public func stop()
    {
        running = false
    }
}
