//
//  TrackDetailsViewController.swift
//  MyTrackListApp
//
//  Created by Andrey Machulin on 10.04.2023.
//

import UIKit

class TrackDetailsViewController: UIViewController {

    @IBOutlet var artCoverImageView: UIImageView!
    @IBOutlet var trackTitleLabel: UILabel!
    
    //На этот экран передаем экземпляр модели
    var track: Track!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        artCoverImageView.image = UIImage(named: track.title)
        trackTitleLabel.text = track.title
        
    }
}
