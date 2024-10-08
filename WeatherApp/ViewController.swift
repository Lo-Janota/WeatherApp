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
        view.backgroundColor = UIColor.contrastColor
        view.layer.cornerRadius = 20 //Serve para deixar os cantos arredondados
        return view
    }()
    
    private lazy var cityLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20)
        label.text = "Ribeirão Preto"
        label.textAlignment = .center //Alinhamento da label
        label.textColor = UIColor.primaryColor //Setamos no "Assets" como newColor e puxamos para cá
        return label
    }()
    
    private lazy var temperatureLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 70, weight: .bold)
        label.text = "25°C"
        label.textAlignment = .left//Alinhamento da label
        label.textColor = UIColor.primaryColor //Setamos no "Assets" como newColor e puxamos para cá
        return label
    }()
    
    private lazy var weatherIcon: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.image = UIImage(named: "sunIcon") //Definindo a imagem pelo Asset (como no background)
        imageView.contentMode = .scaleAspectFit //Redimensionando a imagem -> Repeita a proproção e mostre o icone inteiro
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var humidityLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Umidade"
        label.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        label.textColor = UIColor.contrastColor
        return label
    }()
    
    private lazy var humidityValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "1000mm"
        label.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        label.textColor = UIColor.contrastColor
        return label
    }()
    
    private lazy var humidityStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [humidityLabel, humidityValueLabel]) //Adicionando as hierarquias
        stackView.axis = .horizontal //Colocar a StackView na horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var windLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Vento"
        label.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        label.textColor = UIColor.contrastColor
        return label
    }()
    
    private lazy var windValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "10km/h"
        label.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        label.textColor = UIColor.contrastColor
        return label
    }()
    
    private lazy var windStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [windLabel, windValueLabel])
        stackView.axis = .horizontal //Colocar a StackView na horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    //Criando a StackView vertical
    private lazy var statsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [humidityStackView, windStackView])
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 3 //Espaçamento entre as duas stacks
        stackView.backgroundColor = UIColor.softGrayColor
        stackView.layer.cornerRadius = 10
        stackView.isLayoutMarginsRelativeArrangement = true //Setando como TRUE, podemos customizar as nossas margens
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 12, leading: 24, bottom: 12, trailing: 24)
        return stackView
    }()
        
    private lazy var hourlyForecastLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.contrastColor
        label.text = "PREVISÃO POR HORA"
        label.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        label.textAlignment = .center
        return label
    }()
    
    //Permite exibir e gerenciar uma coleção de itens em uma interface de maneira altamente customizável, organizando-os em uma grade ou lista. O UICollectionView é particularmente útil quando você precisa exibir um grande número de itens que podem ser organizados de forma flexível.
    private lazy var houryCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal //Colando o layout para scrolar apenas horizontalmente
        layout.itemSize = CGSize(width: 67, height: 84)
        layout.sectionInset = UIEdgeInsets(top: .zero, 
                                           left: 10,
                                           bottom: .zero,
                                           right: 10) //Margens das posições
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        //Registrando uma célula personalizada
        collectionView.register(HourlyForecastCollectionViewCell.self, forCellWithReuseIdentifier: HourlyForecastCollectionViewCell.identifier)
        return collectionView
    }()
    
    private lazy var dailyForecastLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.contrastColor
        label.text = "PRÓXIMOS DIAS"
        label.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var dailyForecastTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        tableView.dataSource = self
        tableView.register(DailyForecastTableViewCell.self, forCellReuseIdentifier: DailyForecastTableViewCell.identifier)
        return tableView
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
        view.addSubview(statsStackView) //Adicionando a minha stackview vertical para compor as duas stackview horizontal
        view.addSubview(hourlyForecastLabel)
        view.addSubview(houryCollectionView)
        view.addSubview(dailyForecastLabel)
        view.addSubview(dailyForecastTableView)
        
        headerView.addSubview(cityLabel) //Adicionando como subview pois a label (cityLabel) esta dentro da headerView
        headerView.addSubview(temperatureLabel)
        headerView.addSubview(weatherIcon)
        
        /* Pode adicionar dessa maneira também
         humidityStackView.addArrangedSubview(humidityLabel)//Adicionar uma subview mas no fluxo da stackview
         humidityStackView.addArrangedSubview(humidityValueLabel)
         */
        
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
            headerView.heightAnchor.constraint(equalToConstant: 155)
        ])
        
        NSLayoutConstraint.activate([
            cityLabel.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 15),
            cityLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 15),
            cityLabel.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -15),
            cityLabel.heightAnchor.constraint(equalToConstant: 20),
            
            temperatureLabel.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: 15),
            temperatureLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 26),
            
            weatherIcon.heightAnchor.constraint(equalToConstant: 86),
            weatherIcon.widthAnchor.constraint(equalToConstant: 86),
            weatherIcon.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -26),
            weatherIcon.centerYAnchor.constraint(equalTo: temperatureLabel.centerYAnchor), //Alinhamento com a constraints da temperatureLabel para que elas fiquem alinhas pelo eixo "y" (altura).
            weatherIcon.leadingAnchor.constraint(equalTo: temperatureLabel.trailingAnchor, constant: 15)
        ])
        
        NSLayoutConstraint.activate([
            statsStackView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 24),
            statsStackView.widthAnchor.constraint(equalToConstant: 206), //Largura
            statsStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            hourlyForecastLabel.topAnchor.constraint(equalTo: statsStackView.bottomAnchor, constant: 29),
            hourlyForecastLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 35),
            hourlyForecastLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -35),
            
            houryCollectionView.topAnchor.constraint(equalTo: hourlyForecastLabel.bottomAnchor, constant: 22),
            houryCollectionView.heightAnchor.constraint(equalToConstant: 84),
            houryCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            houryCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            dailyForecastLabel.topAnchor.constraint(equalTo: houryCollectionView.bottomAnchor, constant: 29),
            dailyForecastLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 35),
            dailyForecastLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -35),
            
            dailyForecastTableView.topAnchor.constraint(equalTo: dailyForecastLabel.bottomAnchor, constant: 15),
            dailyForecastTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            dailyForecastTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            dailyForecastTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

//Extensão para a ViewController, fizemos isso pois na nossa collectionView colocamos ela para dar um "dataSource = self" (própria instância atual)
extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HourlyForecastCollectionViewCell.identifier, for: indexPath)
        return cell
    }
}

extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DailyForecastTableViewCell.identifier, for: indexPath)
        return cell
    }
    
}

