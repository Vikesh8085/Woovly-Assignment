//
//  ContentViewController.swift
//  Woovly Assignment
//
//  Created by Vikesh Prasad on 04/10/20.
//  Copyright © 2020 Woovly. All rights reserved.
//

import UIKit
import AVKit

final class ContentViewController: AVPlayerViewController {
    //MARK: Properties
    var index: Int!
    private var urlString: String!
    private var isPlaying: Bool!
    static var sceneIdentifier: String {
        return String(describing: self)
    }
    //MARK: ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.showsPlaybackControls = true
        initialiseVideoURL()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        player?.play()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        player?.pause()
    }
    
    //MARK: Initializer
    static func initialize(urlString: String, andIndex index: Int, isPlaying: Bool = false) -> UIViewController {
        let viewController = ContentViewController.getInstanceOfVideoVC()
        viewController.urlString = urlString
        viewController.index = index
        viewController.isPlaying = isPlaying
        return viewController
    }
    
    static func getInstanceOfVideoVC() -> Self {
        let viewController =  ContentViewController.instantiateFromAppStoryBoard(appStoryBoard: .main)
        guard let conformingViewController = viewController as? Self else {
            fatalError(Strings.view_controller_error_text + "\(self)")
        }
        return conformingViewController
    }
    
    //MARK: Methods
    func initialiseVideoURL() {
        guard let url = URL(string: urlString) else { return }
        player = AVPlayer(url: url)
        isPlaying ? startPlayingVideo() : nil
    }
    
    func startPlayingVideo() {
        player?.play()
    }
    
    func pausePlayingVideo() {
        player?.pause()
    }
    
    
}
