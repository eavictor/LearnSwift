//
//  ViewController.swift
//  AR-Hoops
//
//  Created by eavictor on 2021/1/25.
//

import ARKit
import UIKit
import Each

class ViewController: UIViewController, ARSCNViewDelegate {
    
    let configuration = ARWorldTrackingConfiguration()

    @IBOutlet weak var planeDetected: UILabel!
    @IBOutlet weak var sceneView: ARSCNView!
    
    let timer = Each(0.05).seconds
    var power: Float = 1
    var basketAdded: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.handleTap))
        tapGestureRecognizer.cancelsTouchesInView = false
        self.sceneView.addGestureRecognizer(tapGestureRecognizer)
        
        self.configuration.planeDetection = .horizontal
        
        self.sceneView.delegate = self
        self.sceneView.debugOptions = [ARSCNDebugOptions.showWorldOrigin, ARSCNDebugOptions.showFeaturePoints]
        self.sceneView.autoenablesDefaultLighting = true
        self.sceneView.session.run(configuration)
    }
    
    @objc func handleTap(sender: UITapGestureRecognizer) {
        guard let sceneView = sender.view as? ARSCNView else { return }
        let location = sender.location(in: sceneView)
        guard let query = sceneView.raycastQuery(from: location, allowing: ARRaycastQuery.Target.existingPlaneGeometry, alignment: ARRaycastQuery.TargetAlignment.horizontal) else { return }
        let raycastResults = sceneView.session.raycast(query)
        if !raycastResults.isEmpty {
            let raycastResult = raycastResults.first
            let transform = raycastResult!.worldTransform
            let position = SCNVector3(transform.columns.3.x, transform.columns.3.y, transform.columns.3.z)
            self.addBasket(position: position)
        }
    }
    
    func addBasket(position: SCNVector3) {
        if !self.basketAdded {
            let basketScene = SCNScene(named: "Basketball.scnassets/Basket.scn")
            let basketNode = basketScene?.rootNode.childNode(withName: "Basket", recursively: false)
            basketNode?.position = position
            basketNode?.physicsBody = SCNPhysicsBody(type: SCNPhysicsBodyType.static, shape: SCNPhysicsShape(node: basketNode!, options: [SCNPhysicsShape.Option.keepAsCompound: true, SCNPhysicsShape.Option.type: SCNPhysicsShape.ShapeType.concavePolyhedron]))
            self.sceneView.scene.rootNode.addChildNode(basketNode!)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                self.basketAdded = true
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if self.basketAdded {
            self.timer.perform { () -> NextStep in
                if self.power < 20.0 {
                    self.power += 1.0
                }
                return NextStep.continue
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if self.basketAdded {
            self.timer.stop()
            self.shootBall()
            self.power = 1
        }
    }
    
    func shootBall() {
        self.removeEveryOtherBalls()
        guard let pointOfView = self.sceneView.pointOfView else { return }
        let transform = pointOfView.transform
        let location = SCNVector3(transform.m41, transform.m42, transform.m43)
        let orientation = SCNVector3(-transform.m31, -transform.m32, -transform.m33)
        let position = location + orientation
        
        let ball = SCNNode(geometry: SCNSphere(radius: 0.2))
        ball.geometry?.firstMaterial?.diffuse.contents = UIImage(named: "ball")
        ball.position = position
        ball.name = "Basketball"
        let body = SCNPhysicsBody(type: SCNPhysicsBodyType.dynamic, shape: SCNPhysicsShape(node: ball))
        body.restitution = 0.2
        ball.physicsBody = body
        ball.physicsBody?.applyForce(SCNVector3(orientation.x * self.power, orientation.y * self.power, orientation.z * self.power), asImpulse: true)
        self.sceneView.scene.rootNode.addChildNode(ball)
    }
    
    func removeEveryOtherBalls() {
        self.sceneView.scene.rootNode.enumerateChildNodes { (node, _) in
            if node.name == "Basketball" {
                node.removeFromParentNode()
            }
        }
    }

    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        guard anchor is ARPlaneAnchor else { return }
        DispatchQueue.main.async {
            self.planeDetected.isHidden = false
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.planeDetected.isHidden = true
        }
    }
    
    deinit {
        self.timer.stop()
    }

}


func +(left: SCNVector3, right:SCNVector3) -> SCNVector3 {
    return SCNVector3Make(left.x + right.x, left.y + right.y, left.z + right.z)
}
