//
//  ViewController.swift
//  VerificationEmails
//
//  Created by Миша on 01.04.2022.
//

import UIKit

class VerificationViewController: UIViewController {

    // MARK: - initial elements
    private var heightAnchorCollectionView = NSLayoutConstraint()
    private var statusLabelTopAnchor = NSLayoutConstraint()
    private let statusLabel = StatusLabel()
    private let mailTextField = MailTextField()
    private let verificationButton = VerificationButton()

    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let collectionView = MailCollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewFlowLayout())
    
    private lazy var stackView = UIStackView(
        arrangedSubviews: [mailTextField, verificationButton, collectionView],
        axis: .vertical,
        spacing: 20)
    
    private let verificationModel = VerificationModel()
    
    // MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        setupView()
        setupDelegates()
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil)

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        mailTextField.becomeFirstResponder()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)

        NotificationCenter.default.removeObserver(
            self, name: UIResponder.keyboardWillShowNotification,
            object: nil)
        NotificationCenter.default.removeObserver(
            self, name: UIResponder.keyboardWillHideNotification,
            object: nil)
    }
    
    override func viewDidLayoutSubviews() {
        statusLabelTopAnchor.constant = view.frame.height / 4
    }
    
    // MARK: - private methods-actions
    private func setupView(){
        view.addSubview(scrollView)
        scrollView.addSubview(containerView)
        containerView.addSubview(statusLabel)
        containerView.addSubview(stackView)
        containerView.addSubview(collectionView)
        
        verificationButton.addTarget(self, action: #selector(verificationButtonTapped), for: .touchUpInside)
    }
    
    private func setupDelegates(){
        collectionView.dataSource = self
        collectionView.selectMailDelegate = self
        mailTextField.textFieldDelegate = self
        mailTextField.textFieldShouldReturnAction = { [weak self] in
            guard let self = self, self.verificationButton.isEnabled else {return}
            self.verificationButtonTapped()
        }
    }
    
    @objc
    private func verificationButtonTapped(){
        guard let enteredEmail = mailTextField.text else {return}
        
        NetworkDataFetch.shared.fetchEmail(verifiableEmail: enteredEmail) { result, error in
            if error == nil {
                guard let result = result else {return}
                
                if result.success {
                    guard let didYouMeanError = result.didYouMean else {
                        
                        Alert.showResultAlert(
                            vc: self,
                            message: "Mail status - \(result.result). \n \(result.reasonDescription)")
                        return
                    }

                    Alert.showErrorAlert(vc: self, message: "Did you mean: \(didYouMeanError)") { [weak self] in
                        guard let self = self else {return}
                        self.mailTextField.text = didYouMeanError
                    }
                }
                
            } else {
                guard let errorDescription = error?.localizedDescription else {return}
                Alert.showResultAlert(vc: self, message: errorDescription)
            }
        }
    }
    
    @objc
    private func keyboardWillShow(notification: NSNotification){
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue{
            scrollView.contentOffset = CGPoint(x: 0, y: keyboardSize.height / 2)
        }
    }
    
    @objc
    private func keyboardWillHide(notification: NSNotification){
        scrollView.contentOffset = CGPoint(x: 0, y: 0)
    }
}

// MARK: - UICollectionViewDataSource
extension VerificationViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if verificationModel.filteredEmailsArray.isEmpty {
            heightAnchorCollectionView.constant = 50
            view.layoutIfNeeded()
        }
        return verificationModel.filteredEmailsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: MailCollectionViewCell.self),
                                                            for: indexPath) as? MailCollectionViewCell else { return UICollectionViewCell()}
        
        let mailLabelText = verificationModel.filteredEmailsArray[indexPath.row]

        if !verificationModel.filteredEmailsArray.isEmpty, collectionView.contentSize.height != 0 {
            heightAnchorCollectionView.constant = collectionView.contentSize.height
            view.layoutIfNeeded()
        }
        
        cell.setCellName(emailName: mailLabelText)
        return cell
    }
}


// MARK: - SelectProposedMailProtocol
extension VerificationViewController: SelectProposedMailProtocol {
    func selectProposedMail(indexPath: IndexPath) {

        guard let text = mailTextField.text else {return}
        
        verificationModel.getMailName(text: text)
        let fullEmailAddress = verificationModel.nameMail + verificationModel.filteredEmailsArray[indexPath.row]
        mailTextField.text = fullEmailAddress
        statusLabel.isValid = fullEmailAddress.isValid()
        verificationButton.isValid = fullEmailAddress.isValid()
        verificationModel.filteredEmailsArray = []
        collectionView.reloadData()
    }
}


// MARK: - ActionsMailTextFieldProtocol
extension VerificationViewController: ActionsMailTextFieldProtocol {
    func typingText(text: String) {
        statusLabel.isValid = text.isValid()
        verificationButton.isValid = text.isValid()
        verificationModel.getFilteredEmail(text: text)
        !text.isEmpty ? collectionView.reloadData() : statusLabel.setDefaultSettings()
    }
    
    func cleanOutTextField() {
        statusLabel.setDefaultSettings()
        verificationButton.setDefaultSettings()
        verificationModel.filteredEmailsArray = []
        collectionView.reloadData()
    }
}

// MARK: - Constraints
extension VerificationViewController {
    
    private func setupConstraints(){

        heightAnchorCollectionView = collectionView.heightAnchor.constraint(equalToConstant: 50)
        statusLabelTopAnchor = statusLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: view.frame.height / 4)
        heightAnchorCollectionView.isActive = true
        statusLabelTopAnchor.isActive = true
        
        let constraints = [
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
            
            containerView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 0),
            containerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 0),
            containerView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: 0),
            containerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 0),
            containerView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: 0),

            statusLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            statusLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            
            mailTextField.heightAnchor.constraint(equalToConstant: 50),

            stackView.topAnchor.constraint(equalTo: statusLabel.bottomAnchor, constant: 2),
            stackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            
            collectionView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 20),
            collectionView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            collectionView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            collectionView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 0),
        ]
        NSLayoutConstraint.activate(constraints)
    }
}

