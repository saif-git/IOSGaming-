//
//  GameScene.swift
//  GameStart
// Jouini Saifeddine web and mobile develloper
//  Created by user on 29/07/2019.
//  Copyright © 2019 user. All rights reserved.
//

import SpriteKit
import GameplayKit

struct ColliderType {
    static let enemy : UInt32 = 1      // 000000000000001
    static let bullete : UInt32 = 2    // 000000000000010
    static let player : UInt32 = 3     // 000000000000000
    static let endContact : UInt32 = 0 // 000000000000011
    static let enemy2 : UInt32 = 4
}


class GameScene: SKScene ,SKPhysicsContactDelegate    {
    
    // MARK :- Variables
    var startfield : SKEmitterNode!
    var bubble1 : SKSpriteNode!
    var bubble2 : SKSpriteNode!
    var stop : Bool = true
    var scoreLa : SKLabelNode!
    var small : SKSpriteNode!
    var ball : SKSpriteNode!
    var  odds : SKSpriteNode!
    var  Enemy : SKSpriteNode!
    var end : SKSpriteNode!
    var needs : SKLabelNode!
    var number : Int = 0
    var touchLocation1 = CGPoint()
    var touchLocation2 = CGPoint()

    
    var highScore = Int()
    var score: Int=0{
        didSet{
            scoreLa.text = "Score : \(score)"
        }
    }
    
    
    var types = ["+","-"]
    var gameTimer : Timer!
    var passOdds = ["+Red","-Red","+Blue","-Blue"]
    let oddsCategory : UInt32 = 0x1 << 1
    let oddsTorpedoCategory : UInt32 = 0x1 << 0
    
   
    override func didMove(to view: SKView) {
     
        if(stop){
            
        
        let highScoreDefault = UserDefaults.standard
        if(highScoreDefault.value(forKey: "HighScore") != nil) {
            highScore = highScoreDefault.value(forKey: "HighScore") as! NSInteger
        }else {
            highScore = 0
        }
        
        
        startfield = SKEmitterNode(fileNamed: "magic")
        startfield.position = CGPoint(x:0 ,y :200)
        startfield.advanceSimulationTime(10)
        startfield.zPosition = -1
        
        self.addChild(startfield)
         setupPhysics()

        
        
        bubble1 = SKSpriteNode(imageNamed: "positive2")
        debugPrint("x :",self.frame.width/2)
        debugPrint("y :",self.frame.height/2)

        bubble1.position = CGPoint(x:100,y:-600)
        debugPrint("frame width ",frame.width)
        debugPrint("frame height ",frame.height)

        bubble1.size = CGSize(width: 100, height: 100)
        bubble1.physicsBody = SKPhysicsBody(circleOfRadius: bubble1.size.width/2)
        bubble1.physicsBody?.isDynamic = false
        bubble1.physicsBody?.categoryBitMask = ColliderType.player
        bubble1.physicsBody?.collisionBitMask = ColliderType.enemy
        bubble1.physicsBody?.contactTestBitMask = ColliderType.enemy
        bubble1.name = "positive"
        self.addChild(bubble1)
        
        bubble2 = SKSpriteNode(imageNamed: "negative2")
        debugPrint("x :",self.frame.width/2)
        debugPrint("y :",self.frame.height/2)
        
        bubble2.position = CGPoint(x:-100,y:-600)
        debugPrint("frame width ",frame.width)
        debugPrint("frame height ",frame.height)
        
        bubble2.size = CGSize(width: 100, height: 100)
        bubble2.physicsBody = SKPhysicsBody(circleOfRadius: bubble2.size.width/2)
        bubble2.physicsBody?.isDynamic = false
        bubble2.physicsBody?.categoryBitMask = ColliderType.player
        bubble2.physicsBody?.collisionBitMask = ColliderType.enemy2
        bubble2.physicsBody?.contactTestBitMask = ColliderType.enemy2
        bubble2.name = "negative"
        self.addChild(bubble2)
        
        
        
        scoreLa = SKLabelNode(text: "Score :0")
        scoreLa.position = CGPoint(x:0 ,y:500)
        scoreLa.fontName = "ArialHebrew"
        scoreLa.fontSize = 36
        scoreLa.fontColor = UIColor.white
        self.addChild(scoreLa)
        
            needs = SKLabelNode(text: " needs : \(types[0])")
        needs.position = CGPoint(x: 10, y: 450)
        needs.fontName = "ArialHebrew"
        needs.fontSize = 36
        needs.fontColor = UIColor.white
        self.addChild(needs)
        
      // add_Contacto()
        
        gameTimer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(addOdds), userInfo: nil, repeats: true)
        }else {
            NSLog("used for stop simulation")
            
        }
    }

    @objc func addOdds() {
        passOdds = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: passOdds) as! [String]

        debugPrint("passOdds :",passOdds)
        odds=SKSpriteNode(imageNamed: passOdds[0])

        odds.size = CGSize(width: 90, height: 90)


        let randomOddsPosition  = GKRandomDistribution(lowestValue: -250, highestValue: 250)
        let possition = CGFloat(randomOddsPosition.nextInt())

        odds.position = CGPoint(x: possition, y: (self.frame.size.height)/4 + odds.size.height+200)
        
        let action = SKAction.moveTo(y: 600, duration: 4.0)
        let actionDone = SKAction.removeFromParent()
        odds.run(SKAction.sequence([action,actionDone]))
        odds.physicsBody = SKPhysicsBody(circleOfRadius: odds.size.width/2)
       // odds.name = passOdds[0]
        
        if(passOdds[0] == "+Blue" || passOdds[0] == "+Red"){
            odds.physicsBody?.categoryBitMask = ColliderType.enemy
        }
        
        if(passOdds[0] == "-Blue" || passOdds[0] == "-Red"){
            odds.physicsBody?.categoryBitMask = ColliderType.enemy2
        }
        
        //odds.physicsBody?.collisionBitMask = ColliderType.player
       // odds.physicsBody?.contactTestBitMask = ColliderType.bullete
        odds.physicsBody?.isDynamic = false
        odds.physicsBody?.affectedByGravity = false
        

        debugPrint(odds)
        
        self.addChild(odds)
        let animationDuration = 5

        var actionArray = [SKAction]()
        actionArray.append(SKAction.move(to: CGPoint(x :possition , y: -odds.size.height-800), duration: TimeInterval(animationDuration)))

        actionArray.append(SKAction.removeFromParent())
        odds.run(SKAction.sequence(actionArray))


    }
    
    
    func setupPhysics(){
        physicsWorld.gravity = CGVector(dx: 0.0, dy: -02.0)
        self.physicsWorld.contactDelegate = self
    }
    
    
    
    func CollisionWithBullet(Enemy : SKSpriteNode,Bullet : SKSpriteNode){
        // NSLog("Hello")
        // debugPrint("hey contact")
        // self.run(SKAction.playSoundFileNamed("torpedo.mp3", waitForCompletion: false))
        
        let explosion = SKEmitterNode(fileNamed: "Explosion")!
        explosion.position = Bullet.position
        self.addChild(explosion)
        self.run(SKAction.playSoundFileNamed("explosion.mp3", waitForCompletion: false))
        
        Enemy.removeFromParent()
        Bullet.removeFromParent()
        
        self.run(SKAction.wait(forDuration: 4)) {
            explosion.removeFromParent()
        }
        
        score += 5
        
        let scoreDefault = UserDefaults.standard
        scoreDefault.setValue(score,forKey:"Score")
        scoreDefault.synchronize()
        
        if(score>highScore){
            let highScoreDefaut = UserDefaults.standard
            highScoreDefaut.setValue(score, forKey: "HighScore")
        }
    }
    
    
    
    func add_Contacto() {
        end = SKSpriteNode()
        end.position = CGPoint(x:0, y:-600)
        end.size = CGSize(width: 1500, height: 20)
        //end.color = UIColor.white
        end.physicsBody = SKPhysicsBody(rectangleOf: end.size)
        end.color = UIColor.brown
        end.physicsBody?.affectedByGravity = false
        end.name = "EndGame"
        end.physicsBody?.categoryBitMask = ColliderType.endContact
        end.physicsBody?.collisionBitMask = ColliderType.enemy | ColliderType.enemy2
        end.physicsBody?.contactTestBitMask = ColliderType.enemy | ColliderType.enemy2
        self.addChild(end)
    }
    
    func collisionWithPlayer(Enemy : SKSpriteNode , Bullet : SKSpriteNode) {
      
       
       // NSLog("Hello from collision with player")
        Enemy.removeFromParent()
        Bullet.removeFromParent()
        self.view?.presentScene(EndScene())
        scoreLa.removeFromParent()
        
    }
    
    func didBegin(_ contact: SKPhysicsContact) {

        NSLog("start did begin")

        
        let firstBody : SKPhysicsBody = contact.bodyA

        let secondBody : SKPhysicsBody = contact.bodyB
        

        if((firstBody.categoryBitMask == ColliderType.enemy) && (secondBody.categoryBitMask == ColliderType.endContact)||(secondBody.categoryBitMask == ColliderType.enemy) && (firstBody.categoryBitMask == ColliderType.endContact)) {
            //print("contact went on what I need")

            collisionWithPlayer(Enemy: firstBody.node as! SKSpriteNode, Bullet: secondBody.node as! SKSpriteNode)
            
        }else if((firstBody.categoryBitMask == ColliderType.enemy) && (secondBody.categoryBitMask == ColliderType.bullete)||(firstBody.categoryBitMask == ColliderType.bullete)&&(secondBody.categoryBitMask == ColliderType.enemy)){
            CollisionWithBullet(Enemy : firstBody.node as! SKSpriteNode,Bullet: secondBody.node as! SKSpriteNode)

        }
        
        
        // Used for the next collision that's way shoold be here
        
        if((firstBody.categoryBitMask == ColliderType.enemy2) && (secondBody.categoryBitMask == ColliderType.endContact)||(secondBody.categoryBitMask == ColliderType.enemy2) && (firstBody.categoryBitMask == ColliderType.endContact)) {
            //print("contact went on what I need")
            
            collisionWithPlayer(Enemy: firstBody.node as! SKSpriteNode, Bullet: secondBody.node as! SKSpriteNode)
            
        }else if((firstBody.categoryBitMask == ColliderType.enemy2) && (secondBody.categoryBitMask == ColliderType.bullete)||(firstBody.categoryBitMask == ColliderType.bullete)&&(secondBody.categoryBitMask == ColliderType.enemy2)){
            CollisionWithBullet(Enemy : firstBody.node as! SKSpriteNode,Bullet: secondBody.node as! SKSpriteNode)
            
        }
        
    }
    

    
//
//        override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//
//            //NSLog("touch over here")
//            for touch in touches {
//
//                let location = touch.location(in: self)
//                ball = SKSpriteNode(imageNamed: "Ball")
//
//                let action = SKAction.moveTo(y: self.size.height + 300, duration: 2.0)
//                let actionDone = SKAction.removeFromParent()
//                ball.run(SKAction.sequence([action,actionDone]))
//                ball.run(SKAction.repeatForever(action))
//                ball.size = CGSize(width: 40, height: 40)
//                ball.position = bubble1.position
//                ball.physicsBody = SKPhysicsBody(circleOfRadius:ball.size.width/2 )
//                ball.physicsBody?.affectedByGravity = false
//                ball.physicsBody?.categoryBitMask = ColliderType.bullete
//                ball.physicsBody?.contactTestBitMask = ColliderType.enemy
//                self.addChild(ball)
//
//
//                var dx = CGFloat(location.x - bubble1.position.x)
//                var dy = CGFloat(location.y - bubble1.position.y + 300)
//
//                let module = sqrt(dx * dx + dy * dy)
//
//
//                dx /= module
//                dy /= module
//
//                let vector = CGVector(dx: dx * 70, dy: dy * 70)
//                ball.physicsBody?.applyImpulse(vector)
//            }
//
//
//        }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        NSLog("attacked with controlle for ever")
        //let action = SKAction.moveTo(y: self.size.height + 400, duration: 3.0)
        //let action = SKAction.move(by: vector, duration: 3.0)
        // touchLocation2 = CGPoint(x:-100,y:-600)


        
        for touch in (touches as! Set<UITouch>) {
            
            bubble1.removeAction(forKey: "TouchPrediction")
//            let location = touch.location(in: self)
//            let make = touches.first!.location(in: bubble1)
//
//            if (types[number] == "+" && bubble1.contains(location)) {
//                bubble1.position.x = location.x
//                bubble1.position.y = location.y
//                let moveAction = SKAction.move(to: location, duration: 1.0)
//               // let actionDone = SKAction.removeFromParent()
//                //bubble1.run(SKAction.sequence([moveAction,actionDone]))
//              //  self.addChild(bubble1)
//                bubble1.run(moveAction)
//            }
            let location = touch.location(in: self)
            if( types[number] == "+" && bubble1.contains(location)) {
                
               
                    let location1 = touch.location(in: self)
                    ball = SKSpriteNode(imageNamed: "Ball")
                
                   ball.position.x = location.x
                    ball.position.y = location.y
                
                
                let vector = CGVector(dx: location.x * 5, dy: -location.y * 5 )
                
                let action1 = SKAction.move(by: vector, duration: 5.0)
                
                let actionDone = SKAction.removeFromParent()
                    ball.size = CGSize(width: 45, height: 45)
                    ball.run(SKAction.sequence([action1,actionDone]))
                    ball.physicsBody = SKPhysicsBody(circleOfRadius:ball.size.width/2 )
                    ball.physicsBody?.applyImpulse(vector)
                    ball.physicsBody?.restitution = 0.0
                    ball.physicsBody?.affectedByGravity = false
                    ball.physicsBody?.categoryBitMask = ColliderType.bullete
                    ball.physicsBody?.contactTestBitMask = ColliderType.enemy
                    self.addChild(ball)
                
               
                }
            
            
            
            if(types[number] == "+" && bubble2.contains(location)) {
//                ball = SKSpriteNode(imageNamed: "Ball")
//         //     ball.anchorPoint = CGPoint(x: 0.5, y: 0.5)
//                ball.position.x = location.x
//                ball.position.y = location.y
//                ball.size = CGSize(width: 45, height: 45)
//              //  ball.run(SKAction.sequence([action,actionDone]))
//                ball.physicsBody = SKPhysicsBody(circleOfRadius:ball.size.width/2 )
//                ball.physicsBody?.affectedByGravity = false
//                ball.physicsBody?.categoryBitMask = ColliderType.bullete
//                ball.physicsBody?.contactTestBitMask = ColliderType.enemy2
//                self.addChild(ball)
                
//                let location1 = touch.location(in: self)
//                ball = SKSpriteNode(imageNamed: "Ball")
//                //   ball.anchorPoint = CGPoint(x: 0.5, y: 0.5)
//
//                ball.position.x = location1.x
//                ball.position.y = location1.y
//                var dx = CGFloat(location.x - bubble1.position.x)
//                var dy = CGFloat(location.y - bubble1.position.y + 500)
//
//                let module = sqrt(dx * dx + dy * dy)
//
//
//                dx /= module
//                dy /= module
//
//                let vector = CGVector(dx: dx * 1000, dy: dy * 1000)
//
//                let action1 = SKAction.move(by: vector, duration: 3.0)
//
//                let actionDone = SKAction.removeFromParent()
//                ball.size = CGSize(width: 45, height: 45)
//                ball.run(SKAction.sequence([action1,actionDone]))
//                ball.physicsBody = SKPhysicsBody(circleOfRadius:ball.size.width/2 )
//                ball.physicsBody?.applyImpulse(vector)
//
//                ball.physicsBody?.affectedByGravity = false
//                ball.physicsBody?.categoryBitMask = ColliderType.bullete
//                ball.physicsBody?.contactTestBitMask = ColliderType.enemy
//                self.addChild(ball)
                debugPrint("consoled here")
            }
            

        }
        
        
        
        
}
    
    
    func addplayer() {
        bubble1 = SKSpriteNode(imageNamed: "positive2")
        debugPrint("x :",self.frame.width/2)
        debugPrint("y :",self.frame.height/2)
        
        bubble1.position = CGPoint(x:100,y:-600)
        debugPrint("frame width ",frame.width)
        debugPrint("frame height ",frame.height)
        
        bubble1.size = CGSize(width: 100, height: 100)
        bubble1.physicsBody = SKPhysicsBody(circleOfRadius: bubble1.size.width/2)
        bubble1.physicsBody?.isDynamic = false
        bubble1.physicsBody?.categoryBitMask = ColliderType.player
        bubble1.physicsBody?.collisionBitMask = ColliderType.enemy
        bubble1.physicsBody?.contactTestBitMask = ColliderType.enemy
        bubble1.name = "positive"
        self.addChild(bubble1)
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    

    
   
}




















 // MARK : - Delegation Extension


//extension GameScene : SKPhysicsContactDelegate {
//
////    func didBegin(_ contact: SKPhysicsContact) {
////        debugPrint("start the begin here")
////        let contactMask = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
////
////        if contactMask == PhysicsCategories.oddsCategory | PhysicsCategories.switchOdds{
////            debugPrint("kontact damn here")
////        }
////    }
//}
//    func touchDown(atPoint pos : CGPoint) {
//        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
//            n.position = pos
//            n.strokeColor = SKColor.green
//            self.addChild(n)
//        }
//    }
//
//    func touchMoved(toPoint pos : CGPoint) {
//        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
//            n.position = pos
//            n.strokeColor = SKColor.blue
//            self.addChild(n)
//        }
//    }
//
//    func touchUp(atPoint pos : CGPoint) {
//        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
//            n.position = pos
//            n.strokeColor = SKColor.red
//            self.addChild(n)
//        }
//    }
//
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        if let label = self.label {
//            label.run(SKAction.init(named: "Pulse")!, withKey: "fadeInOut")
//        }
//
//        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
//    }
//
//    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
//        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
//    }
//
//    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
//        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
//    }
//
//    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
//        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
//    }
//
//    func didBegin(_ contact: SKPhysicsContact) {
//        debugPrint("start begin")
//        var firstBody = SKPhysicsBody()
//        var secondBody = SKPhysicsBody()
//
//        debugPrint("start the begin")
//        if contact.bodyA.node?.name == "player"{
//            firstBody = contact.bodyA
//            secondBody = contact.bodyB
//        }else{
//            firstBody = contact.bodyB
//            secondBody = contact.bodyB
//        }
//
//        if firstBody.node?.name == "player" && secondBody.node?.name == "enemy"{
//
//            print("Contact Deteceted")
//            print("contact between player and enemy")
//        }
//    }



//    func torpedoDidCollideWithAlien (torpedoNode:SKSpriteNode, alienNode:SKSpriteNode) {
//
//        let explosion = SKEmitterNode(fileNamed: "Explosion")!
//        explosion.position = alienNode.position
//        self.addChild(explosion)
//
//        self.run(SKAction.playSoundFileNamed("explosion.mp3", waitForCompletion: false))
//
//        torpedoNode.removeFromParent()
//        alienNode.removeFromParent()
//
//
//        self.run(SKAction.wait(forDuration: 2)) {
//            explosion.removeFromParent()
//        }
//
//        score += 5
//
//
//    }



//           else {
//            NSLog("start else from here")
//            if(contact.bodyA.node?.name == "EndGame"){
//
//                firstbody = contact.bodyA
//                secondbody = contact.bodyB
//
//            }else {
//                firstbody = contact.bodyB
//                secondbody = contact.bodyA
//            }
//            if(firstbody.node?.name == "Enemy" && secondbody.node?.name == "EndGame"){
//                print("contact here what I need")
//
//            }
//        }
//    else if ((firstBody.categoryBitMask == ColliderType.endContact) && (secondBody.categoryBitMask == ColliderType.enemy)||(secondBody.categoryBitMask == ColliderType.endContact) && (firstBody.categoryBitMask == ColliderType.enemy)) {

//            NSLog("Hello from collision with player")
//            Enemy.removeFromParent()
//            odds.removeFromParent()
//            self.view?.presentScene(EndScene())
//            scoreLa.removeFromParent()

//             collisionWithPlayer(Enemy: firstBody.node as! SKSpriteNode, Bullet: secondBody.node as! SKSpriteNode)
//        }
//        else {
//            NSLog("start the else from here")
//            if(contact.bodyA.node?.name == "Enemy"){
//                NSLog("missed")
//                firstbody = contact.bodyA
//                secondbody = contact.bodyB
//
//            }else{
//                firstbody = contact.bodyB
//                secondbody = contact.bodyA
//            }
//
//            if(firstbody.node?.name == "Enemy" && secondbody.node?.name == "EndGame") {
//                print("contact here")
//            }
//        }
