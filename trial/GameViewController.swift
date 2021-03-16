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

    @IBOutlet weak var ImageView: UIImageView!
    @IBOutlet weak var ImageViewTwo: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let imagesNames = ["bol_1","bol_2", "bol_3","bol_4","bol_5", "bol_6","bol_7","bol_8","bol_9","bol_10"]
        
        let imageNamesTwo = ["roar_1", "roar_2"]
        
        var images = [UIImage]()
        for i in 0..<imagesNames.count{
            print("trying to load imageNames" + imagesNames [i] )
            images.append(UIImage(named: imagesNames[i])!)
        }
        
        ImageView.animationImages = images
        ImageView.animationDuration = 5.0
    
        func touchDown(atPoint pos : CGPoint) {
            ImageView.startAnimating()

            }
        

        
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
    }

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
