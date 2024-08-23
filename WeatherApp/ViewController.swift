//
//  ViewController.swift
//  Weather App
//
//  Created by Lorenzo Janota on 17/08/24.
//

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

import UIKit

class ViewController: UIViewController {
    // Uma lazy var em Swift é uma propriedade que só é criada quando você a usa pela primeira vez. Isso economiza memória e processamento, especialmente para coisas que podem demorar ou não ser usadas sempre.
    //Instâncio ela, coloco as configurações e depois retorno a view
    private lazy var backgroundView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.image = UIImage(named: "background") //Nome da imagem colocado no "Assets"
        imageView.contentMode = .scaleAspectFill //Redimensionamento da imagem na tela -> Respeita a proporção mas ocupa todo o retangulo (tela)
        imageView.translatesAutoresizingMaskIntoConstraints = false //"Tradução" da Constraints para a UIImageView, podendo assim aparecer na tela normalmente
        return imageView
        
    }()
    
    //Criação da parte branca (onde mostra a localização e a temperatura)
    private lazy var headerView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 20 //Serve para deixar os cantos arredondados
        return view
    }()
    
    private lazy var cityLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20)
        label.text = "Ribeirão Preto"
        label.textAlignment = .center //Alinhamento da label
        label.textColor = UIColor(named: "primaryColor") //Setamos no "Assets" como newColor e puxamos para cá
        return label
    }()
    
    private lazy var temperatureLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 70, weight: .bold)
        label.text = "25°C"
        label.textAlignment = .left//Alinhamento da label
        label.textColor = UIColor(named: "primaryColor") //Setamos no "Assets" como newColor e puxamos para cá
        return label
    }()
    
    private lazy var weatherIcon: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.image = UIImage(named: "sunIcon") //Definindo a imagem pelo Asset (como no background)
        imageView.contentMode = .scaleAspectFit //Redimensionando a imagem -> Repeita a proproção e mostre o icone inteiro
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
    }

    
    private func setupView(){
        //Colocando o fundo como vermelho
        view.backgroundColor = UIColor.red
        //É importante adicionar a subview à hierarquia de views antes de configurar as constraints. Isso acontece porque as constraints funcionam apenas quando a view está presente na hierarquia de views.
        setHierarchy()
        setConstraints()
    }
    
    //Função para adicionar uma hierarquia entra as views
    private func setHierarchy(){
        //Adicionando na tela
        view.addSubview(backgroundView)
        view.addSubview(headerView)
        headerView.addSubview(cityLabel) //Adicionando como subview pois a label (cityLabel) esta dentro da headerView
        headerView.addSubview(temperatureLabel)
        headerView.addSubview(weatherIcon)
    }
    
    private func setConstraints() {
        //Ativar um conjunto de restrições (constraints) de layout para a customView, ajustando sua posição e tamanho dentro da view principal, utilizando o safeAreaLayoutGuide. (PENSE SEMPRE COMO UM PLANO CARTESIANO!!!) -> De uma olhada na Documentação pois tem muitas maneiras
        NSLayoutConstraint.activate([
            //Define que a parte superior da customView deve estar abaixo do topo da view principal.
            backgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            //Define que a borda esquerda da customView deve estar a direita da borda esquerda da view principal.
            backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            //Define que a borda direita da customView deve estar à esquerda da borda direita da view principal.
            backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            //Define que a parte inferior da customView deve estar acima da borda inferior da da view principal.
            backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 35),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -35),
            headerView.heightAnchor.constraint(equalToConstant: 169)
        ])
        
        NSLayoutConstraint.activate([
            cityLabel.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 15),
            cityLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 15),
            cityLabel.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -15),
            cityLabel.heightAnchor.constraint(equalToConstant: 20),
            
            temperatureLabel.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: 21),
            temperatureLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 26),
            
            weatherIcon.heightAnchor.constraint(equalToConstant: 86),
            weatherIcon.widthAnchor.constraint(equalToConstant: 86),
            weatherIcon.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -26),
            weatherIcon.centerYAnchor.constraint(equalTo: temperatureLabel.centerYAnchor), //Alinhamento com a constraints da temperatureLabel para que elas fiquem alinhas pelo eixo "y" (altura).
            weatherIcon.leadingAnchor.constraint(equalTo: temperatureLabel.trailingAnchor, constant: 15)
        ])
        
        
    }
}


