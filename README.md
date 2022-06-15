# AlkeParking - Questões

## Exercicio 1

**Q1.1:** Por que vehicles é definido como um Set?

**A:** O atributo foi definido como Set pois ele garante a unicidade dos elementos.

##

**Q1.2:** Lembre-se das diferenças entre os Set e os Array. Poderia haver dois veículos idênticos?

**A:** Não poderia haver dois veiculos identicos.

&nbsp;

## Exercicio 2

**Q2.1:** Pode mudar o tipo de veículo no tempo? Deve ser definido como variável ou como constante no Vehicle?

**A:** Não se pode mudar o tipo de veiculos, por isso é utilizado uma constante.

##

**Q2.2:** Qual elemento do controle de fluxo poderia ser útil determinar a tarifa de cada veículo na computed property: ciclo for, if ou switch?

**A:** A melhor opção foi utilizar o Switch, pois desta forma podemos definir facilmente todos os casos possiveis, além de melhorar a legibilidade do código.

&nbsp;

## Exercicio 3

**Q3.1:** Onde devem ser adicionadas as propriedades, em Parkable, Vehicle ou em ambos?

**A:** As propriedades devem ser adicionadas em Parkable para que possam ser utilizadas por qualquer veiculo, ou por qualquer nova estrutura que se encaixa no contexto de estacionamento.

**Q3.2:** O cartão de desconto é opcional, ou seja, um veículo pode não ter cartão e seu valor será nil. Qual tipo de dados do Swift permite ter esse comportamento?

**A:** Utilizamos um atributo opcional (String?).

&nbsp;

## Exercicio 4

**Q4:** O tempo de estacionamento dependerá de parkedTime e deverá ser computado cada vez que for consultado, tomando a data atual como referência. Qual tipo de propriedade permite esse comportamento: lazy properties, computed properties ou static properties?

**A:** A melhor opção foi a utilização das Computed Properties.

&nbsp;

## Exercicio 7

**Q7:** Uma propriedade de um struct está sendo modificada. Qual consideração deve ser levada em conta na definição da função?

**A:** Deve-se utilizar o mutating de forma explicita para que possa ser possivel modificar uma propriedade de uma estrutura.

&nbsp;

## Exercicio 10

**Q10:** Qual validação deve ser feita para determinar se o veículo tem desconto?

**A:** A validação que deve ser feita é avaliar se o atributo opcional (discountCard) é diferente de nil.
