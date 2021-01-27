//
//  ViewController.swift
//  Ikea
//
//  Created by eavictor on 2021/1/14.
//

import ARKit
import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, ARSCNViewDelegate {
    
    @IBOutlet weak var planeDetected: UILabel!
    @IBOutlet weak var sceneView: ARSCNView!
    @IBOutlet weak var itemsCollectionView: UICollectionView!
    
    let configuration = ARWorldTrackingConfiguration()
    
    let itemsArray:[String] = ["cup", "vase", "boxing", "table"]
    var selectedItem:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configuration.planeDetection = .horizontal
        self.sceneView.debugOptions = [ARSCNDebugOptions.showWorldOrigin, ARSCNDebugOptions.showFeaturePoints]
        self.sceneView.delegate = self
        self.sceneView.session.run(configuration)
        self.itemsCollectionView.dataSource = self
        self.itemsCollectionView.delegate = self
        self.registerGestureRecognizers()
    }
    
    func registerGestureRecognizers() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.tapped))
        let pinchGestureRecognizer = UIPinchGestureRecognizer(target: self, action: #selector(self.pinch))
        let longPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(self.longPressToRotate))
        longPressGestureRecognizer.minimumPressDuration = 0.1
        self.sceneView.addGestureRecognizer(tapGestureRecognizer)
        self.sceneView.addGestureRecognizer(pinchGestureRecognizer)
        self.sceneView.addGestureRecognizer(longPressGestureRecognizer)
    }
    
    func centerPivot(for node: SCNNode) {
        let min = node.boundingBox.min
        let max = node.boundingBox.max
        node .pivot = SCNMatrix4MakeTranslation(
            min.x + (max.x - min.x)/2,
            min.y + (max.y - min.y)/2,
            min.z + (max.z - min.z)/2
        )
    }
    
    @objc func longPressToRotate(sender: UILongPressGestureRecognizer) {
        let sceneView = sender.view as! ARSCNView
        let holdLocation = sender.location(in: sceneView)
        let hitTest = sceneView.hitTest(holdLocation)
        if !hitTest.isEmpty {
            let result = hitTest.first!
            let node = result.node
            if sender.state == UILongPressGestureRecognizer.State.began {
                let action = SCNAction.rotateBy(x: 0, y: CGFloat(360.degreeToRadius), z: 0, duration: 1)
                let forever = SCNAction.repeatForever(action)
                node.runAction(forever)
            } else {
                node.removeAllActions()
            }
        }
    }
    
    @objc func pinch(sender: UIPinchGestureRecognizer) {
        let sceneView = sender.view as! ARSCNView
        let pinchLocation = sender.location(in: sceneView)
        let pinchTestResults = sceneView.hitTest(pinchLocation)
        if !pinchTestResults.isEmpty {
            let pinchTestResult = pinchTestResults.first!
            let node = pinchTestResult.node
            let pinchAction = SCNAction.scale(by: sender.scale, duration: 0)
            node.runAction(pinchAction)
            sender.scale = 1.0 // reset scale back to 1.0 to avoid model size blow up
        }
    }
    
    @objc func tapped(sender: UITapGestureRecognizer) {
        let sceneView = sender.view as! ARSCNView
        let tapLocation = sender.location(in: sceneView)
        
        // hitTest is deprecated in iOS 14
        // let hitTest = sceneView.hitTest(tapLocation, types: .existingPlaneUsingExtent)
        
        guard let query = sceneView.raycastQuery(from: tapLocation, allowing: ARRaycastQuery.Target.existingPlaneGeometry, alignment: ARRaycastQuery.TargetAlignment.horizontal) else { return }
        let hitTestResults = sceneView.session.raycast(query)
        if !hitTestResults.isEmpty {
            self.addItem(hitTestResult: hitTestResults.first!)
            print("match")
        } else {
            print("no match")
        }
    }
    
    func addItem(hitTestResult: ARRaycastResult) {
        if let selectedItem = self.selectedItem {
            let scene = SCNScene(named: "Models.scnassets/\(selectedItem).scn")
            let node = scene?.rootNode.childNode(withName: selectedItem, recursively: false)
            let transform = hitTestResult.worldTransform
            let thirdColumn = transform.columns.3
            node?.position = SCNVector3(thirdColumn.x, thirdColumn.y, thirdColumn.z)
            if let node = node {
                if selectedItem == "table" {
                    self.centerPivot(for: node)
                }
                self.sceneView.scene.rootNode.addChildNode(node)
            }
        }
    }
    
    // UICollectionViewDataSouurce functions
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.itemsArray.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "item", for: indexPath) as! ItemCell
        let itemName = self.itemsArray[indexPath.row]
        cell.itemLabel.text = itemName
        return cell
    }
    
    // UICollectionViewDelegate functions
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        self.selectedItem = self.itemsArray[indexPath.row]
        cell?.backgroundColor = UIColor.green
    }
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.backgroundColor = UIColor.systemOrange
    }
    
    // ARSCNViewDelegate functions
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        DispatchQueue.main.async {
            guard anchor is ARPlaneAnchor else { return }
            self.planeDetected.isHidden = false
        }
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
            self.planeDetected.isHidden = true
        }
    }
}

extension Int {
    var degreeToRadius: Double {
        return Double(self) * .pi / 180
    }
}
