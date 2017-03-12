//
//  Comrade.swift
//  Comrade
//
//  Created by Michal Miedlarz on 26.02.2017.
//  Copyright © 2017 DogsField. All rights reserved.
//

import Foundation

public class Comrade
{
    public var isRunning = false
    
    init(collectors: Array<DataCollector>, storages: Array<DataStorage>)
    {
        
    }
    
    public func start()
    {
        isRunning = true
    }
    
    public func stop()
    {
        isRunning = false
    }
}
