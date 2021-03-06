//
//  ViewController.swift
//  beacon2
//
//  Created by shiro on 2019/11/05.
//  Copyright © 2019 shiro. All rights reserved.
//

import UIKit
import CoreLocation
import Foundation
import AVFoundation

class ViewController: UIViewController, CLLocationManagerDelegate, AVAudioPlayerDelegate{

    var myLocationManager:CLLocationManager!
    var Audio1: AVAudioPlayer!
    var Audio2: AVAudioPlayer!
    var Audio3: AVAudioPlayer!
    var Audio4: AVAudioPlayer!
    var Audio5: AVAudioPlayer!
    var myBeaconRegion:CLBeaconRegion!
    var beaconUuids: NSMutableArray!
    var beaconDetails: NSMutableArray!
    var num:Int!=2
    var beacon1: CLBeacon!
    var beacon2: CLBeacon!
    var beacon3: CLBeacon!
    var beacon4: CLBeacon!
    var beacon5: CLBeacon!
    var beacon6: CLBeacon!
    var beacon7: CLBeacon!
    var beacon8: CLBeacon!
    
    //let dateFormater = DateFormatter()
    //let dt : Date = Date()

    let UUIDList = [
        "48534442-4C45-4144-80C0-180000000000"
    ]
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label3: UILabel!
    @IBOutlet weak var label4: UILabel!
    @IBOutlet weak var label5: UILabel!
    @IBOutlet weak var label6: UILabel!
    @IBOutlet weak var label7: UILabel!
    @IBOutlet weak var label8: UILabel!
    /*
    @IBAction func Buttun(){
        num  += 1
    }
    */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let sound1 : String = Bundle.main.path(forResource: "beep2_big", ofType: "wav")!
        let fileurl1 = URL(fileURLWithPath: sound1)
        let sound2 : String = Bundle.main.path(forResource: "beep3_big", ofType: "wav")!
        let fileurl2 = URL(fileURLWithPath: sound2)
        let sound3 : String = Bundle.main.path(forResource: "beep4_big", ofType: "wav")!
        let fileurl3 = URL(fileURLWithPath: sound3)
        let sound4 : String = Bundle.main.path(forResource: "beep5_big", ofType: "wav")!
        let fileurl4 = URL(fileURLWithPath: sound4)
        let sound5 : String = Bundle.main.path(forResource: "beepex_big", ofType: "wav")!
        let fileurl5 = URL(fileURLWithPath: sound5)

        Audio1 = try! AVAudioPlayer(contentsOf: fileurl1)
        Audio2 = try! AVAudioPlayer(contentsOf: fileurl2)
        Audio3 = try! AVAudioPlayer(contentsOf: fileurl3)
        Audio4 = try! AVAudioPlayer(contentsOf: fileurl4)
        Audio5 = try! AVAudioPlayer(contentsOf: fileurl5)
        
        Audio1.prepareToPlay()
        Audio2.prepareToPlay()
        Audio3.prepareToPlay()
        Audio4.prepareToPlay()
        Audio5.prepareToPlay()
        Audio1.numberOfLoops = -1
        Audio2.numberOfLoops = -1
        Audio3.numberOfLoops = -1
        Audio4.numberOfLoops = -1
        Audio5.numberOfLoops = -1
        
        myLocationManager = CLLocationManager()
        myLocationManager.delegate = self
        myLocationManager.desiredAccuracy = kCLLocationAccuracyBest
        myLocationManager.distanceFilter = 1
        let status = CLLocationManager.authorizationStatus()
        print("CLAuthorizedStatus: \(status.rawValue)");
        if(status == .notDetermined) {
            myLocationManager.requestAlwaysAuthorization()
        }
        beaconUuids = NSMutableArray()
        beaconDetails = NSMutableArray()
    }

    private func startMyMonitoring() {
        for i in 0 ..< UUIDList.count {
            let uuid: NSUUID! = NSUUID(uuidString: "\(UUIDList[i].lowercased())")
            let identifierStr: String = "abcde\(i)"
            myBeaconRegion = CLBeaconRegion(proximityUUID: uuid as UUID, identifier: identifierStr)
            myBeaconRegion.notifyEntryStateOnDisplay = false
            myBeaconRegion.notifyOnEntry = true
            myBeaconRegion.notifyOnExit = true
            myLocationManager.startMonitoring(for: myBeaconRegion)
        }
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print("didChangeAuthorizationStatus");
        switch (status) {
        case .notDetermined:
            print("not determined")
            break
        case .restricted:
            print("restricted")
            break
        case .denied:
            print("denied")
            break
        case .authorizedAlways:
            print("authorizedAlways")
            startMyMonitoring()
            break
        case .authorizedWhenInUse:
            print("authorizedWhenInUse")
            startMyMonitoring()
            break
        }
    }

    func locationManager(_ manager: CLLocationManager, didStartMonitoringFor region: CLRegion) {
        manager.requestState(for: region);
    }

    func locationManager(_ manager: CLLocationManager, didDetermineState state: CLRegionState, for region: CLRegion) {
        switch (state) {
        case .inside:
            print("iBeacon inside");
            manager.startRangingBeacons(in: region as! CLBeaconRegion)
            break;
        case .outside:
            print("iBeacon outside")
            break;
        case .unknown:
            print("iBeacon unknown")
            break;
        }
    }
    

    func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
        beaconUuids = NSMutableArray()
        beaconDetails = NSMutableArray()
        //print(beacons.count)
        
        if(beacons.count > 0){
            for i in 0 ..< beacons.count {
                
                let beacon = beacons[i]
                //let beaconUUID = beacon.proximityUUID;
                //let minorID = beacon.minor;
                let majorID = beacon.major.intValue;
                //let rssi = Double(beacon.rssi);
                //let accu = String(beacon.accuracy);
                if majorID == num {
                    beacon1 = beacon
                }else if majorID == num+1{
                    beacon2 = beacon
                }else if majorID == num+2{
                    beacon3 = beacon
                }else if majorID == num+3{
                    beacon4 = beacon
                }else if majorID == num+4{
                    beacon5 = beacon
                }else if majorID == num+5{
                    beacon6 = beacon
                }else if majorID == num+6{
                    beacon7 = beacon
                }else if majorID == num+7{
                    beacon8 = beacon
                }
                
            }
        }
        /*
        if beacon1.proximity.rawValue == 0{
            num += 1
        }
        */
        label1.text = String(beacon1.proximity.rawValue)
        label2.text = String(beacon2.proximity.rawValue)
        label3.text = String(beacon3.proximity.rawValue)
        label4.text = String(beacon4.proximity.rawValue)
        label5.text = String(beacon5.proximity.rawValue)
        label6.text = String(beacon6.proximity.rawValue)
        label7.text = String(beacon7.proximity.rawValue)
        label8.text = String(beacon8.proximity.rawValue)
        
        let proximity = [beacon1.proximity.rawValue,beacon2.proximity.rawValue,beacon3.proximity.rawValue,
                         beacon4.proximity.rawValue,beacon5.proximity.rawValue,beacon6.proximity.rawValue,
                         beacon7.proximity.rawValue,beacon8.proximity.rawValue]
        let acuuracy = [beacon1.accuracy,beacon2.accuracy,beacon3.accuracy,
                        beacon4.accuracy,beacon5.accuracy,beacon6.accuracy,
                        beacon7.accuracy,beacon8.accuracy]
        
        //immmediate:1 Near:2 Far:3 Unknown:0
       
        if(proximity[6] == 1){
            if(Audio1.isPlaying){
                Audio1.stop()
            }else if(Audio3.isPlaying){
                Audio3.stop()
            }else if(Audio4.isPlaying){
                Audio4.stop()
            }else if(Audio5.isPlaying){
                Audio5.stop()
            }
            Audio2.play()
        }else if(proximity[6] == 2 && proximity[0] == 3){
                if(Audio1.isPlaying){
                    Audio1.stop()
                }else if(Audio3.isPlaying){
                    Audio3.stop()
                }else if(Audio4.isPlaying){
                    Audio4.stop()
                }else if(Audio5.isPlaying){
                    Audio5.stop()
                }
                Audio2.play()
            
        }else if(proximity[7] == 1){
            if(Audio1.isPlaying){
                Audio1.stop()
            }else if(Audio2.isPlaying){
                Audio2.stop()
            }else if(Audio3.isPlaying){
                Audio3.stop()
            }else if(Audio5.isPlaying){
                Audio5.stop()
            }
            Audio4.play()
        }else if(proximity[7] == 2){
            if(proximity[0] == 3 && (proximity[1] == 3 || proximity[2] == 3  )){
                if(Audio1.isPlaying){
                    Audio1.stop()
                }else if(Audio2.isPlaying){
                    Audio2.stop()
                }else if(Audio3.isPlaying){
                    Audio3.stop()
                }else if(Audio5.isPlaying){
                    Audio5.stop()
                }
                Audio4.play()
            }
            else{
                if(Audio2.isPlaying){
                    Audio2.stop()
                }else if(Audio3.isPlaying){
                    Audio3.stop()
                }else if(Audio4.isPlaying){
                    Audio4.stop()
                }else if(Audio5.isPlaying){
                    Audio5.stop()
                }
                Audio1.play()
            }
        }else{
            if(Audio2.isPlaying){
                Audio2.stop()
            }else if(Audio3.isPlaying){
                Audio3.stop()
            }else if(Audio4.isPlaying){
                Audio4.stop()
            }else if(Audio5.isPlaying){
                Audio5.stop()
            }
            Audio1.play()
        }
        /* switch (proximity) {
        case (_,_,_,_,2,3,_,_):
            if(Audio2.isPlaying){
                Audio2.stop()
            }else if(Audio3.isPlaying){
                Audio3.stop()
            }else if(Audio4.isPlaying){
                Audio4.stop()
            }else if(Audio5.isPlaying){
                Audio5.stop()
            }
            Audio1.play()
        case (_,_,_,_,_,2,3,_):
            if(Audio1.isPlaying){
                Audio1.stop()
            }else if(Audio3.isPlaying){
                Audio3.stop()
            }else if(Audio4.isPlaying){
                Audio4.stop()
            }else if(Audio5.isPlaying){
                Audio5.stop()
            }
            Audio2.play()
        case (_,_,_,_,_,_,2,3):
            if(Audio1.isPlaying){
                Audio1.stop()
            }else if(Audio2.isPlaying){
                Audio2.stop()
            }else if(Audio4.isPlaying){
                Audio4.stop()
            }else if(Audio5.isPlaying){
                Audio5.stop()
            }
            Audio3.play()
        case (_,_,_,_,_,_,2,2):
            if(Audio1.isPlaying){
                Audio1.stop()
            }else if(Audio2.isPlaying){
                Audio2.stop()
            }else if(Audio3.isPlaying){
                Audio3.stop()
            }else if(Audio5.isPlaying){
                Audio5.stop()
            }
            Audio4.play()
        default:
            if(Audio1.isPlaying){
                Audio1.stop()
            }else if(Audio2.isPlaying){
                Audio2.stop()
            }else if(Audio3.isPlaying){
                Audio3.stop()
            }else if(Audio4.isPlaying){
                Audio4.stop()
            }
            Audio5.play()
            }
        }
   */
        
        //print(beacon1.proximity.rawValue)
        //print(beacon2.proximity.rawValue)
        //print(beacon1)
        //print(beacon2)
        //print(beacons[1])
    }



    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        print("didEnterRegion: iBeacon found");
        manager.startRangingBeacons(in: region as! CLBeaconRegion)
    }

    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        print("didExitRegion: iBeacon lost");
        manager.stopRangingBeacons(in: region as! CLBeaconRegion)
    }



}
