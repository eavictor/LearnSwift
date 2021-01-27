//
//  ViewController.swift
//  WorldTracking
//
//  Created by eavictor on 2021/1/1.
//

import UIKit
import ARKit

class ViewController: UIViewController {

    @IBOutlet weak var sceneView: ARSCNView!
    
    let configuration = ARWorldTrackingConfiguration()
    // let faceTrackingConfiguration = ARFaceTrackingConfiguration()
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Debug Options
        self.sceneView.debugOptions = [
            ARSCNDebugOptions.showFeaturePoints, // Show if feature points are constantly being discovered.
            ARSCNDebugOptions.showWorldOrigin // Show world origin is properly detected.
            // World origin is your starting position in the real world.
            // As soon as you launch the app, world trackiing detects everything in your environment and keeps track of where you started.
        ]
        self.sceneView.autoenablesDefaultLighting = true
        self.sceneView.session.run(configuration)
    }
    
    @IBAction func add(_ sender: UIButton) {
        let boxNode = SCNNode(geometry: SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0))
        boxNode.geometry?.firstMaterial?.diffuse.contents = UIColor.blue
        boxNode.geometry?.firstMaterial?.specular.contents = UIColor.white
        let pyramidNode = SCNNode(geometry: SCNPyramid(width: 0.1, height: 0.05, length: 0.1))
        pyramidNode.geometry?.firstMaterial?.diffuse.contents = UIColor.blue
        pyramidNode.geometry?.firstMaterial?.specular.contents = UIColor.white
        let doorNode = SCNNode(geometry: SCNPlane(width: 0.02, height: 0.05))
        doorNode.geometry?.firstMaterial?.diffuse.contents = UIColor.yellow
        doorNode.geometry?.firstMaterial?.specular.contents = UIColor.white

        pyramidNode.position = SCNVector3(0, 0, 0)
        boxNode.position = SCNVector3(0, -0.05, 0)
        doorNode.position = SCNVector3(0, -0.025, 0.051)
        
        pyramidNode.eulerAngles = SCNVector3(180.degreeToRadian, 0, 0)

        pyramidNode.addChildNode(boxNode)
        boxNode.addChildNode(doorNode)
        self.sceneView.scene.rootNode.addChildNode(pyramidNode)
    }
    
    @IBAction func reset(_ sender: UIButton) {
        self.restartSession()
    }
    
    func removeChildNode(thisNode:SCNNode, unsafeMutablePointer:UnsafeMutablePointer<ObjCBool>) {
        thisNode.removeFromParentNode()
    }

    func restartSession() {
        self.sceneView.session.pause()
        self.sceneView.scene.rootNode.enumerateChildNodes(self.removeChildNode)
        self.sceneView.session.run(configuration, options: [ARSession.RunOptions.resetTracking, ARSession.RunOptions.removeExistingAnchors])
    }
    
//    func randomNumbers(firstNum:CGFloat, secondNum:CGFloat) -> CGFloat {
//        return CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(firstNum - secondNum) + min(firstNum, secondNum)
//    }
    
}

// Add an extension to Int type
extension Int {
    var degreeToRadian:Float {
        return Float(self) * .pi/180
    }
}
