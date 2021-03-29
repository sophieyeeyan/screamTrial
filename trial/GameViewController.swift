//
//  GameViewController.swift
//  trial
//
//  Created by sophie on 09/03/2021.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    @IBOutlet weak var animation1: UIImageView!
    @IBOutlet weak var animation2: UIImageView!
    
    @IBOutlet weak var LoudnessText: UITextView!
    var tap: UITapGestureRecognizer!
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var gameTimer: Timer?
        
    @objc func handleTap(_ gesture: UITapGestureRecognizer) {
        //touchDown(view2play: animation1)
        //touchDown(view2play: animation2)

    }
    
    @objc func loudnessText () {
        let aVariable = appDelegate.someVariable
        LoudnessText.text = String(aVariable)
        //LoudnessText.text = String((format: "RMS: %.3f", aVariable))
        //LoundnessText.text = aVariable
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tap = UITapGestureRecognizer(target: self, action: #selector(GameViewController.handleTap(_:)))
        view.addGestureRecognizer(tap)
        loudControl(view2play: animation1)
        loudControl(view2play: animation2)

        
        let destoryImages = ["bol_1","bol_2", "bol_3","bol_4","bol_5", "bol_6","bol_7","bol_8","bol_9","bol_10"]
        
        let dinoImages = ["roar_1", "roar_2"]
       
        loadAnimation(view2load: self.animation1, imageNames: destoryImages, animationDuration: 5.0)
        loadAnimation(view2load: self.animation2, imageNames: dinoImages, animationDuration: 1.0)

        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                
                // Present the scene
                view.presentScene(scene)
            }
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
        }
        
        gameTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(loudnessText), userInfo: nil, repeats: true)

    }
    

    
    func loadAnimation (view2load: UIImageView, imageNames: [String], animationDuration: Double) {
        var images = [UIImage]()
        for i in 0..<imageNames.count{
            print("trying to load imageNames" + imageNames [i] )
            images.append(UIImage(named: imageNames[i])!)
        }
        view2load.animationImages = images
        view2load.animationDuration = animationDuration
    }
   

    func touchDown(view2play: UIImageView) {
        print("touched")
        view2play.startAnimating()
    }
    
    func loudControl(view2play: UIImageView){
        let aVariable = appDelegate.someVariable
        if aVariable > 0.001 {
        print("this is loud mate")
        view2play.startAnimating()
        } else {
        print("this is quiet mate")
        }
    }
    
    //func 

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
