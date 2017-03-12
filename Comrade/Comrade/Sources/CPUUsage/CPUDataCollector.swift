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
    
    let timeInterval: Double
    fileprivate var isModuleRunning = false
    var timer: Timer
    
    init(timeInterval: Double)
    {
        self.timeInterval = timeInterval
        self.timer = Timer()
    }
    
    public func start()
    {
        isModuleRunning = true
        timer = Timer.scheduledTimer(timeInterval: timeInterval, target: self, selector: #selector(self.update), userInfo: nil, repeats: true)
        timer.
    }
    
    public func stop()
    {
        isModuleRunning = false
    }
    
    func update()
    {
        
    }
    
    public func isRunning() -> Bool
    {
        return isModuleRunning
    }

}
