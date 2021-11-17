//
//  main.swift
//  swiftCLI
//
//  Created by Apple on 17/11/21.
//

import Foundation


extension Process {
    @discardableResult func launchBash(withCommand command: String) -> String? {
        launchPath = "/bin/bash"
        arguments = ["-c", command]
        
        let pipe = Pipe()
        standardOutput = pipe
        
        standardError = Pipe()
        
        launch()
        waitUntilExit()
        
        let outputData = pipe.fileHandleForReading.readDataToEndOfFile()
        return String(data: outputData, encoding: .utf8)?.nonEmpty
    }
    
    func gitConfigValue(forKey key: String) -> String? {
        return launchBash(withCommand: "git config --global --get \(key)")?.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
