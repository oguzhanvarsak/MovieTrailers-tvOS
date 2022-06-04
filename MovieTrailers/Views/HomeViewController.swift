//
//  HomeViewController.swift
//  MovieTrailers
//
//  Created by Oğuzhan Varsak on 4.06.2022.
//

import UIKit

private let movieCellReuseIdentifier = "MovieCollectionViewCell"

class HomeViewController: UIViewController {
    
    var collectionView: UICollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout.init())
    
    private var viewModel: HomeViewModel?
    
    let compositionalLayout = UICollectionViewCompositionalLayout(sectionProvider: { (sectionIndex, environment) -> NSCollectionLayoutSection? in
    
        let fraction: CGFloat = 1 / 3
        let width: CGFloat = 400
        let inset: CGFloat = 35
        
        // Item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: inset, leading: inset, bottom: inset, trailing: inset)
        
        // Group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(fraction), heightDimension: .absolute(width))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        // Section
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: inset, leading: inset, bottom: inset, trailing: inset)
        
        // Supplementary Item
        let headerItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(100))
        let headerItem = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerItemSize, elementKind: "header", alignment: .top)
        section.boundarySupplementaryItems = [headerItem]
        
        section.orthogonalScrollingBehavior = .continuous
        
        return section
    })
    
    convenience init(viewModel: HomeViewModel) {
        self.init()
        self.viewModel = viewModel
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Trailers"
        
        viewModel?.delegate = self
        viewModel?.getGenres()
        
        configureCollectionView()
    }
}

extension HomeViewController {
  func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: compositionalLayout)
      collectionView.register(HeaderCollectionReusableView.self, forSupplementaryViewOfKind: "header", withReuseIdentifier: "HeaderCollectionReusableView")

        collectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: movieCellReuseIdentifier)

        view.addSubview(collectionView)

        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        collectionView.backgroundColor = .clear

        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel?.numberOfSections ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: MovieCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: movieCellReuseIdentifier, for: indexPath) as! MovieCollectionViewCell
        
        let movieAtIndex = viewModel?.movieAtIndex(indexPath.row)
        
        cell.title = movieAtIndex?.title
        
        if let backdropPath = movieAtIndex?.backdropPath {
            let request = URLRequest(url: URL(string: String(format: GeneralSettings.Url.poster, backdropPath))!)
            
            cell.dataTask = URLSession.shared.dataTask(with: request, completionHandler: { data, response, error in
                DispatchQueue.global(qos: .utility).async {
                    if error == nil && data != nil {
                        let image = UIImage(data: data!)
                        DispatchQueue.main.async {
                            cell.posterImageView.image = image
                        }
                    }
                }
            })
        }
        
        
        cell.dataTask?.resume()
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let reusableview = collectionView.dequeueReusableSupplementaryView(ofKind: "header", withReuseIdentifier: "HeaderCollectionReusableView", for: indexPath) as! HeaderCollectionReusableView
                 
        reusableview.title = viewModel?.genreAtIndex(indexPath.row)
            return reusableview
    }
    
    
    private func collectionView(collectionView: UICollectionView, didEndDisplayingCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        if let cell = cell as? MovieCollectionViewCell {
            cell.dataTask?.cancel()
        }
    }
}

extension HomeViewController: HomeViewModelDelegate {
    func reloadItems() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}
