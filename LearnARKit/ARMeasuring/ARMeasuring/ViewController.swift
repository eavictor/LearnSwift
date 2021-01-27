//
//  ViewController.swift
//  ARMeasuring
//
//  Created by eavictor on 2021/1/21.
//

import ARKit
import UIKit
import Foundation

class ViewController: UIViewController, ARSCNViewDelegate {
    
    let configuration = ARWorldTrackingConfiguration()
    
    @IBOutlet weak var sceneView: ARSCNView!
    
    @IBOutlet weak var distance: UILabel!
    @IBOutlet weak var xLabel: UILabel!
    @IBOutlet weak var yLabel: UILabel!
    @IBOutlet weak var zLabel: UILabel!
    
    var startingPosition: SCNNode?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.sceneView.debugOptions = [ARSCNDebugOptions.showWorldOrigin, ARSCNDebugOptions.showFeaturePoints]
        self.sceneView.delegate = self
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.handleTap))
        self.sceneView.addGestureRecognizer(tapGestureRecognizer)
        self.sceneView.session.run(configuration)
    }
    
    @objc func handleTap(sender: UITapGestureRecognizer) {
        // 1. If already measuring, tap again to stop measurement
        if self.startingPosition != nil {
            self.startingPosition?.removeFromParentNode()
            self.startingPosition = nil
            return
        }
        // 2. Setup new measurement starting point
        guard let sceneView = sender.view as? ARSCNView else { return }
        guard let currentFrame = sceneView.session.currentFrame else { return }
        let camera = currentFrame.camera
        let transform = camera.transform
        var translationMatrix = matrix_identity_float4x4
        translationMatrix.columns.3.z = -0.1
        let modifiedMatrix = simd_mul(transform, translationMatrix)
        let sphere = SCNNode(geometry: SCNSphere(radius: 0.005))
        sphere.geometry?.firstMaterial?.diffuse.contents = UIColor.yellow
        sphere.simdTransform = modifiedMatrix
        
        // 3. Put node to variable as origin point (node.position)
        self.startingPosition = sphere
        
        // 4. Show new origin node in AR world
        self.sceneView.scene.rootNode.addChildNode(sphere)
    }

    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        guard let startingPosition = self.startingPosition else { return }
        guard let pointOfView = self.sceneView.pointOfView else { return }
        let transform = pointOfView.transform
        let location = SCNVector3(transform.m41, transform.m42, transform.m43)
        let xDistance = location.x - startingPosition.position.x
        let yDistance = location.y - startingPosition.position.y
        let zDistance = location.z - startingPosition.position.z
        let dist = sqrt(pow(xDistance, 2) + pow(yDistance, 2) + pow(zDistance, 2))
        DispatchQueue.main.async {
            self.distance.text = String(format: "Distance: %.2f", dist)
            self.xLabel.text = String(format: "X: %.2f", xDistance)
            self.yLabel.text = String(format: "Y: %.2f", yDistance)
            self.zLabel.text = String(format: "Z: %.2f", zDistance)
        }
    }
}

