//
//  GameScene.swift
//  PingpongKnight
//
//  Created by YashimaMasafumi on 2021/05/09.
//

import SpriteKit

class GameScene: SKScene,SKPhysicsContactDelegate {
    //ゲームオーバーフラグ
    var gameoverFlg = false
    //ポイント
    var count:NSInteger = 0
    //ラベル
    let gameoverLabel = SKLabelNode(fontNamed: "Hiragino Kaku Gothic ProN")//ゲームオーバーを表示するラベル
    let pointLabel = SKLabelNode(fontNamed: "Hiragino Kaku Gothic ProN")//得点を表示するラベル
    
    //オブジェクト
    var ball = SKSpriteNode(imageNamed: "ball")
    var armRight = SKSpriteNode(imageNamed: "rightarm")
    var armLeft = SKSpriteNode(imageNamed: "leftarm")
    var back = SKSpriteNode(imageNamed: "back")
    var wallRight = SKSpriteNode(imageNamed: "wallright")
    var wallLeft = SKSpriteNode(imageNamed: "wallleft")
    var triangleRight = SKSpriteNode(imageNamed: "triangleright")
    var triangleLeft = SKSpriteNode(imageNamed: "triangleleft")
    var monster1 = SKSpriteNode(imageNamed: "monster1a")
    var monster2 = SKSpriteNode(imageNamed: "monster2a")
    var monster3 = SKSpriteNode(imageNamed: "monster3a")
    let playSound = SKAction.playSoundFileNamed("click.mp3", waitForCompletion: false)
    
    override func didMove(to view: SKView) {
        //背景
        back.position = CGPoint(x: self.frame.size.width/2, y: self.frame.size.height/2)
        back.size = self.size
        back.zPosition = -100
        self.addChild(back)
        //重力の設定とcontactDelegateの設定
        self.physicsWorld.gravity = CGVector(dx: 0, dy: -3)
        self.physicsWorld.contactDelegate = self
        
        //ボールの作成
        makeBall()
        //壁の作成
        setwall()
        //アームの作成
        setarm()
    }
    
    //タップ開始時
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let swingAction1 = SKAction.rotate(byAngle: CGFloat(Double.pi*0.25), duration: 0.05)
        let swingAction2 = SKAction.rotate(byAngle: CGFloat(-Double.pi*0.25), duration: 0.05)
        armLeft.run(swingAction1)
        armRight.run(swingAction2)
    }
    
    //タップ終了時
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let swingAction1 = SKAction.rotate(byAngle: CGFloat(-Double.pi*0.25), duration: 0.05)
        let swingAction2 = SKAction.rotate(byAngle: CGFloat(Double.pi*0.25), duration: 0.05)
        armLeft.run(swingAction1)
        armRight.run(swingAction2)
    }
    
    //ボール（勇者）の作成
    func makeBall() {
        //ボールにphysicsBodyの設定
        ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.size.width*0.4)
        ball.physicsBody?.contactTestBitMask = 1
        
        //ボールを配置
        ball.position = CGPoint(x: self.frame.size.width*0.5, y: 500)
        self.addChild(ball)
    }
    
    //壁の作成
    func setwall() {
        //画像の縮尺
        let magnification = self.frame.size.height/wallLeft.size.height
        wallLeft.size.height = self.frame.size.height
        wallLeft.size.width = wallLeft.size.width*magnification
        wallLeft.physicsBody = SKPhysicsBody(texture: SKTexture(imageNamed: "wallleft"), size: wallLeft.size)
        wallLeft.physicsBody?.restitution = 0.1//restitution coefficient:反発係数
        wallLeft.physicsBody?.isDynamic = false
        wallLeft.physicsBody?.contactTestBitMask = 1
        wallLeft.position = CGPoint(x: wallLeft.size.width/2, y: self.frame.size.height/2)
        self.addChild(wallLeft)
        
//        magnification = self.frame.size.height/wallRight.size.height
        wallRight.size.height = self.frame.size.height
        wallRight.size.width = wallRight.size.width*magnification
        wallRight.physicsBody = SKPhysicsBody(texture: SKTexture(imageNamed: "wallright"), size: wallRight.size)
        wallRight.physicsBody?.restitution = 0.1//restitution coefficient:反発係数
        wallRight.physicsBody?.isDynamic = false
        wallRight.physicsBody?.contactTestBitMask = 1
        wallRight.position = CGPoint(x: self.frame.size.width - wallRight.size.width/2, y: self.frame.size.height/2)
        self.addChild(wallRight)
    }
    
    //アームの作成
    func setarm() {
        //画像の縮尺
        let magnification = self.frame.size.height/wallLeft.size.height*1.5
        armLeft.size.height = armLeft.size.height*magnification
        armLeft.size.width = armLeft.size.width*magnification
        armLeft.physicsBody = SKPhysicsBody(texture: SKTexture(imageNamed: "leftarm"), size: armLeft.size)
        armLeft.physicsBody?.restitution = 1.2
        armLeft.physicsBody?.isDynamic = false
        armLeft.physicsBody?.contactTestBitMask = 1
        armLeft.position = CGPoint(x: self.frame.size.width/2 - armLeft.size.width*0.6, y: 100)
        self.addChild(armLeft)
        
        armRight.size.height = armRight.size.height*magnification
        armRight.size.width = armRight.size.width*magnification
        armRight.physicsBody = SKPhysicsBody(texture: SKTexture(imageNamed: "rightarm"), size: armRight.size)
        armRight.physicsBody?.restitution = 1.2
        armRight.physicsBody?.isDynamic = false
        armRight.physicsBody?.contactTestBitMask = 1
        armRight.position = CGPoint(x: self.frame.size.width/2 + armRight.size.width*0.6, y: 100)
        self.addChild(armRight)
    }
}
