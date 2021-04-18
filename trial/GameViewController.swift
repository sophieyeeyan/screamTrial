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

   
    @IBOutlet weak var ChecktimeLabel: UILabel!
    @IBOutlet weak var CountdownLabel: UILabel!
    @IBOutlet weak var ScoreLabel: UILabel!
    @IBOutlet weak var animation1: UIImageView!
    @IBOutlet weak var animation2: UIImageView!
    
    @IBOutlet weak var ProgressBar: UIProgressView!
    @IBOutlet weak var LoudnessText: UITextView!
    var tap: UITapGestureRecognizer!
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    var gameScore = 0
    var timeAboveThreshold = 0
    var gameTimer: Timer?
    var countdownTimer:Timer?
    var progressBarTimer: Timer?
    var scoreTimer: Timer?
    var callProgressTimer: Timer?
    var checkLoudnessTimer: Timer?
    var appRunningTime = 0
    var timeLeft = 60
    var name = ""
    var view2play: UIImageView!
    var roar1: UIImage!
    var roar2: UIImage!
    
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
    
    @objc func scoreText(){
       ScoreLabel.text = String(gameScore)
    }
    
    @objc func onTimerFires()
    {
        timeLeft -= 1
        CountdownLabel.text = String(timeLeft)

        if timeLeft <= 0 {
            countdownTimer?.invalidate()
            countdownTimer = nil
        }
    }
    
    @objc func checkLoudness()
    {
        appRunningTime += 1
        //ChecktimeLabel.text = String(appRunningTime)
        let currentRms = appDelegate.someVariable
        
        let threshold:Int = Int(0.05)
        
        if Int(currentRms) >= threshold
        {
            print("someone is speaking loudly")
            animation2.image = roar1
            timeAboveThreshold += 1
            var showRoar = true
            if (showRoar)
            {
             animation2.image = roar2
                print("loading roar2")
            }
            else
            {
             showRoar = false
             animation2.image = roar1
                print("loading roar 1")
            }
        }
        else
        {
            print("someone is speaking quietly")
            animation2.image = roar2
            timeAboveThreshold = 0
            let dontshowRoar = true
                if (dontshowRoar)
                {
                 animation2.image = roar1
                print("loading dont show roar2")

                }
                else
                {
                 animation2.image = roar2
                    print("loading dont show roar2")

                }
        }
        
        
        if timeAboveThreshold > 3 {
        timeAboveThreshold = 0
        print(timeAboveThreshold)
        gameScore += 10
        print("you have get one loud point")
        //print(gameScore)
        }
        
        if timeAboveThreshold > 30 {
            animation1.startAnimating()
            //animation2.startAnimating()
            print("level 1 completed")
        }
        
       
        
      
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tap = UITapGestureRecognizer(target: self, action: #selector(GameViewController.handleTap(_:)))
        view.addGestureRecognizer(tap)
        
        ProgressBar.progress = 0.0
        ProgressBar.transform =  ProgressBar.transform.scaledBy(x:1 , y:4)
        progressBar()
        

        let destoryImages = ["bol_1","bol_2", "bol_3","bol_4","bol_5", "bol_6","bol_7","bol_8","bol_9","bol_10"]
        let dinoImages = ["roar_1", "roar_2"]
        roar1 = UIImage(named: dinoImages[0])!
        roar2 = UIImage(named: dinoImages[1])!
        
    
        loadAnimation(view2load: self.animation1, imageNames: destoryImages, animationDuration: 5.0)
        //loadAnimation(view2load: self.animation2, imageNames: dinoImages, animationDuration: 1.0)
        

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
        
        //var a:loudControlAnimation = loudControlAnimation()
        //a.test = "I am testing"
        //print(a.test)
        countdownTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(onTimerFires), userInfo: nil, repeats: true)
        gameTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(loudnessText), userInfo: nil, repeats: true)
        gameTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(loudControl), userInfo: nil, repeats: true)
        //callProgressTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(progressBar), userInfo: nil, repeats: true)
        checkLoudnessTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(checkLoudness), userInfo: nil, repeats: true)
        scoreTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(scoreText), userInfo: nil, repeats: true)
    }
    
    @objc func loudControl(){
        //let currentRms = appDelegate.someVariable
        //let aVariablesum = aVariable.reduce(0, +)
        //
        //let view2play = animation1
        
        //if currentRms > 0.05 {
        //if appRunningTime > 3 {
        //print("this is loud mate")
            //animation1.startAnimating()
            //animation2.startAnimating()

        //} else {
        //print("this is quiet mate")
        //}
    }
    
    @objc func addScore () {
        
    }
    

    @objc func progressBar (){
        var progress: Float = 0.0
        ProgressBar.progress = progress
        let currentRms = appDelegate.someVariable
        
        progressBarTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { (Timer) in

            var progress = Double(self.gameScore)/100
            //print(progress)
            self.ProgressBar.progress = Float(progress)
        
            
            if  self.ProgressBar.progress == 1.0 {
                //self.ProgressBar.progress = 0.0

            }
    
        })

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
