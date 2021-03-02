//
//  GameScene.swift
//  Project11
//
//  Created by Jonathan Gentry on 3/1/21.
//

import SpriteKit

class GameScene: SKScene {
    
    override func didMove(to view: SKView) {
      let background = SKSpriteNode(imageNamed: "background")
      background.position = CGPoint(x: 512, y: 384)
      background.blendMode = .replace
      background.zPosition = -1
      addChild(background)
      
      // comes from SKScene, physics body for whole scene
      physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
    }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    
    // this will grab the first touch or return
    guard let touch = touches.first else { return }
    
    // find touch location in whole of game scene
    let location = touch.location(in: self)
    
    // create a node and set color & size
    let box = SKSpriteNode(color: .red, size: CGSize(width: 64, height: 64))
    
    // set physics body to be rectangle like node and set location to touch location
    box.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 64, height: 64))
    box.position = location
    
    // add node to scene
    addChild(box)
  }
    
}
