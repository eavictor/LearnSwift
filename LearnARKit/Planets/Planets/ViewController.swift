//
//  ViewController.swift
//  Planets
//
//  Created by eavictor on 2021/1/7.
//

import UIKit
import ARKit

class ViewController: UIViewController {
    
    let configuration = ARWorldTrackingConfiguration()

    @IBOutlet weak var sceneView: ARSCNView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.sceneView.debugOptions = [ARSCNDebugOptions.showWorldOrigin, ARSCNDebugOptions.showFeaturePoints]
        self.sceneView.autoenablesDefaultLighting = true
        self.sceneView.session.run(configuration)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let sun = planet(
            geometry: SCNSphere(radius: 0.35),
            diffuse: UIImage(named: "SunDiffuse"),
            specular: nil,
            emission: nil,
            normal: nil,
            position: SCNVector3(0, 0, -1)
        )
        sun.runAction(self.rotation(time: 8))
        
        let earthParent = SCNNode()
        earthParent.position = SCNVector3(0, 0, -1)
        earthParent.runAction(self.rotation(time: 8))

        let earth = planet(
            geometry: SCNSphere(radius: 0.2),
            diffuse: UIImage(named: "EarthDay"),
            specular: UIImage(named: "EarthSpecular"),
            emission: UIImage(named: "EarthEmission"),
            normal: UIImage(named: "EarthNormal"),
            position: SCNVector3(1.2, 0, 0)
        )
        earth.runAction(self.rotation(time: 14))
        earthParent.addChildNode(earth)
        
        let moonEarthParent = SCNNode()
        moonEarthParent.position = SCNVector3(1.2, 0, 0)
        moonEarthParent.runAction(self.rotation(time: 2))
        earthParent.addChildNode(moonEarthParent)
        
        let moonEarth = planet(
            geometry: SCNSphere(radius: 0.02),
            diffuse: UIImage(named: "MoonDiffuse"),
            specular: nil,
            emission: nil,
            normal: nil,
            position: SCNVector3(0.3, 0, 0))
        moonEarth.runAction(self.rotation(time: 4))
        moonEarthParent.addChildNode(moonEarth)
        
        let venusParent = SCNNode()
        venusParent.position = SCNVector3(0, 0, -1)
        venusParent.runAction(self.rotation(time: 10))
        
        let venus = planet(
            geometry: SCNSphere(radius: 0.1),
            diffuse: UIImage(named: "VenusSurface"),
            specular: nil,
            emission: nil,
            normal: UIImage(named: "VenusAtomsphere"),
            position: SCNVector3(0.7, 0, 0)
        )
        venus.runAction(self.rotation(time: 16))
        venusParent.addChildNode(venus)
        
        let moonVenusParent = SCNNode()
        moonVenusParent.position = SCNVector3(0.7, 0, 0)
        moonVenusParent.runAction(self.rotation(time: 4))
        venusParent.addChildNode(moonVenusParent)
        
        let moonVenus = planet(
            geometry: SCNSphere(radius: 0.02),
            diffuse: UIImage(named: "MoonDiffuse"),
            specular: nil,
            emission: nil,
            normal: nil,
            position: SCNVector3(0.2, 0, 0))
        moonVenus.runAction(self.rotation(time: 8))
        moonVenusParent.addChildNode(moonVenus)
        
        self.sceneView.scene.rootNode.addChildNode(sun)
        self.sceneView.scene.rootNode.addChildNode(earthParent)
        self.sceneView.scene.rootNode.addChildNode(venusParent)
    }
    
    func planet(geometry:SCNGeometry, diffuse:UIImage?, specular:UIImage?, emission:UIImage?, normal:UIImage?, position:SCNVector3) -> SCNNode {
        let node = SCNNode()
        node.geometry = geometry
        node.geometry?.firstMaterial?.diffuse.contents = diffuse
        node.geometry?.firstMaterial?.specular.contents = specular
        node.geometry?.firstMaterial?.emission.contents = emission
        node.geometry?.firstMaterial?.normal.contents = normal
        node.position = position
        return node
    }
    
    func rotation(time:TimeInterval) -> SCNAction {
        let rotation = SCNAction.rotateBy(x: 0, y: CGFloat(360.degreeToRadian), z: 0, duration: time)
        let foreverRotation = SCNAction.repeatForever(rotation)
        return foreverRotation
    }

}

extension Int {
    var degreeToRadian:Double {
        return Double(self) * .pi/180
    }
}
