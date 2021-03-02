# Pachinko

### SpriteKit
- [Apple Documentation](https://developer.apple.com/spritekit/)
- supports OpenGL ES shaders and lighting
- integrates with SceneKit
- physics effects and animations
- force fields, detect collisions, and generate lighting effects

### Simulator
- shows amount of nodes
- shows frames per second
  
### GameScene.swift
- `GameScene` is subclas of `SKScene`
- remove everything except `didMove()` definition
  
### GameScene.sks
- working with `sks` files
- 0.5,0.5 coordinate is right in the middle
  - (UIKit it would be top left corner)
  - set to 0, 0 (will be bottom left)
  - width 1024, height 768

### Actions.sks
- deals with scaling, fades, etc.
- usually easier just to do in code

### Assets.xcassets
- drag all content pictures into here

### GameScene
```swift
let background = SKSpriteNode(imageNamed: "background")
background.position = CGPoint(x: 512, y: 384)
background.blendMode = .replace
background.zPosition = -1
addChild(background)
```

- `blendMode = .replace`
  - draw ignoring any alpha values
  - fast and good for background
- `zPosition` 
  - draw behind everything of higher value


### GameScene
`touchesBegan`
  - `touches.first` 
    - grabs the first touch
  - `touch.location(in: self)`
    - find where touch was in whole of game scene
  - `SKSpriteNode`
    - create a node and set color and size
  - `physicsBody`
    - set the physics body tupe of node
  - `position`
    - set node location
  - `addChild`
    - add node to scene

- `didMove`
  - 