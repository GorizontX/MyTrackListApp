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
        //Настраиваем высоту ячейки, чтобы image отоборажался адекватно
        tableView.rowHeight = 80
        //Инициализируем кнопку Edit в NaviagtionController
        navigationItem.leftBarButtonItem = editButtonItem
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
        
        //мы создаем экземпляр трекра, который будет передавать в ячейку. Трект определяется индексом в массиве и совпадаем в индексом ячейки
        let track = trackList[indexPath.row]
        
        //Создаём объект, в котором храняться настройки ячейки. Далее мы можем менять вид ячейки, добавлять image, работать с ним и другим типами и т.д.
        var content = cell.defaultContentConfiguration()
        
        content.text = track.song
        content.secondaryText = track.artist
        
        content.image = UIImage(named: track.title)
        content.imageProperties.cornerRadius = tableView.rowHeight / 2
        
        //После того, как мы присвоили значения в content (открыли возможности для настройки) их нужно передать в нашу ячейку
        cell.contentConfiguration = content
        
        return cell
    }
    
    // MARK: - UITableViewDelegate
    //Создаем этот метод, чтобы сделать переход после того, как пользователь нажмет на ячейку
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let track = trackList[indexPath.row]
        performSegue(withIdentifier: "showDetails", sender: track)
    }
    
    //убираем красные кружочки Delete, при нажатии на Edit
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        .none
    }
    
    //Не дает контенту сдвигаться вправо из-за удаленных кружочков Delete
    override func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        false
    }
    
    //Метод, позволяющий двигать контент
    //sourceIndexPath – indexPath-источник, Destination
    //destinationIndexPath – indexPath-назначения
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let currentTrack = trackList.remove(at: sourceIndexPath.row)
        trackList.insert(currentTrack, at: destinationIndexPath.row)
    }
    
    // MARK: - Navigation
    /*
     Этот метод мы используем, если делаем переход на новый экран через ячейку
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let detailsVC = segue.destination as? TrackDetailsViewController else { return }
        //далее мы обращаемся к TableView, запросили у него index выбранной ячейки
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        //далее имея этот index, мы можем извлечь из массива со списком нужный объект
        detailsVC.track = trackList[indexPath.row]
    }
    */
    
    //Этот метод мы делаем, если делаем переход программно, с заданным индетификатором segue.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let detailsVC = segue.destination as? TrackDetailsViewController else { return }
        detailsVC.track = sender as? Track
    }
    
}
