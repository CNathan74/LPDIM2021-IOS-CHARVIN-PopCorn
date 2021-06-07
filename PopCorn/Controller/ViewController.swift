//
//  ViewController.swift
//  Project
//
//  Created by Nathan on 28/05/2021.
//

import UIKit
import SafariServices
class ViewController: UIViewController {

    @IBOutlet var movieTitle: UILabel!
    @IBOutlet var releaseDate: UILabel!
    @IBOutlet var duaration: UILabel!
    @IBOutlet var subTitle: UILabel!
    @IBOutlet var summary: UILabel!
    @IBOutlet var movieCategory: UILabel!
    @IBOutlet var movieImage: UIImageView!
    @IBOutlet var trailerView: UIView!
    var movieTrailerURL: String?
    //var movieDetail: movie?
    var movieDetail: Result?
    class func movieDetail() -> ViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "movieDetailVC") as! ViewController
    }
    override func viewDidLoad() { 
        super.viewDidLoad()
        self.trailerView.layer.borderWidth = 5
        self.trailerView.layer.cornerRadius = 10
        let data = self.movieDetail
        self.movieTitle.text = movieDetail?.title
        self.subTitle.text = movieDetail?.originalTitle
        self.releaseDate.text = movieDetail?.releaseDate
        self.duaration.text = String(movieDetail?.voteCount ?? 0)
        self.summary.text = movieDetail?.overview
        self.movieCategory.text = movieDetail?.originalLanguage
        let url = URL(string: "https://image.tmdb.org/t/p/w500" + movieDetail!.posterPath)!

            DispatchQueue.global().async {
                // Fetch Image Data
                if let data = try? Data(contentsOf: url) {
                    DispatchQueue.main.async {
                        // Create Image and Update Image View
                        self.movieImage.image = UIImage(data: data)
                    }
                }
            }
        self.getData(movieId: movieDetail?.id ?? 637649)

        // Do any additional setup after loading the view.
   
        
    }
    func getData(movieId: Int){
        let finalURL = MOVIE_VIDEO + String(movieId) + MOVIE_VIDEO_API_KEY
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
                        let json = try JSONDecoder().decode(MovieVideo.self, from: data! )
                        
                        if let data = try? json.results{
                            self.movieTrailerURL = "https://youtu.be/" + data[0].key
                            print("Json response")
                        }else{
                            self.movieTrailerURL = "https://www.youtube.com/watch?v=EFYEni2gsK0"
                        }
                        
                        
                    } catch {
                        print("Error during JSON serialization: \(error.localizedDescription)")
                    }
                    
                })
                task.resume()
        
            }

    @IBAction func trailerBtnPressed(_ sender: Any) {
        if let url = URL(string: self.movieTrailerURL ?? "") {
            let svc = SFSafariViewController(url: url)
            present(svc, animated: true, completion: nil)
                }
    }
}

