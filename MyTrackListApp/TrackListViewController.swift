//
//  TrackListViewController.swift
//  MyTrackListApp
//
//  Created by Andrey Machulin on 10.04.2023.
//

import UIKit

class TrackListViewController: UITableViewController {
    
    //Создаём массив, который возвращает перечень композиций
    var trackList = Track.getTrackList()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 80
    }
    
    // MARK: - Table view data source
    //Настраивает количество секций (в одной секции может быть много ячеек). Этот метод оставляем только в том случае, если количество секций >1. Если сексия одна, то необходимости в данном методе нет.
    //    override func numberOfSections(in tableView: UITableView) -> Int {
    //        return 1
    //    }
    
    //Настраиваем количество строк в одной секции
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        trackList.count
    }
    
    //Настраиваем контент ячеек
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "track", for: indexPath)
     
        let track = trackList[indexPath.row]
        //Создаём объект, в котором храняться настройки ячейки
        
        var content = cell.defaultContentConfiguration()
        
        content.text = track.song
        content.secondaryText = track.artist
        
        content.image = UIImage(named: track.title)
        content.imageProperties.cornerRadius = tableView.rowHeight / 2
        
        cell.contentConfiguration = content
        
        return cell
    }
    
        // MARK: - UITableViewDelegate
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
    
}
