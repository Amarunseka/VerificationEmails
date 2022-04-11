//
//  MailCollectionView.swift
//  VerificationEmails
//
//  Created by Миша on 01.04.2022.
//

import UIKit

protocol SelectProposedMailProtocol: AnyObject {
    func selectProposedMail(indexPath: IndexPath)
}

class MailCollectionView: UICollectionView {
    
    // MARK: - initial elements
    weak var selectMailDelegate: SelectProposedMailProtocol?
    
    // MARK: - life cycle
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        

        configure()
        register(
            MailCollectionViewCell.self,
            forCellWithReuseIdentifier: String(describing: MailCollectionViewCell.self))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - private methods-actions
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        delegate = self
        backgroundColor = .none
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension MailCollectionView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectMailDelegate?.selectProposedMail(indexPath: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width / 2 - 5, height: 40)
    }
}
