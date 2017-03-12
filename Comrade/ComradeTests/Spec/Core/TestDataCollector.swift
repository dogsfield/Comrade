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
    weak var delegate: DataCollectorDelegate?
    
    func start()
    {
        
    }
    
    func stop()
    {
        
    }
    
    func isRunning() -> Bool
    {
        return false
    }
}
