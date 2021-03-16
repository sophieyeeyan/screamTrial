//
//  AppDelegate.swift
//  trial
//
//  Created by sophie on 09/03/2021.
//

import UIKit
import AVFoundation

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let audioEngine = AVAudioEngine()


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
               
        do {
            try startMonitoring()
        } catch {
            print("error?")
        }
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        audioEngine.stop()
    }
    
    func startMonitoring() throws {
        let inputNode = audioEngine.inputNode
        let recordingFormat = inputNode.outputFormat(forBus: 0)
        
        print("Start")
        
        inputNode.installTap(onBus: 0,
                             bufferSize: 1024,
                             format: recordingFormat) {
            (buffer: AVAudioPCMBuffer, when: AVAudioTime) in
            if let audio = buffer.floatChannelData {
                var rms:Float = 0.0
                for i in 0..<Int(buffer.frameCapacity)
                {
                    rms+=abs(audio[0][i])
                }
                rms /= Float(buffer.frameCapacity)
                print("loudnes RMS = \(rms)")
            }
        }
        try audioEngine.start()
    }
}

