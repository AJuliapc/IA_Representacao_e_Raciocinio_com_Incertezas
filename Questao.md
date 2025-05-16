# Questão

(O Exercício 13.MARB pede que você prove isso.) Por exemplo, a variável *Burglary* é independente de *JohnCalls* e *MaryCalls*, dado *Alarm* e *Earthquake*. Essa propriedade é ilustrada na Figura 13.4(b). A propriedade do *Markov blanket* torna possíveis algoritmos de inferência que usam processos de amostragem estocástica completamente locais e distribuídos, conforme explicado na Seção 13.4.2.

A questão de independência condicional mais geral que se pode fazer em uma rede Bayesiana é se um conjunto de nós X é condicionalmente independente de outro conjunto Y, dado um terceiro conjunto Z. Isso pode ser determinado eficientemente examinando a rede Bayesiana para ver se Z d-separa X e Y. O processo funciona da seguinte forma:

1.  Considere apenas o subgrafo ancestral consistindo de X, Y, Z e seus ancestrais.
2.  Adicione links entre qualquer par de nós não ligados que compartilham um filho comum; agora temos o chamado grafo moral.
3.  Substitua todos os links direcionados por links não direcionados.
4.  Se Z bloqueia todos os caminhos entre X e Y no grafo resultante, então Z d-separa X e Y. Nesse caso, X é condicionalmente independente de Y, dado Z. Caso contrário, a rede Bayesiana original não requer independência condicional.

Em resumo, então, d-separação significa separação no subgrafo ancestral, moralizado e não direcionado. Aplicando a definição à rede de roubo na Figura 13.2, podemos deduzir que *Burglary* e *Earthquake* são independentes dado o conjunto vazio (isto é, eles são absolutamente independentes); que eles não são necessariamente condicionalmente independentes dado *Alarm*; e que *JohnCalls* e *MaryCalls* são condicionalmente independentes dado *Alarm*. Observe também que a propriedade do *Markov blanket* segue diretamente da propriedade de d-separação, já que o *Markov blanket* de uma variável a d-separa de todas as outras variáveis.

# Resposta
Primeiro, vamos separar cada conceito e depois, buscar o objetivo de demonstrar o conceito de independência condicional em redes Bayesianas usando o critério de d-separação

1. Redes Bayesianas
Uma Rede Bayesiana é um grafo direcionado acíclico (DAG) que representa variáveis aleatórias e suas dependências condicionais através de arestas. Cada nó representa uma variável, e as setas indicam dependências causais ou condicionais.

Exemplo: Rede Bayesiana do Tempo e Trânsito
Variáveis:
- Chuva (C): Está chovendo ou não. (Sim/Não)
- Engarrafamento (E): Há engarrafamento no trânsito? (Sim/Não)
- Atraso (A): Você se atrasou para o trabalho? (Sim/Não)
- Alarme (L): O alarme do seu carro disparou? (Sim/Não)
No caso, teríamos uma Rede Bayesiana representada por C → E → A → L


2. Independência condicional
Duas variáveis 𝑋 e 𝑌 são condicionalmente independentes dado uma terceira variável 𝑍 se, uma vez conhecido 𝑍, o conhecimento de 𝑋 não traz informação adicional sobre 𝑌, e vice-versa. Em redes Bayesianas, a estrutura do grafo pode indicar quais variáveis são independentes condicionalmente, o que ajuda a simplificar o modelo e o cálculo das probabilidades.

Exemplo: Situação de Chuva
Imagine as seguintes variáveis:
- 𝑋: Está chovendo.
- 𝑌: O gramado está molhado.
- 𝑍: Foi ligado o sistema de irrigação do jardim.

Relações:
- Se está chovendo, o gramado fica molhado.
- Se o sistema de irrigação foi ligado, o gramado também fica molhado.
- Ou seja: 𝑋 (chuva) e 𝑍 (irrigação) são causas possíveis para 𝑌 (gramado molhado).

Então:
- 𝑋 e 𝑍 são independentes quando não sabemos o estado de 𝑌.
- 𝑋 e 𝑍 são dependentes condicionados em 𝑌 (sabendo que o gramado está molhado).

