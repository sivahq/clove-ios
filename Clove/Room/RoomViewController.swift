//
//  RoomViewController.swift
//  Clove
//
//  Created by Sivaprakash Ragavan on 8/21/17.
//  Copyright © 2017 Clove HQ. All rights reserved.
//

import UIKit
import AVFoundation
import CoreData

class RoomViewController: UIViewController, AVAudioRecorderDelegate {
    
    var room: NSManagedObject?
    
    //Variables
    var audioRecorder: AVAudioRecorder!
    var audioPlayer: AVAudioPlayer!
    var meterTimer:Timer!
    var isAudioRecordingGranted: Bool!
    
    var streamInProgress: String!
    var startTime: Date!
    
    var streamsDataSource: StreamsTableDataSource?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        streamsDataSource = StreamsTableDataSource(room: room!)
        tableView.dataSource = streamsDataSource
        streamsDataSource?.registerCellsForTableView(tableView: tableView)

        initViewElements()
        
        switch AVAudioSession.sharedInstance().recordPermission() {
        case AVAudioSessionRecordPermission.granted:
            isAudioRecordingGranted = true
            break
        case AVAudioSessionRecordPermission.denied:
            isAudioRecordingGranted = false
            break
        case AVAudioSessionRecordPermission.undetermined:
            AVAudioSession.sharedInstance().requestRecordPermission() { [unowned self] allowed in
                DispatchQueue.main.async {
                    if allowed {
                        self.isAudioRecordingGranted = true
                    } else {
                        self.isAudioRecordingGranted = false
                    }
                }
            }
            break
        default:
            break
        }
        
    }
    
    override func updateViewConstraints() {
        positionViewElements()
        super.updateViewConstraints()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        audioRecorder = nil
    }
    
    
    lazy var recordingTimeLabel: UILabel! = {
        let view = UILabel()
        view.text = "00:00:00"
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .center
        return view
    }()
    
    lazy var recordButton: UIButton! = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addTarget(self, action: #selector(audioRecorderAction(_:)), for: .touchDown)
        view.setTitle("Record", for: .normal)
        view.setTitleColor(UIColor.blue, for: .normal)
        return view
    }()
    
    lazy var stopButton: UIButton! = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addTarget(self, action: #selector(stopAudioRecordingAction(_:)), for: .touchDown)
        view.setTitle("Stop", for: .normal)
        view.setTitleColor(UIColor.blue, for: .normal)
        return view
    }()
    
    lazy var tableView: UITableView! = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.register(StreamsTableItem.self, forCellReuseIdentifier: "StreamItem")
        view.delegate = self
        return view
    }()
    
    func initViewElements() {
        let roomName = room?.value(forKey: "name") as? String
        navigationItem.title = roomName
        view.addSubview(recordingTimeLabel)
        view.addSubview(recordButton)
        view.addSubview(stopButton)
        view.addSubview(tableView)
        view.setNeedsUpdateConstraints()
    }
    
    func positionViewElements() {
        stopButton.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: 30).isActive = true
        tableView.topAnchor.constraint(equalTo: recordButton.bottomAnchor, constant: 30).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: -16).isActive = true
        view.layoutMarginsGuide.trailingAnchor.constraint(equalTo: tableView.trailingAnchor, constant: -16).isActive = true
        recordButton.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: 30).isActive = true
        recordButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        recordButton.leadingAnchor.constraint(equalTo: stopButton.trailingAnchor, constant: 25).isActive = true
        recordingTimeLabel.leadingAnchor.constraint(equalTo: recordButton.trailingAnchor, constant: 25).isActive = true
        recordingTimeLabel.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: 35).isActive = true
        bottomLayoutGuide.topAnchor.constraint(equalTo: tableView.bottomAnchor).isActive = true
    }
    
    //MARK:- Audio recorder buttons action.
    func audioRecorderAction(_ sender: UIButton) {
        
        if isAudioRecordingGranted {
            
            //Create the session.
            let session = AVAudioSession.sharedInstance()
            
            do {
                //Configure the session for recording and playback.
                try session.setCategory(AVAudioSessionCategoryPlayAndRecord, with: .defaultToSpeaker)
                try session.setActive(true)
                //Set up a high-quality recording session.
                let settings = [
                    AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
                    AVSampleRateKey: 44100,
                    AVNumberOfChannelsKey: 2,
                    AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
                ]
                //Create audio file name URL
                streamInProgress = Utilities.randomString(length: 12)
                let audioFilename = Utilities.getDocumentsDirectory().appendingPathComponent("\(streamInProgress!).m4a")
                //Create the audio recording, and assign ourselves as the delegate
                audioRecorder = try AVAudioRecorder(url: audioFilename, settings: settings)
                audioRecorder.delegate = self
                audioRecorder.isMeteringEnabled = true
                audioRecorder.record()
                startTime = NSDate() as Date!
                meterTimer = Timer.scheduledTimer(timeInterval: 0.1, target:self, selector:#selector(self.updateAudioMeter(timer:)), userInfo:nil, repeats:true)
            }
            catch let error {
                print("Error for start audio recording: \(error.localizedDescription)")
            }
        }
    }
    
    func stopAudioRecordingAction(_ sender: UIButton) {
        finishAudioRecording(success: true)
    }
    
    func finishAudioRecording(success: Bool) {
        if(streamInProgress != nil) {
            audioRecorder.stop()
            audioRecorder = nil
            meterTimer.invalidate()
            recordingTimeLabel.text = String(format: "%02d:%02d:%02d", 0, 0, 0)
            
            var duration = 0
            let audioFilename = Utilities.getDocumentsDirectory().appendingPathComponent("\(streamInProgress!).m4a")
            do{
                audioPlayer = try AVAudioPlayer(contentsOf:audioFilename)
                duration = Int(audioPlayer.duration)
                print(duration)
            }catch let error as NSError {
                print("Could not find duration. \(error), \(error.userInfo)")
            }
            
            let stream = StreamAPI.addStream(room: room!, id: streamInProgress!, startTime: startTime, duration: duration)
            streamsDataSource?.streams.append(stream)
            tableView.reloadData()
            streamInProgress = nil
            startTime = nil
            
            if success {
                print("Recording finished successfully.")
            } else {
                print("Recording failed :(")
            }
        }
    }
    
    func updateAudioMeter(timer: Timer) {
        if audioRecorder.isRecording {
            let hr = Int((audioRecorder.currentTime / 60) / 60)
            let min = Int(audioRecorder.currentTime / 60)
            let sec = Int(audioRecorder.currentTime.truncatingRemainder(dividingBy: 60))
            let totalTimeString = String(format: "%02d:%02d:%02d", hr, min, sec)
            recordingTimeLabel.text = totalTimeString
            audioRecorder.updateMeters()
        }
    }
    
    //MARK:- Audio recoder delegate methods
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if !flag {
            finishAudioRecording(success: false)
        }
    }
    
}

// MARK: - UITableViewDelegate
extension RoomViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let stream = streamsDataSource?.streams[indexPath.row]
        if let streamId = stream?.value(forKey: "id") as? String {
            
            let audioFilename = Utilities.getDocumentsDirectory().appendingPathComponent("\(streamId).m4a")
            do{
                try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
                try AVAudioSession.sharedInstance().setActive(true)
                audioPlayer = try AVAudioPlayer(contentsOf:audioFilename)
                audioPlayer.prepareToPlay()
                audioPlayer.play()
            }catch let error as NSError {
                print("Could not play. \(error), \(error.userInfo)")
            }
        }
    }
}

