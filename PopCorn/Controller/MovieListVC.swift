//
//  MovieListVC.swift
//  Project
//
//  Created by Nathan on 29/05/2021.
//

import UIKit
import Foundation
class MovieListVC: UIViewController {

    @IBOutlet var tableView: UITableView!
   // @IBOutlet var collectionView: UICollectionView!
    //var loadMoviesData: [movie] = []
    @IBOutlet var categoryName: UILabel!
    var category: String?
    var selectedIndex: Int?
    var targetId: Int?
   var ApiResponse: [Result]?
    
    class func movieList() -> MovieListVC {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "movieListVC") as! MovieListVC
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.categoryName.text = "Category : " + String(self.category ?? "")
        self.selectedIndex = 0
       // DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.getData(genreId: self.targetId ?? 1)
            self.tableView.reloadData()
        //}
        
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }
    func moveToMovieList(){
        let vc = ViewController.movieDetail()
        vc.movieDetail = self.ApiResponse?[self.selectedIndex ?? 0]
        self.present(vc, animated: true, completion: nil)
    }
    
    // API Calling Mehtod
    func getData(genreId: Int){
        let finalURL = CATEGORY_TYPE_MOVIE_LIST + String(genreId) + MOVIELIST_URL_SUB
        let session = URLSession.shared
        guard let url = Foundation.URL(string: finalURL) else { return  }
                let task = session.dataTask(with: url, completionHandler: { data, response, error in
                    // Check the response
                    print(response)
                    
                    // Check if an error occured
                    if error != nil {
                        // HERE you can manage the error
                        print(error)
                        return
                    }
                    

                    do {
                        let json = try JSONDecoder().decode(Welcome.self, from: data! )
                        print("josn response here: ",json.results[0].title)
                        self.ApiResponse = json.results
                        print("Json response")
                        
                    } catch {
                        print("Error during JSON serialization: \(error.localizedDescription)")
                    }
                    
                })
                task.resume()
        
            }

}
extension MovieListVC: UITableViewDataSource,UITableViewDelegate
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.ApiResponse?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieListIdentifer") as! movieListTableCellVC
        let data = self.ApiResponse
        cell.movieDate.text = data?[indexPath.row].releaseDate
        cell.movieName.text = data?[indexPath.row].title
        cell.movieSyanos.text = data?[indexPath.row].overview
        let url = URL(string: "https://image.tmdb.org/t/p/w500" + (data?[indexPath.row].posterPath)!)!

            DispatchQueue.global().async {
                // Fetch Image Data
                if let data = try? Data(contentsOf: url) {
                    DispatchQueue.main.async {
                        // Create Image and Update Image View
                        cell.movieImage.image = UIImage(data: data)
                    }
                }
            }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.reloadData()
        self.selectedIndex = indexPath.row
        self.moveToMovieList()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        return 152
    }
    
}
