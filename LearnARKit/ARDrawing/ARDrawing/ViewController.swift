//
//  ViewController.swift
//  ARDrawing
//
//  Created by eavictor on 2021/1/6.
//

import UIKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {
    
    let configuration = ARWorldTrackingConfiguration()
    
    @IBOutlet weak var sceneView: ARSCNView!
    @IBOutlet weak var draw: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.sceneView.debugOptions = [ARSCNDebugOptions.showWorldOrigin, ARSCNDebugOptions.showFeaturePoints]
        self.sceneView.showsStatistics = true
        self.sceneView.session.run(configuration)
        self.sceneView.delegate = self
        // Do any additional setup after loading the view.
    }

    // ARSCNViewDelegate function, consider move to another class
    func renderer(_ renderer: SCNSceneRenderer, willRenderScene scene: SCNScene, atTime time: TimeInterval) {
        guard let pointOfView = self.sceneView.pointOfView else { return }
        let transform = pointOfView.transform
        let orientation = SCNVector3(-transform.m31, -transform.m32, -transform.m33)
        let location = SCNVector3(transform.m41, transform.m42, transform.m43)
        let currentPositionOfCamera = SCNVector3(orientation.x + location.x, orientation.y + location.y, orientation.z + location.z)
        DispatchQueue.main.async {
            if self.draw.isHighlighted {
                let sphereNode = SCNNode(geometry: SCNSphere(radius: 0.03))
                sphereNode.position = currentPositionOfCamera
                sphereNode.geometry?.firstMaterial?.diffuse.contents = UIColor.red
    //            sphereNode.geometry?.firstMaterial?.specular.contents = UIColor.white
                self.sceneView.scene.rootNode.addChildNode(sphereNode)
            } else {
                self.sceneView.scene.rootNode.enumerateChildNodes { (node, _) in
                    if node.name == "pointer" {
                        node.removeFromParentNode()
                    }
                }
                let pointer = SCNNode(geometry: SCNSphere(radius: 0.01))
                pointer.position = currentPositionOfCamera
                pointer.name = "pointer"
                pointer.geometry?.firstMaterial?.diffuse.contents = UIColor.red
                self.sceneView.scene.rootNode.addChildNode(pointer)
            }
        }
    }
}

//func +(left: SCNVector3, right: SCNVector3) -> SCNVector3 {
//    return SCNVector3Make(left.x + right.x, left.y + right.y, left.z + right.z)
//}
