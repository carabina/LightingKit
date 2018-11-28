//
//  LightsVIewController.swift
//  LightingKit Example
//
//  Created by Peter Morris on 27/11/2018.
//  Copyright © 2018 Pete Morris. All rights reserved.
//

import UIKit
import LightingKit

class LightsViewController: UITableViewController {
    
    let kit: LightingKit
    let room: Room
    let dataSource: DataSource<Light>
    
    init(kit: LightingKit, room: Room, dataSource: DataSource<Light>) {
        self.kit = kit
        self.room = room
        self.dataSource = dataSource
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Lights"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewLight))
        tableView.registerStandardCell()
        tableView.dataSource = dataSource
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let light = dataSource.objects[indexPath.row]
        let lightControls = LightControlsViewController(kit: kit, light: light)
        navigationController?.pushViewController(lightControls, animated: true)
    }
    
    @objc func addNewLight() {
        let addLightController = AddNewLightViewController(kit: kit, room: room)
        let nav = UINavigationController(rootViewController: addLightController)
        present(nav, animated: true, completion: nil)
    }
    
}
