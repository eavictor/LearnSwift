//
//  ViewController.swift
//  AR-Portal
//
//  Created by eavictor on 2021/1/21.
//

import ARKit
import UIKit

class ViewController: UIViewController, ARSCNViewDelegate {

    let configuration = ARWorldTrackingConfiguration()
    @IBOutlet weak var sceneView: ARSCNView!
    @IBOutlet weak var planeDetected: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configuration.planeDetection = .horizontal
        self.sceneView.debugOptions = [ARSCNDebugOptions.showWorldOrigin, ARSCNDebugOptions.showFeaturePoints]
        self.sceneView.autoenablesDefaultLighting = true
        self.sceneView.delegate = self
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.handleTap))
        self.sceneView.addGestureRecognizer(tapGestureRecognizer)
        self.sceneView.session.run(configuration)
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
    
    @objc func handleTap(sender: UITapGestureRecognizer) {
        guard let sceneView = sender.view as? ARSCNView else { return }
        let touchLocation = sender.location(in: sceneView)
        guard let query = sceneView.raycastQuery(from: touchLocation, allowing: ARRaycastQuery.Target.existingPlaneGeometry, alignment: ARRaycastQuery.TargetAlignment.horizontal) else { return }
        let raycastResults = sceneView.session.raycast(query)
        if !raycastResults.isEmpty {
            let raycastResult = raycastResults.first
            let transform = raycastResult!.worldTransform
            let position = SCNVector3(transform.columns.3.x, transform.columns.3.y, transform.columns.3.z)
            self.addPortal(position: position)
        }
    }
    
    func addPortal(position: SCNVector3) {
        let portalScene = SCNScene(named: "Portal.scnassets/Portal.scn")
        guard let portalNode = portalScene?.rootNode.childNode(withName: "portal", recursively: false) else { return }
        portalNode.position = position
        self.addPlane(nodeName: "roof", portalNode: portalNode, imageName: "top")
        self.addPlane(nodeName: "floor", portalNode: portalNode, imageName: "bottom")
        self.addWall(nodeName: "leftWall", portalNode: portalNode, imageName: "sideB")
        self.addWall(nodeName: "rightWall", portalNode: portalNode, imageName: "sideA")
        self.addWall(nodeName: "backWall", portalNode: portalNode, imageName: "back")
        self.addWall(nodeName: "sideDoorLeft", portalNode: portalNode, imageName: "sideDoorB")
        self.addWall(nodeName: "sideDoorRight", portalNode: portalNode, imageName: "sideDoorA")
        DispatchQueue.main.async {
            self.sceneView.scene.rootNode.enumerateChildNodes { (node, _) in
                node.removeFromParentNode()
            }
            self.sceneView.scene.rootNode.addChildNode(portalNode)
        }
    }
    
    func addPlane(nodeName: String, portalNode: SCNNode, imageName: String) {
        let child = portalNode.childNode(withName: nodeName, recursively: true)
        child?.geometry?.firstMaterial?.diffuse.contents = UIImage(named: "Portal.scnassets/\(imageName).png")
        child?.renderingOrder = 200
    }
    
    func addWall(nodeName: String, portalNode: SCNNode, imageName: String) {
        let child = portalNode.childNode(withName: nodeName, recursively: true)
        child?.geometry?.firstMaterial?.diffuse.contents = UIImage(named: "Portal.scnassets/\(imageName).png")
        child?.renderingOrder = 200
        if let mask = child?.childNode(withName: "mask", recursively: false) {
            mask.geometry?.firstMaterial?.transparency = 0.000001
        }
    }
}
