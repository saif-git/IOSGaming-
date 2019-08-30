//
//  EndScene.swift
//  GameStart
//
//  Created by user on 18/08/2019.
//  Copyright © 2019 user. All rights reserved.
//

import Foundation
import SpriteKit
import UIKit

class EndScene: SKScene {
    
    var restartBtn : UIButton!
    var scoreF : UILabel!
    var scoreLa : UILabel!
    var highScoreLa : UILabel!
    var leaveScene : UIButton!
    override func didMove(to view: SKView){
      //  NSLog("hey from end scene")
        scene?.backgroundColor = UIColor.white
    
        restartBtn = UIButton(frame: CGRect(x: 200, y: 400, width: view.frame.width/3, height: 30))
        restartBtn.backgroundColor = UIColor.gray
        restartBtn.setTitle("Restart", for: .normal)
        restartBtn.center = CGPoint(x: view.frame.width/2, y: view.frame.width/2)
        restartBtn.layer.cornerRadius = 7.0
        restartBtn.setTitleColor(UIColor.darkGray, for: .highlighted)
        restartBtn.addTarget(self, action: #selector(targeted), for: .touchUpInside)
        
        leaveScene = UIButton(frame: CGRect(x: 200, y: 500, width: view.frame.width/3, height: 30))
        leaveScene.backgroundColor = UIColor.red
        leaveScene.setTitle("restart ", for: .normal)
        leaveScene.layer.cornerRadius = 10.0
        leaveScene.setTitleColor(.white, for: .highlighted)
        leaveScene.addTarget(self, action: #selector(leaved), for: .touchUpInside)
        
        
        let scoreDefault = UserDefaults.standard
        let score = scoreDefault.value(forKey: "Score") as? NSInteger
       // NSLog("your score :\(String(describing: score))")
        
         scoreLa = UILabel(frame: CGRect(x: 100, y: 300, width: view.frame.width, height: 30))
        scoreLa.text = "yout score :\(score)"
        self.view?.addSubview(scoreLa)
       
        
        let highscoreDefault = UserDefaults.standard
        let highScore = highscoreDefault.value(forKey: "HighScore") as? NSInteger
         highScoreLa = UILabel(frame: CGRect(x: 100, y: 400, width: view.frame.width, height: 30))
        
        highScoreLa.text = "high score :\(highScore)"
        
        self.view?.addSubview(highScoreLa)
        
        self.view?.addSubview(restartBtn)
        
        self.view?.addSubview(leaveScene)
    }
    
    @objc func targeted() {

        
        let doors2 = SKTransition.push(with: SKTransitionDirection.down, duration: 1.0)
        let gamerScene = GameScene(fileNamed: "GameScene")
        gamerScene?.scaleMode = .aspectFill
        self.view?.presentScene(gamerScene!, transition: doors2)
        
        restartBtn.removeFromSuperview()
        highScoreLa.removeFromSuperview()
        scoreLa.removeFromSuperview()
        leaveScene.removeFromSuperview()
        
            }
    
    @objc func leaved() {
        

        //let nextViewController = UIStoryboard.instantiateViewController(withIdentifier: "CollectionStory") as! CollectionViewController

       // let nextViewController = CollectionViewController(nibName: "CollectionStory", bundle: nil)

        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let collectionViewCont = storyBoard.instantiateViewController(withIdentifier: "CollectionStory") as! CollectionViewController
        let doors = SKTransition.push(with: SKTransitionDirection.left, duration: 1.0)

        let gamerScene = GameScene(fileNamed: "GameScene")
       gamerScene?.view?.window?.rootViewController = collectionViewCont
        
        self.view?.presentScene(gamerScene!, transition: doors)

        restartBtn.removeFromSuperview()
        highScoreLa.removeFromSuperview()
        scoreLa.removeFromSuperview()
        leaveScene.removeFromSuperview()
    }
}

