//
//  ViewController.swift
//  FloorIsLava
//
//  Created by eavictor on 2021/1/14.
//

import ARKit
import UIKit
import CoreMotion

class ViewController: UIViewController, ARSCNViewDelegate {
    
    @IBOutlet weak var sceneView: ARSCNView!
    
    let configuration = ARWorldTrackingConfiguration()
    let motionManager = CMMotionManager()
    
    var vehicle = SCNPhysicsVehicle()
    
    var orientation: CGFloat = 0
    
    var touched: Int = 0
    
    var accelerationValues: [Double] = [0.0, 0.0]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.sceneView.debugOptions = [ARSCNDebugOptions.showWorldOrigin, ARSCNDebugOptions.showFeaturePoints]
        self.configuration.planeDetection = .horizontal
        self.sceneView.delegate = self
        self.sceneView.showsStatistics = true
        self.sceneView.session.run(configuration)
        self.setupAccelerometer()
    }
    
    @IBAction func addCar(_ sender: UIButton) {
        guard let pointOfView = self.sceneView.pointOfView else { return }
        let transform = pointOfView.transform
        let orientation = SCNVector3(-transform.m31, -transform.m32, -transform.m33)
        let location = SCNVector3(transform.m41, transform.m42, transform.m43)
        let currentPositionOfCamera = orientation + location
        let scene = SCNScene(named: "Car-Scene.scn")
        let chassis = (scene?.rootNode.childNode(withName: "chassis", recursively: false))!
        
        let frontLeftWheel = chassis.childNode(withName: "frontLeftParent", recursively: false)!
        let frontRightWheel = chassis.childNode(withName: "frontRightParent", recursively: false)!
        let rearLeftWheel = chassis.childNode(withName: "rearLeftParent", recursively: false)!
        let rearRightWheel = chassis.childNode(withName: "rearRightParent", recursively: false)!
        
        let v_frontLeftWheel = SCNPhysicsVehicleWheel(node: frontLeftWheel)
        let v_frontRightWheel = SCNPhysicsVehicleWheel(node: frontRightWheel)
        let v_rearLeftWheel = SCNPhysicsVehicleWheel(node: rearLeftWheel)
        let v_rearRightWheel = SCNPhysicsVehicleWheel(node: rearRightWheel)
        
        chassis.position = currentPositionOfCamera
        let body = SCNPhysicsBody(type: SCNPhysicsBodyType.dynamic, shape: SCNPhysicsShape(node: chassis, options: [SCNPhysicsShape.Option.keepAsCompound: true]))
        body.mass = 1
        chassis.physicsBody = body
        self.vehicle = SCNPhysicsVehicle(chassisBody: chassis.physicsBody!, wheels: [v_rearRightWheel, v_rearLeftWheel, v_frontRightWheel, v_frontLeftWheel])
        self.sceneView.scene.physicsWorld.addBehavior(self.vehicle)
        self.sceneView.scene.rootNode.addChildNode(chassis)
    }
    
    
    
    func createConcrete(planeAnchor:ARPlaneAnchor) -> SCNNode {
        let concreteNode = SCNNode(geometry: SCNPlane(width: CGFloat(planeAnchor.extent.x), height: CGFloat(planeAnchor.extent.z)))
        concreteNode.geometry?.firstMaterial?.diffuse.contents = UIImage(named: "concrete")
        concreteNode.geometry?.firstMaterial?.isDoubleSided = true
        concreteNode.position = SCNVector3(planeAnchor.center.x, planeAnchor.center.y, planeAnchor.center.z)
        concreteNode.eulerAngles = SCNVector3(90.degreeToRadius, 0, 0)
        let staticBody = SCNPhysicsBody.static()
        concreteNode.physicsBody = staticBody
        return concreteNode
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        guard let planeAnchor = anchor as? ARPlaneAnchor else { return }
        let concreteNode = createConcrete(planeAnchor: planeAnchor)
        node.addChildNode(concreteNode)
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        guard let planeAnchor = anchor as? ARPlaneAnchor else { return }
        node.enumerateChildNodes { (childNode, _) in
            childNode.removeFromParentNode()
        }
        let concreteNode = createConcrete(planeAnchor: planeAnchor)
        node.addChildNode(concreteNode)
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didRemove node: SCNNode, for anchor: ARAnchor) {
        guard let _ = anchor as? ARPlaneAnchor else { return } // Anchor to remove
        node.enumerateChildNodes { (childNode, _) in
            childNode.removeFromParentNode()
        }
    }
    
    func setupAccelerometer() {
        if motionManager.isAccelerometerAvailable {
            motionManager.accelerometerUpdateInterval = 1/60
            motionManager.startAccelerometerUpdates(to: OperationQueue.main) {
                (accelerometerData, error) in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                self.accelerometerDidChange(acceleration: accelerometerData!.acceleration)
            }
        } else {
            print("Accelerometer not available")
        }
    }
    
    // Wheel steering & engine force
    func accelerometerDidChange(acceleration: CMAcceleration) {
        accelerationValues[0] = filtered(currentAcceleration: accelerationValues[0], updatedAcceleration: acceleration.x)
        accelerationValues[1] = filtered(currentAcceleration: accelerationValues[1], updatedAcceleration: acceleration.y)
        if accelerationValues[0] > 0 {
            self.orientation = CGFloat(accelerationValues[1])
        } else {
            self.orientation = -CGFloat(accelerationValues[1])
        }
    }
    
    func filtered(currentAcceleration: Double, updatedAcceleration: Double) -> Double {
        let kfilteringFactor = 0.5
        return updatedAcceleration * kfilteringFactor + currentAcceleration * (1 - kfilteringFactor)
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didSimulatePhysicsAtTime time: TimeInterval) {
        var engineForce: CGFloat = 0
        var breakingForce: CGFloat = 0
        if self.touched == 1 {
            engineForce = 5
        } else if self.touched == 2 {
            engineForce = -5
        } else if self.touched == 3 {
            breakingForce = 100
        }
        
        self.vehicle.setSteeringAngle(self.orientation, forWheelAt: 2)
        self.vehicle.setSteeringAngle(self.orientation, forWheelAt: 3)
        
        self.vehicle.applyBrakingForce(breakingForce, forWheelAt: 0)
        self.vehicle.applyBrakingForce(breakingForce, forWheelAt: 1)
        
        self.vehicle.applyEngineForce(engineForce, forWheelAt: 0)
        self.vehicle.applyEngineForce(engineForce, forWheelAt: 1)
    }
    
    // Car Drive
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let _ = touches.first else { return }
        self.touched += touches.count
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.touched = 0
    }
    

}


extension Int {
    var degreeToRadius:Double {
        return Double(self) * .pi / 180
    }
}


func +(left: SCNVector3, right: SCNVector3) -> SCNVector3 {
    return SCNVector3Make(left.x + right.x, left.y + right.y, left.z + right.z)
}
