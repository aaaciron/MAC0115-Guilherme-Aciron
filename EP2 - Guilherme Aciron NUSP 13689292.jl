using Random
using Plots

#=
    Gera uma aposta aleatória com um número de seleções especificado pela variável `numeros`, 
    que deve estar entre 6 e 10. A função escolhe números inteiros únicos aleatórios 
    no intervalo de 1 a 60.

    # Parâmetros
    - `numeros::Int`: O número de seleções que devem ser feitas, deve ser um inteiro 
    entre 6 e 10.

    # Retorno
    - Devolve um vetor de inteiros (`Vector{Int}`) contendo os números selecionados, 
    ordenados em ordem crescente.

    # Exemplo
    ```julia
    aposta = gerar_aposta(6)  # Gera uma aposta com 6 número
=#
function gerar_aposta(numeros::Int) ::Vector{Int}
    if numeros ≥ 6 && numeros ≤ 10             #certifica que o total de números apostados está entre 6 e 10
        vetor_de_apostas = rand(1:60, numeros) #cria o vetor com n elementos com números aleatórios de 1 a 60
        vetor_ordenado = sort(vetor_de_apostas) #ordena o vetor em ordem crescente
        return vetor_ordenado
    else
        println("Aposta inválida")
        return nothing
    end
end

#=
    Simula a quantidade de apostas necessárias para acertar todos os números 
    selecionados em uma aposta aleatória.

    # Parâmetros
    - `numeros_selecionados::Vector{Int}`: Um vetor contendo os números que devem ser acertados. 
    Os números devem estar no intervalo de 1 a 60.
    
    - `max_numeros::Int`: O número máximo de seleções permitidas para a aposta, deve ser um inteiro 
    entre 6 e 10.

    # Retorno
    - Devolve um inteiro (`Int64`) representando o total de apostas realizadas até que 
    todos os números selecionados sejam acertados.

    # Exemplo
    ```julia
    apostas_necessarias = simular_apostas([5, 12, 23, 34, 45, 56], 10)
=#
function simular_apostas(numeros_selecionados::Vector{Int}, max_numeros::Int) :: Int64
    if max_numeros ≥ 6 && max_numeros ≤ 10             #verifica se max_numeros está entre 6 e 10
        vetor_suporte = gerar_aposta(max_numeros)      #cria um primeiro sorteio
        total = 1                                      #contador de apostas, começa no 1
        while numeros_selecionados != vetor_suporte    #laço que conta as apostas e faz novas apostas até que a aposta seja acertada
            vetor_suporte = gerar_aposta(max_numeros)
            total += 1
        end
        return total
    else
        println("Total de seleções permitidas da aposta inválido.")
        return nothing
    end
end


#= 
    Função responsável por plotar um gráfico da distribuição dos resultados das simulações de apostas.
    A função recebe um vetor de inteiros, onde cada inteiro representa o número de apostas realizadas para acertar todos os números selecionados em uma simulação. A função deve definir intervalos para categorizar os resultados e contar a frequência de apostas em cada intervalo. Em seguida, um gráfico de barras deve ser gerado para visualizar a distribuição, e o gráfico deve ser salvo como um arquivo PNG.
=#
function plota_grafico(resultados::Vector{Int})
    #determinar os intervalos e o número de intervalos
    intervalos = [0, 10000, 100000, 1000000, 10000000, 100000000]
    n_intervalos = 5
    
    #contar a frequência em cada intervalo
    frequência = zeros(Int, n_intervalos)
    for apostas in resultados
        for i in 1:n_intervalos
            if apostas ≥ intervalos[i] && apostas < intervalos[i+1]
                frequência[i] += 1
            end
        end
    end

    #rótulo dos intervalos
    labels = ["$(intervalos[i]):$(intervalos[i+1]-1)" for i in 1:n_intervalos]

    #cria o plot
    plot = bar(labels, 
    frequência, 
    title="Distribuição do número de apostas", 
    xlabel="Número de apostas", 
    ylabel="Frequência de aparição", 
    legend=:topright)

    display(plot)

    savefig(plot, "distribuição_apostas.png")
end

#= 
    Função principal que coordena a execução do programa.
    A função deve definir os parâmetros necessários para a simulação, como o número máximo de seleções permitidas e o número de simulações a serem realizadas. 
    Ela invocará as funções necessárias, incluindo a simulação de apostas e a plotagem do gráfico de resultados. 
    O objetivo é executar o fluxo completo do programa, desde a geração das apostas até a visualização dos resultados. A função não deve devolver nenhum valor.
=#
function main()
    n_simulações = 100                                                                         #define quantas simulações devem ser feitas
    max_numeros = 6                                                                            #define o máximo de números que devem ser acertados na cartela
    quantos_numeros_apostar = 6                                                                #quantos números selecionou na cartela
    numeros_selecionados = gerar_aposta(quantos_numeros_apostar)

    resultados = [simular_apostas(numeros_selecionados, max_numeros) for i in 1:n_simulações]  #vetor com os resultados simulados

    plota_grafico(resultados)                                                                  #plota o gráfico
end

main()