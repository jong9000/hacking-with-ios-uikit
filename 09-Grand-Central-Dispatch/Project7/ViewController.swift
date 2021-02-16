import UIKit

class ViewController: UITableViewController {

  var petitions = [Petition]()
  var filteredPetitions = [Petition]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Credits", style: .plain, target: self, action: #selector(leftBarButtonTapped))
    navigationItem.setRightBarButton(UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(rightBarButtonTapped)), animated: true)
    
    performSelector(inBackground: #selector(fetchJSON), with: nil)
  }
  
  @objc func fetchJSON() {
    
    var urlString = ""
    
    DispatchQueue.main.async { [weak self] in
      if self?.navigationController?.tabBarItem.tag == 0 {
        urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
      } else {
        urlString = "https://www.hackingwithswift.com/samples/petitions-2.json"
      }
      
      if let url = URL(string: urlString) {
        if let data = try? Data(contentsOf: url) {
          self?.parse(json: data)
          return
        }
        DispatchQueue.main.async { [weak self] in
          self?.showError()
        }
      }
    }

  }
  
  @objc func leftBarButtonTapped() {
    let ac = UIAlertController(title: "Credits", message: "Made with Aloha by jong9000", preferredStyle: .alert)
    ac.addAction(UIAlertAction(title: "OK", style: .default))
    present(ac, animated: true)
  }
  
  @objc func rightBarButtonTapped() {
    let ac = UIAlertController(title: "Search", message: nil, preferredStyle: .alert)
    ac.addTextField { textField in
      textField.placeholder = "Search"
    }
    
    ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
    ac.addAction(UIAlertAction(title: "Go", style: .default))
    
    present(ac,animated: true)
  }

  @objc func showError() {
      let ac = UIAlertController(title: "Loading error", message: "There was a problem loading the feed; please check your connection and try again.", preferredStyle: .alert)
      ac.addAction(UIAlertAction(title: "OK", style: .default))
      present(ac, animated: true)
  }
  
  func parse(json: Data) {
    let decoder = JSONDecoder()
    
    if let jsonPetitions = try? decoder.decode(Petitions.self, from: json) {
      petitions = jsonPetitions.results
      tableView.performSelector(onMainThread: #selector(UITableView.reloadData), with: nil, waitUntilDone: false)
    } else {
      performSelector(onMainThread: #selector(showError), with: nil, waitUntilDone: false)
    }
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return petitions.count
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
    let petition = petitions[indexPath.row]
    cell.textLabel?.text = petition.title
    cell.detailTextLabel?.text = petition.body
    return cell
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let vc = DetailViewController()
    vc.detailItem = petitions[indexPath.row]
    navigationController?.pushViewController(vc, animated: true)
  }

}
