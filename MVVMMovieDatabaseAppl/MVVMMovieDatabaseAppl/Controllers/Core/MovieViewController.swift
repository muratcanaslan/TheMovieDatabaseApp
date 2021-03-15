//
//  ViewController.swift
//  MVVMMovieDatabaseAppl
//
//  Created by Murat Can on 11.03.2021.
//

import UIKit

//MARK: - Section Type
enum MovieSectionType {
    case topRated(viewModels: [TopRatedCellViewModel])
    case popular(viewModels: [PopularCellViewModel])
    
    var title: String {
        switch self {
        case .topRated:
            return "Top Rated Movies"
        case .popular:
            return "Popular Movies"
        }
    }
}

class MovieViewController: UIViewController {
    private var collectionView: UICollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewCompositionalLayout { sectionIndex, _ -> NSCollectionLayoutSection? in
            return createSectionLayout(section: sectionIndex)
        }
    )
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.tintColor = .red
        spinner.hidesWhenStopped = true
        return spinner
    }()
    
    private var sections = [MovieSectionType]()
    private var topRated = [Movie]()
    private var popular = [Movie]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(spinner)
        configureCollectionView()
        fetchData()
    }
   
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }
    
    //MARK: - NSCollectionLayoutSection
    private static func createSectionLayout(section: Int) -> NSCollectionLayoutSection {
        //MARK: - Supplementary Item
        let supplementaryViews = [ NSCollectionLayoutBoundarySupplementaryItem(
                                    layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                                       heightDimension: .absolute(50)),
                                    elementKind: UICollectionView.elementKindSectionHeader,
                                    alignment: .top)
        ]
        
        //MARK: - Cells
        switch section {
        case 0:
            let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                                                 heightDimension: .fractionalHeight(1.0)))
            item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
            //Vertical Group in Horizantal group
            let verticalGroup  = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                                                                     heightDimension: .absolute(390)),
                                                                  subitem: item,
                                                                  count: 3)
            //Horizontal Group
            let horizontalGroup  = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9),
                                                                                                         heightDimension: .absolute(390)),
                                                                      subitem: verticalGroup,
                                                                      count: 1)
            //Section
            let section = NSCollectionLayoutSection(group: horizontalGroup)
            section.orthogonalScrollingBehavior = .groupPaging
            section.boundarySupplementaryItems = supplementaryViews
            return section
        case 1:
            //Item
            let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .absolute(300),
                                                                                 heightDimension: .absolute(300)))
            item.contentInsets = NSDirectionalEdgeInsets(top: 15, leading: 15, bottom: 15, trailing: 15)
            //Vertical group in Horizantal grouo
            let verticalGroup  = NSCollectionLayoutGroup.vertical (layoutSize: NSCollectionLayoutSize(widthDimension: .absolute(300),
                                                                                                      heightDimension: .absolute(400)),
                                                                   subitem: item,
                                                                   count: 2)
            //Horizontal Group
            let horizontalGroup  = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .absolute(300),
                                                                                                         heightDimension: .absolute(400)),
                                                                      subitem: verticalGroup,
                                                                      count: 1)
            //Section
            let section = NSCollectionLayoutSection(group: horizontalGroup)
            section.orthogonalScrollingBehavior = .groupPaging
            section.boundarySupplementaryItems = supplementaryViews
            return section
        default:
            //Item
            let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                                                 heightDimension: .fractionalHeight(1.0)))
            item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
            //Vertical Group in Horizantal group
            let group  = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                                                             heightDimension: .absolute(390)),
                                                          subitem: item,
                                                          count: 1)
            //Section
            let section = NSCollectionLayoutSection(group: group)
            section.boundarySupplementaryItems = supplementaryViews
            return section
        }
    }
    
    private func fetchData() {
        let group = DispatchGroup()
        group.enter()
        group.enter()
        var movie: MovieResponse?
        var moviePopular: MovieResponse?
        ServieManager.shared.getMovieTopRated { response in
            defer {
                group.leave()
            }
            switch response {
            case .success(let model):
                movie = model
            case .failure(let error):
                print("Top rated movie error \(print(error.localizedDescription))")
            }
        }
        
        ServieManager.shared.getMoviePopular { response in
            defer {
                group.leave()
            }
            switch response {
            case .success(let model):
                moviePopular = model
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        group.notify(queue: .main) {
            guard let movies = movie?.results else { return }
            guard let moviesPopular = moviePopular?.results else { return }
            self.configureModels(topRatedMovie: movies, popularMovie: moviesPopular)
        }
    }
    
    private func configureCollectionView() {
        view.addSubview(collectionView)
        collectionView.register(TopRatedCollectionViewCell.self,
                                forCellWithReuseIdentifier: TopRatedCollectionViewCell.identifier)
        collectionView.register(PopularCollectionViewCell.self,
                                forCellWithReuseIdentifier: PopularCollectionViewCell.identifier)
        collectionView.register(TitleCollectionReusableView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: TitleCollectionReusableView.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .systemBackground
    }
    
    private func configureModels(topRatedMovie: [Movie], popularMovie: [Movie]) {
        self.topRated = topRatedMovie
        self.popular = popularMovie
        //Configure models
        sections.append(.topRated(viewModels: topRated.compactMap({
            return TopRatedCellViewModel(name: $0.title ?? "-",
                                         artworkURL: $0.posterPath,
                                         date: "Release : \(String.formattedDate(string: $0.releaseDate ?? ""))",
                                         rating: $0.rating ?? 0.0)
        })))
        sections.append(.popular(viewModels: popular.compactMap({
            return PopularCellViewModel(artworkURL: $0.posterPath,
                                        title: $0.title,
                                        rate: $0.rating ?? 0.0)
        })))
        //Reload data
        collectionView.reloadData()
    }
}

extension MovieViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let section = sections[indexPath.section]
        switch section {
        case .topRated:
            let movie = topRated[indexPath.row]
            let vc = MovieDetailViewController(movie: movie)
            vc.title = movie.title
            vc.navigationItem.largeTitleDisplayMode = .never
            navigationController?.pushViewController(vc, animated: true)
        case .popular:
            let movie = popular[indexPath.row]
            let vc = MoviePopularDetailViewController(movie: movie)
            vc.title = movie.title
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension MovieViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: TitleCollectionReusableView.identifier, for: indexPath) as? TitleCollectionReusableView, kind == UICollectionView.elementKindSectionHeader else {
            return UICollectionReusableView()
        }
        let section = indexPath.section
        let title = sections[section].title
        header.configure(with: title)
        return header
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let type = sections[section]
        switch type {
        case .topRated(let viewModels):
            return viewModels.count
        case .popular(let viewModels):
            return viewModels.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let type = sections[indexPath.section]
        switch type {
        case .topRated(let viewModels):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TopRatedCollectionViewCell.identifier, for: indexPath) as? TopRatedCollectionViewCell else {
                return UICollectionViewCell()
            }
            let viewModel = viewModels[indexPath.row]
            cell.configure(with: viewModel)
            return cell
        case .popular(let viewModels):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PopularCollectionViewCell.identifier, for: indexPath) as? PopularCollectionViewCell else {
                return UICollectionViewCell()
            }
            let viewModel = viewModels[indexPath.row]
            cell.configure(with: viewModel)
            return cell
        }
    }
}
