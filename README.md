# GameDeals

Aplicativo iOS de estudo para praticar UIKit enquanto apresenta promoções de jogos da Steam no Brasil. A ideia é construir a experiência aos poucos, usando componentes nativos e uma API pública da loja.

## O que já funciona

- Lista promoções atuais da Steam para a região brasileira.
- Exibe imagem, nome, desconto e preço em reais.
- Ordena por maior desconto, menor preço ou nome.
- Atualiza a lista com gesto de puxar para atualizar.
- Abre a página do jogo na Steam ao tocar em uma oferta.
- Mostra estados de carregamento e erro, com opção para tentar novamente.

## Tecnologias e conceitos

- Swift e UIKit, com telas construídas programaticamente.
- `URLSession` e `async/await` para chamadas de rede.
- `Codable` para decodificar a resposta da Steam.
- `UITableView` e células reutilizáveis.
- Auto Layout e `UIStackView`.

## API

As ofertas são obtidas do endpoint público de categorias em destaque da Steam, filtrando a categoria de promoções:

```text
https://store.steampowered.com/api/featuredcategories?cc=br&l=portuguese
```

O aplicativo não exige chave de API. A disponibilidade e o formato do endpoint são definidos pela Steam e podem mudar.

## Como executar

1. Abra `GameDeals.xcodeproj` no Xcode.
2. Selecione o scheme **GameDeals** e um simulador ou dispositivo iOS.
3. Execute com **⌘R**.

É necessária uma conexão com a internet para carregar ofertas e imagens. O deployment target configurado no projeto é iOS 27.0.

## Estrutura

```text
GameDeals/
├── App/                         # AppDelegate e SceneDelegate
├── Extensions/                  # Helpers de Auto Layout
├── Models/                      # Modelos de dados
├── Services/                    # Integração com a API da Steam
└── Screens/
    ├── Controllers/             # View controllers
    └── Views/                   # Views e componentes UIKit
```

As abas de busca e lojas ainda são espaços para estudos e melhorias futuras.
