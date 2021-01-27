//
//  ViewController.swift
//  ARShooter
//
//  Created by eavictor on 2021/1/26.
//

import ARKit
import UIKit

enum BitMaskCategory: Int {
    case bullet = 2
    case target = 3
}

class ViewController: UIViewController, SCNPhysicsContactDelegate {
    
    let configuration = ARWorldTrackingConfiguration()
    var target: SCNNode?

    @IBOutlet weak var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.handleTap))
        self.sceneView.addGestureRecognizer(tapGestureRecognizer)
        
        self.sceneView.autoenablesDefaultLighting = true
        
        self.sceneView.scene.physicsWorld.contactDelegate = self
        
        self.sceneView.debugOptions = [ARSCNDebugOptions.showWorldOrigin, ARSCNDebugOptions.showFeaturePoints]
        
        self.sceneView.session.run(configuration)
    }
    
    @objc func handleTap(sender: UITapGestureRecognizer) {
        guard let sceneView = sender.view as? ARSCNView else { return }
        guard let pointOfView = sceneView.pointOfView else { return }
        let transform = pointOfView.transform
        let orientation = SCNVector3(-transform.m31, -transform.m32, -transform.m33)
        let location = SCNVector3(transform.m41, transform.m42, transform.m43)
        let position = orientation + location
        let bullet = SCNNode(geometry: SCNSphere(radius: 0.1))
        bullet.geometry?.firstMaterial?.diffuse.contents = UIColor.red
        bullet.position = position
        let body = SCNPhysicsBody(type: .dynamic, shape: SCNPhysicsShape(node: bullet, options: nil))
        body.isAffectedByGravity = false
        bullet.physicsBody = body
        bullet.physicsBody?.categoryBitMask = BitMaskCategory.bullet.rawValue
        bullet.physicsBody?.contactTestBitMask = BitMaskCategory.target.rawValue
        let power: Float = 50
        bullet.physicsBody?.applyForce(SCNVector3(orientation.x * power, orientation.y * power, orientation.z * power), asImpulse: true)
        self.sceneView.scene.rootNode.addChildNode(bullet)
        bullet.runAction(SCNAction.sequence([SCNAction.wait(duration: 2), SCNAction.removeFromParentNode()]))
    }
    
    @IBAction func addTargets(_ sender: UIButton) {
        self.addEgg(x: 5, y: 0, z: -40)
        self.addEgg(x: 0, y: 0, z: -40)
        self.addEgg(x: -5, y: 0, z: -40)
    }
    
    func addEgg(x: Float, y: Float, z: Float) {
        guard let eggScene = SCNScene(named: "Media.scnassets/egg.scn") else { return }
        guard let eggNode = eggScene.rootNode.childNode(withName: "egg", recursively: false) else { return }
        eggNode.position = SCNVector3(x, y, z)
        eggNode.physicsBody = SCNPhysicsBody(type: SCNPhysicsBodyType.static, shape: SCNPhysicsShape(node: eggNode, options: nil))
        eggNode.physicsBody?.categoryBitMask = BitMaskCategory.target.rawValue
        eggNode.physicsBody?.contactTestBitMask = BitMaskCategory.bullet.rawValue
        self.sceneView.scene.rootNode.addChildNode(eggNode)
    }

    func physicsWorld(_ world: SCNPhysicsWorld, didBegin contact: SCNPhysicsContact) {
        let nodeA = contact.nodeA
        let nodeB = contact.nodeB
        if nodeA.physicsBody?.categoryBitMask == BitMaskCategory.target.rawValue {
            self.target = nodeA
        } else if nodeB.physicsBody?.categoryBitMask == BitMaskCategory.target.rawValue {
            self.target = nodeB
        }
        
        if let confetti = SCNParticleSystem(named: "Media.scnassets/Confetti.scnp", inDirectory: nil) {
            confetti.loops = false
            confetti.particleLifeSpan = 4
            confetti.emitterShape = self.target?.geometry
            let confettiNode = SCNNode()
            confettiNode.addParticleSystem(confetti)
//            confettiNode.position = contact.contactPoint
            confettiNode.position = self.target!.position
            self.target?.removeFromParentNode()
            self.sceneView.scene.rootNode.addChildNode(confettiNode)
        }
    }

}

func +(left: SCNVector3, right: SCNVector3) -> SCNVector3 {
    return SCNVector3Make(left.x + right.x, left.y + right.y, left.z + right.z)
}
