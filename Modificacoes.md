# Introdução

Foram dados dois códigos (`alarm_sensor` e `bayes_net_interpreter`), cada um com um intuito diferente, mas complementar no que diz respeito à probabilidade de um dado ocorrer. O primeiro código implementa uma Rede Bayesiana para modelar um sistema de alarme com sensores, enquanto o segundo implementa um interpretador para raciocínio em Redes Bayesianas, permitindo calcular probabilidades condicionais de eventos dados outros eventos observados, usando as definições de probabilidades e estrutura da rede.

Compilando esta versão inicial do código, sem alterações, temos como saída:

![image](https://github.com/user-attachments/assets/87b3efe8-e8f1-4fe1-9255-75bfaeafa909)

---

# Proposta de Modificação: Inclusão do Evento Terremoto

Com isso estabelecido, é proposto então a adição de um evento para analisar o caso de terremotos — já que o alarme já tratava de roubo e relâmpagos. Para isso foram feitas modificações no `alarm_sensor`:

1. Adicionar o evento `earthquake` (terremoto)  
2. Modificar as relações `parent/2`  
3. Modificar as probabilidades condicionais `p/3` para o sensor  

---

# Modificações implementadas

Para incluir o evento de alerta de terremoto no seu código, você precisará modificar tanto a estrutura da rede Bayesiana (`alarm_sensor.pl`) quanto, possivelmente, o interpretador (`bayes_net_interpreter.pl`), dependendo de como você quer que o terremoto interaja com os outros eventos.

Aqui estão os passos e as modificações necessárias:

## 1. Modificar `alarm_sensor.pl`

### a. Adicionar o evento `earthquake` (terremoto):

```prolog
% Novos fatos para o terremoto
p(earthquake, 0.0005).  % Probabilidade a priori de um terremoto (muito baixa)
````

### b. Modificar as relações parent/2: Decida como o terremoto afeta os outros eventos. Aqui estão algumas opções:

Opção 1: Terremoto afeta diretamente o sensor:
```prolog
parent(burglary, sensor).
parent(lightning, sensor).
parent(earthquake, sensor).  % Terremoto afeta o sensor
parent(sensor, alarm).
parent(sensor, call).
```

Opção 2: Terremoto afeta diretamente o alarme (e possivelmente a chamada):
```prolog
parent(burglary, sensor).
parent(lightning, sensor).
parent(sensor, alarm).
parent(earthquake, alarm).  % Terremoto afeta o alarme
parent(sensor, call).
parent(earthquake, call).  % Terremoto afeta a chamada
```

Opção 3: Terremoto causa um novo evento (ex: falha de energia) que afeta o sensor/alarme:
```prolog
parent(earthquake, power_failure).  % Terremoto causa falha de energia
p(power_failure, 0.01).  % Probabilidade de falha de energia
parent(power_failure, sensor).  % Falha de energia afeta o sensor
parent(sensor, alarm).
parent(sensor, call).
```

Para este exemplo, vamos usar a Opção 1, onde o terremoto afeta diretamente o sensor.

### c. Modificar as probabilidades condicionais p/3 para o sensor:

Você precisa adicionar probabilidades condicionais para o sensor considerando o earthquake. Isso aumentará a complexidade, pois agora você tem 2^3 = 8 combinações de pais (burglary, lightning, earthquake).

```prolog
% Probabilidades condicionais para o sensor (com terremoto)
p(sensor, [burglary, lightning, earthquake], 0.95).
p(sensor, [burglary, lightning, not earthquake], 0.9).
p(sensor, [burglary, not lightning, earthquake], 0.92).
p(sensor, [burglary, not lightning, not earthquake], 0.9).
p(sensor, [not burglary, lightning, earthquake], 0.2).
p(sensor, [not burglary, lightning, not earthquake], 0.1).
p(sensor, [not burglary, not lightning, earthquake], 0.05).
p(sensor, [not burglary, not lightning, not earthquake], 0.001).
```

Essas probabilidades são exemplos e devem ser ajustadas de acordo com o seu conhecimento do domínio.

# Exemplo Completo de alarm_sensor.pl com Terremoto

```prolog
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Baysian Network for sensor alarm with earthquake
%
% Coder: Edjard Mota
% Date   : 15/05/2025
% Source: Prolog Programming for AI, Ivan Bratko, 4th edition
%          Chapter 15 - KR and Expert Systems
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%-------------------------------------------------------------------
parent(burglary, sensor).
parent(lightning, sensor).
parent(earthquake, sensor).  % Terremoto afeta o sensor
parent(sensor, alarm).
parent(sensor, call).

p(burglary, 0.001).
p(lightning, 0.02).
p(earthquake, 0.0005).  % Probabilidade a priori de um terremoto

% Probabilidades condicionais para o sensor (com terremoto)
p(sensor, [burglary, lightning, earthquake], 0.95).
p(sensor, [burglary, lightning, not earthquake], 0.9).
p(sensor, [burglary, not lightning, earthquake], 0.92).
p(sensor, [burglary, not lightning, not earthquake], 0.9).
p(sensor, [not burglary, lightning, earthquake], 0.2).
p(sensor, [not burglary, lightning, not earthquake], 0.1).
p(sensor, [not burglary, not lightning, earthquake], 0.05).
p(sensor, [not burglary, not lightning, not earthquake], 0.001).

p(alarm, [sensor], 0.95).
p(alarm, [not sensor], 0.001).
p(call, [sensor], 0.9).
p(call, [not sensor], 0.0).
```

Testando

Após modificar os arquivos, recarregue-os no Prolog:

```smd
?- [bayes_net_interpreter].
true.

?- [alarm_sensor].
true.
```

E faça consultas para ver como o terremoto afeta as probabilidades:

```smd
?- prob(burglary, [call, earthquake], P).  % Arrombamento dado chamada e terremoto
P = ...

?- prob(alarm, [earthquake], P).  % Alarme dado terremoto
P = ...

?- prob(earthquake, [alarm], P).  % Terremoto dado alarme
P = ...
```

# Resultados

Com os ajustes aplicados, compilando agora os códigos para análise de probabilidades no SWISH-Prolog, foram obtidas as seguintes saídas:

![image](https://github.com/user-attachments/assets/be473a10-de89-4aea-a2fb-f94048b63fe1)
