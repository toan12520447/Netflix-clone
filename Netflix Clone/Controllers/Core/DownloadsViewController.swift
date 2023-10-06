//
//  DownloadsViewController.swift
//  Netflix Clone
//
//  Created by Toan Tran on 10/4/23.
//

import UIKit

class DownloadsViewController: UIViewController {

    private var titles: [TitleItem] = [TitleItem]()
    private let downloadTable: UITableView = {
        let table = UITableView()
        table.register(TitleTableViewCell.self, forCellReuseIdentifier: TitleTableViewCell.identifier)
        return table
        
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        title = "Downloads"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        
        view.addSubview(downloadTable)
        downloadTable.delegate = self
        downloadTable.dataSource = self
        fetchLocalStorageFromDownload()
        NotificationCenter.default.addObserver(forName: NSNotification.Name("downloaded"), object: nil, queue:nil) { _ in
            self.fetchLocalStorageFromDownload()
        }
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        downloadTable.frame = view.bounds
    }
    
    private func fetchLocalStorageFromDownload(){
        DataPersistenceManager.shared.fetchingTitlesFromDatabase { [weak self] result in
            switch result{
            case .success(let titles):
                self?.titles = titles
                self?.downloadTable.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

}

extension DownloadsViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.titles.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCell.identifier, for: indexPath) as? TitleTableViewCell else{
            return UITableViewCell()
        }
        let title = titles[indexPath.row]
        cell.configure(with: TitleViewModel(titleName:title.original_title ?? title.original_name ?? "Unknow title name", posterURL:title.poster_path ?? "Unknown poster path" ))
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle{
        case .delete:
            DataPersistenceManager.shared.deleteTitleWith(model: titles[indexPath.row]) {[weak self] result in
                switch result{
                case .success():
                    print("Deleted from database")
                    self?.titles.remove(at: indexPath.row)
                    tableView.deleteRows(at: [indexPath], with: .fade)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        default:
            break
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let title = titles[indexPath.row]
        guard let titleName = title.original_title ?? title.original_name else{return}
        APICaller.shared.getMovie(with: titleName) { [weak self] result in
            switch result{
            case .success(let videoElement):
                DispatchQueue.main.async {
                    let vc = TitlePreviewViewController()
                    vc.configure(with: TitlePreviewViewModel(title: title.original_title ?? title.original_name ?? "" , youtubeView: videoElement, titleOverview: title.overview ?? "Unknown overview"))
                    self?.navigationController?.pushViewController(vc, animated: true)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
   
}
