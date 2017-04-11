//
//  BatteryUsageDataCollector.swift
//  Comrade
//
//  Created by Michal Miedlarz on 12.03.2017.
//  Copyright © 2017 DogsField. All rights reserved.
//

import UIKit

public class BatteryUsageDataCollector: NSObject, DataCollector
{

    public let timeInterval: TimeInterval
    public let device: UIDevice
    public weak var delegate: DataCollectorDelegate?
    private var timer: Timer?
    
    init(timeInterval: TimeInterval, device: UIDevice = UIDevice.current)
    {
        self.timeInterval = timeInterval
        self.device = device
    }
    
    //MARK: DataCollector protocol implementation
    public func isRunning() -> Bool
    {
        return timer != nil
    }
    
    public func stop()
    {
        clearTimer()
    }
    
    public func start()
    {
        clearTimer()
        timer = Timer.scheduledTimer(timeInterval: timeInterval, target: self, selector: #selector(collectBatteryData), userInfo: nil, repeats: true)
    }
    
    //MARK: Utils
    func collectBatteryData()
    {
        let chunk = BatteryUsageDataChunk(level: device.batteryLevel, state: device.batteryState)
        delegate?.dataCollector(sender: self, handleChunk: chunk, error: nil)
    }
    
    private func clearTimer()
    {
        timer?.invalidate()
        timer = nil
    }
}
