//
//  RaceListControllerPSC.swift
//  PigeonSportsClock
//
//  Created by Anand on 04/04/22.
//
import Alamofire
import UIKit
import Foundation

protocol getClubName {
    func getClubInfo(clubdetails:String, clubId:String)
}

class RaceListControllerPSC: UIViewController, UITableViewDelegate, UITableViewDataSource,UISearchBarDelegate {

    @IBOutlet weak var srchBarClubList: UISearchBar!
    @IBOutlet weak var tblVwRaceName: UITableView!
    var API: APIClient?
    var clubList : [Clublist]?
    var clubName : getClubName?
    var selectedClubName : String?
    var selectedClubId : String?
    var filteredData: [Clublist]?
    var searching =  false
    override func viewDidLoad() {
        super.viewDidLoad()
        tblVwRaceName.delegate = self
        tblVwRaceName.dataSource = self
        self.tableview()
        navigationItem.backButtonTitle = ""
        srchBarClubList.delegate = self
        self.srchBarClubList.showsCancelButton = true

    }
    override func viewWillAppear(_ animated: Bool) {
        self.getList()
    }
    override func viewWillDisappear(_ animated: Bool) {
        clubName?.getClubInfo(clubdetails: selectedClubName ?? "", clubId: selectedClubId ?? "")

    }
    func tableview(){
        let nib = UINib.init(nibName: "RaceListTableViewCell", bundle: nil)
        self.tblVwRaceName.register(nib, forCellReuseIdentifier: "RaceListTableViewCell")
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching {
            return filteredData?.count ?? 0
        } else {
            return clubList?.count ?? 0
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tblVwRaceName.dequeueReusableCell(withIdentifier: "RaceListTableViewCell") as? RaceListTableViewCell else {return UITableViewCell()}
        if searching {
            cell.lblList.text = filteredData?[indexPath.row].clubname ?? ""
        }else{
            cell.lblList.text = clubList?[indexPath.row].clubname ?? ""
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if searching{
            selectedClubName = filteredData?[indexPath.row].clubname ?? ""
            selectedClubId = filteredData?[indexPath.row].clubcode ?? ""
            self.navigationController?.popViewController(animated: true)
        }else {
            selectedClubName = clubList?[indexPath.row].clubname ?? ""
            selectedClubId = clubList?[indexPath.row].clubcode ?? ""
            print("selectedclub....\(selectedClubName)")
            self.navigationController?.popViewController(animated: true)
        }
        self.srchBarClubList.searchTextField.endEditing(true)
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredData = clubList?.filter({ item  -> Bool in
            return item.clubname.range(of: searchText, options: .caseInsensitive) != nil
        })
        searching = true
        tblVwRaceName.reloadData()
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        srchBarClubList.text = ""
        tblVwRaceName.reloadData()
    }

    func getList(){

        // Create URL
        let url = URL(string: "https://pigeonsportsclock.com/pigeon/lespoton_new_version.php?action=clublist")
        guard let requestUrl = url else { fatalError() }

        // Create URL Request
        var request = URLRequest(url: requestUrl)

        // Specify HTTP Method to use
        request.httpMethod = "GET"
        showLoading()
        // Send HTTP Request
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in

            // Check if Error took place
            if let error = error {
                print("Error took place \(error)")
                return
            }

            // Read HTTP Response Status code
            if let response = response as? HTTPURLResponse {
                print("Response HTTP Status code: \(response.statusCode)")
            }

            // Convert HTTP Response Data to a simple String
            if let data = data, let dataString = String(data: data, encoding: .utf8) {
                print("Response data string:\n \(dataString)")
                self.getResponseFromModel(jonObject: data, decoderObject: getClubList.self) { res in
                    DispatchQueue.main.async {
                        print(res)
                        self.clubList = (res as! getClubList).clublist
                        self.clubList = self.clubList?.sorted(by: { item1, item2 in
                            return item1.clubname.lowercased() < item2.clubname.lowercased()
                            
                        })
                        self.tblVwRaceName.reloadData()
                        hideLoading()
                    }
                }
            }
        }
        task.resume()
    }

    func getResponseFromModel<T: Codable>(jonObject:Any,decoderObject:T.Type,completion: @escaping(Any)->Void){
        do{
            let obj = try JSONSerialization.jsonObject(with: jonObject as! Data, options: .allowFragments)
            let jsonData = try JSONSerialization.data(withJSONObject: obj, options: .prettyPrinted)
            let dataResponse = try JSONDecoder().decode(decoderObject, from: jsonData)
            completion(dataResponse)
        }catch{
            print(error)
        }
    }
}

