//
//  DetailViewController.swift
//  COBSCCOMP202P-001
//
//  Created by Amanda Wickramasekera on 2023-01-12.
//

import UIKit
import SnapKit

class DetailViewController: UIViewController {
    
    
    let image : UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let titleLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    let caloriesLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 15, weight: .regular)
        return label
    }()
    let ingredientsLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 12, weight: .regular)
        return label
    }()
    
    let btnAddToFavs : UIButton = {
       let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        setupConstraint()
        
    }
    
    func setupConstraint(){
        
        self.view.addSubview(image)
        
        image.snp.makeConstraints{ make in
            make.top.equalToSuperview()
            make.height.equalTo(400)
            make.leading.trailing.equalToSuperview()
        }
        
        let btnFavImg = UIImage(named: "favorite")
        self.btnAddToFavs.setBackgroundImage(btnFavImg, for: .normal)

        let holder = UIStackView(arrangedSubviews: [titleLabel, caloriesLabel, ingredientsLabel])
        holder.spacing = 10
        holder.axis = .vertical
        self.view.addSubview(holder)
        self.view.addSubview(btnAddToFavs)
        
        holder.snp.makeConstraints{ make in
            make.top.equalTo(image.snp_topMargin).offset(10)
            make.leading.equalTo(view.snp_leadingMargin).offset(20)
            make.trailing.equalTo(view.snp_trailingMargin).offset(-20)
        }
        btnAddToFavs.snp.makeConstraints{ make in
            make.top.equalTo(holder.snp_bottomMargin).offset(10)
            make.leading.equalTo(view.snp_leadingMargin).offset(150)
            make.trailing.equalTo(view.snp_trailingMargin).offset(-150)
        }
    }
}

