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
    
    //画像の縮尺
    var magnification :CGFloat = 0.0
    
    override func didMove(to view: SKView) {
        //背景
        back.position = CGPoint(x: self.frame.size.width/2, y: self.frame.size.height/2)
        back.size = self.size
        back.zPosition = -100
        self.addChild(back)
        //重力の設定とcontactDelegateの設定
        self.physicsWorld.gravity = CGVector(dx: 0, dy: -3)
        self.physicsWorld.contactDelegate = self
        
        magnification = self.frame.size.height/wallLeft.size.height
        
        //ボールの作成
        makeBall()
        //壁の作成
        setwall()
        //アームの作成
        setarm()
        //敵の作成
        setKinoko()
        setDragon()
        setSlime()
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
        wallLeft.size.height = self.frame.size.height
        wallLeft.size.width = wallLeft.size.width*magnification
        wallLeft.physicsBody = SKPhysicsBody(texture: SKTexture(imageNamed: "wallleft"), size: wallLeft.size)
        wallLeft.physicsBody?.restitution = 0.1//restitution coefficient:反発係数
        wallLeft.physicsBody?.isDynamic = false
        wallLeft.physicsBody?.contactTestBitMask = 1
        wallLeft.position = CGPoint(x: wallLeft.size.width/2, y: self.frame.size.height/2)
        self.addChild(wallLeft)
        
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
        armLeft.size.height = armLeft.size.height*magnification
        armLeft.size.width = armLeft.size.width*magnification
        armLeft.physicsBody = SKPhysicsBody(texture: SKTexture(imageNamed: "leftarm"), size: armLeft.size)
        armLeft.physicsBody?.restitution = 1.5
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
    
    //敵１（キノコ）
    func setKinoko() {
        monster1.name = "monster1"//衝突判定に使用
//        monster1.size.width = monster1.size.width
//        monster1.size.height = monster1.size.height
        monster1.physicsBody = SKPhysicsBody(texture: SKTexture(imageNamed: "monster1a"), size: monster1.size)
        monster1.physicsBody?.restitution = 1.3
        monster1.physicsBody?.isDynamic = false
        monster1.physicsBody?.contactTestBitMask = 1
        monster1.position = CGPoint(x: self.frame.width/2 + monster1.size.width, y: self.frame.height*2/3 + monster1.size.height)
        self.addChild(monster1)
        //拡大縮小アニメーション
        let scaleA = SKAction.scale(to: 0.8, duration: 0.5)
        let scaleB = SKAction.scale(to: 1.2, duration: 1.5)
        let scaleSequence = SKAction.sequence([scaleA,scaleB])
        let scalerepeatAction = SKAction.repeatForever(scaleSequence)
        monster1.run(scalerepeatAction)
        //パラパラアニメーション
        let paraparaAction1 = SKAction.animate(withNormalTextures: [SKTexture(imageNamed: "monster1a"),SKTexture(imageNamed: "monster1b")], timePerFrame: 0.5)
        let repeatparaparaAction1 = SKAction.repeatForever(paraparaAction1)
        monster1.run(repeatparaparaAction1)
    }
    
    //敵２（ドラゴン）
    func setDragon() {
        monster2.name = "monster2"
//        monster2.size.width = monster2.size.width
//        monster2.size.height = monster2.size.height
        monster2.physicsBody = SKPhysicsBody(texture: SKTexture(imageNamed: "monster2a"), size: monster2.size)
        monster2.physicsBody?.restitution = 1.3
        monster2.physicsBody?.isDynamic = false
        monster2.physicsBody?.contactTestBitMask = 1
        monster2.position = CGPoint(x: self.frame.size.width/2 - monster2.size.width, y: self.frame.size.height/2)
        self.addChild(monster2)
        //移動アニメーション
        let moveA = SKAction.move(to: CGPoint(x: monster2.size.width*3, y: self.frame.size.height/2), duration: 1)
        let moveB = SKAction.move(to: CGPoint(x: self.frame.size.width/2 - monster2.size.width, y: self.frame.size.height/2), duration: 1)
        let moveSequence = SKAction.sequence([moveA,moveB])
        let moveRepeatAction = SKAction.repeatForever(moveSequence)
        monster2.run(moveRepeatAction)
        //パラパラアニメーション
        let paraparaAction2 = SKAction.animate(withNormalTextures: [SKTexture(imageNamed: "monster2a"),SKTexture(imageNamed: "monster2b")], timePerFrame: 0.5)
        let repeatparaparaAction2 = SKAction.repeatForever(paraparaAction2)
        monster2.run(repeatparaparaAction2)
    }
    
    //敵３（スライム）
    func setSlime() {
        monster3.name = "monster3"
//        monster3.size.width = monster3.size.width
//        monster3.size.height = monster3.size.height
        monster3.physicsBody = SKPhysicsBody(texture: SKTexture(imageNamed: "monster3a"), size: monster3.size)
        monster3.physicsBody?.restitution = 1.3
        monster3.physicsBody?.isDynamic = false
        monster3.physicsBody?.contactTestBitMask = 1
        monster3.position = CGPoint(x: monster3.size.width*2, y: monster3.size.height*5)
        self.addChild(monster3)
        //回転アニメーション
        let rotateAction = SKAction.rotate(byAngle: CGFloat(2*Double.pi), duration: 3)
        let rotateRepeatAction = SKAction.repeatForever(rotateAction)
        monster3.run(rotateRepeatAction)
        //パラパラアニメーション
        let paraparaAction3 = SKAction.animate(withNormalTextures: [SKTexture(imageNamed: "monster3a"),SKTexture(imageNamed: "monster3b")], timePerFrame: 0.5)
        let repeatparaparaAction3 = SKAction.repeatForever(paraparaAction3)
        monster3.run(repeatparaparaAction3)
    }
}
