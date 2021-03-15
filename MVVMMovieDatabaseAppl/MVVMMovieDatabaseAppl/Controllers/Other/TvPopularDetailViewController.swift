//
//  TvPopularDetailViewController.swift
//  MVVMMovieDatabaseAppl
//
//  Created by Murat Can on 13.03.2021.
//

import UIKit

import UIKit

class TvPopularDetailViewController: UIViewController {
    
    private var tv: Tv
    private var viewModels = [DetailViewModel]()
    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewCompositionalLayout(sectionProvider: { (_, _) -> NSCollectionLayoutSection? in
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0)))
        
        item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        let group = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(60)), subitem: item, count: 1)
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [NSCollectionLayoutBoundarySupplementaryItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(1)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)]
        return section
    }))

    init(tv: Tv) {
        self.tv = tv
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .secondarySystemBackground
        view.addSubview(collectionView)
        collectionView.register(DetailCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: DetailCollectionReusableView.identifier)
        collectionView.register(DetailCellCollectionViewCell.self, forCellWithReuseIdentifier: DetailCellCollectionViewCell.identifier)
        collectionView.dataSource = self
        fetchData()

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }
    
    private func fetchData() {
        ServieManager.shared.getTvPopularDetail(for: tv) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    print(error.localizedDescription)
                case .success(let model):
                    guard let model = model else { return }
                    self.tv = model
                    self.collectionView.reloadData()
                }
            }
            
        }
        
        ServieManager.shared.getTVCredit(for: tv) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    print(error.localizedDescription)
                case .success(let model):
                    self.viewModels = model.cast.compactMap({
                        DetailViewModel(name: $0.name,
                                        artist: $0.character)
                    })
                    self.collectionView.reloadData()
                }
            }
        }
        
    }
}

extension TvPopularDetailViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailCellCollectionViewCell.identifier, for: indexPath) as? DetailCellCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.configure(with: viewModels[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: DetailCollectionReusableView.identifier, for: indexPath) as? DetailCollectionReusableView, kind == UICollectionView.elementKindSectionHeader  else {
            return UICollectionReusableView()
        }
        let headerViewModel = MovieDetailCollectionViewCellViewModel(name: tv.name ?? "",
                                                                     date: "Release Date: \(String.formattedDate(string: tv.releaseDate ?? ""))",
                                                                     rating: tv.rating ?? 0.0,
                                                                     artworkURL: tv.posterPath,
                                                                     overview: tv.overview)
        header.configure(with: headerViewModel)
        return header
    }
    
    
}

