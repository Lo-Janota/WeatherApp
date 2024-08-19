//
//  ViewController.swift
//  Weather App
//
//  Created by Lorenzo Janota on 17/08/24.
//

import UIKit

class ViewController: UIViewController {
    // Uma lazy var em Swift é uma propriedade que só é criada quando você a usa pela primeira vez. Isso economiza memória e processamento, especialmente para coisas que podem demorar ou não ser usadas sempre.
    //Instancio ela, coloco as configurações e depois retorno a view
    private lazy var customView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false //"Tradução" da Constraints para a UIView, podendo assim aparecer na tela normalmente
        return view
        
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
    }

    /* Algumas questões da ViewController
    
    //Executado toda vez que a ViewController aparece na tela (carregada na tela)
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    //Executado antes da ViewController aparecer na tela (carregar na tela)
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    //Executado quando a ViewController vai desaparecer da tela
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    //Executado quando a ViewController já desapareceu da tela
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    */
    
    private func setupView(){
        //Colocando o fundo como vermelho
        view.backgroundColor = UIColor.red
        //É importante adicionar a subview à hierarquia de views antes de configurar as constraints. Isso acontece porque as constraints funcionam apenas quando a view está presente na hierarquia de views.
        setHierarchy()
        setConstraints()
    }
    
    //Função para adicionar uma hierarquia entra as views
    private func setHierarchy(){
        view.addSubview(customView) //Adicionando na tela
    }
    
    private func setConstraints() {
        //Ativar um conjunto de restrições (constraints) de layout para a customView, ajustando sua posição e tamanho dentro da view principal, utilizando o safeAreaLayoutGuide. (PENSE SEMPRE COMO UM PLANO CARTESIANO!!!)
        NSLayoutConstraint.activate([
            //Define que a parte superior da customView deve estar a 100 pontos abaixo do topo da safeArea da view.
            customView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            //Define que a borda esquerda da customView deve estar a 50 pontos à direita da borda esquerda da safeArea da view.
            customView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 50),
            //Define que a borda direita da customView deve estar a -50 pontos à esquerda da borda direita da safeArea da view.
            customView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -50),
            //Define que a parte inferior da customView deve estar a -100 pontos acima da borda inferior da safeArea da view.
            customView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -100)
        ])
    }
}


