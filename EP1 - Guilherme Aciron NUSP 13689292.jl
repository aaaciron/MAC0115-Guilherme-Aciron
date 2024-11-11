#Não altere os cabeçalhos das funções

function hanoi_rec(n::Int64, dep::Int64, origem::String, auxiliar::String, destino::String)
    #Função recursiva auxiliar, é responsável por resolver o problema das Torres de Hanoi e por printar na tela a movimentação dos discos.#
    if dep == 1
        if n == 1
            println("Mova o disco 1 de $origem para $destino")
        else
            hanoi_rec(n-1, dep, origem, auxiliar, destino)
            println("Mova o disco $n de $origem para $destino ")
            hanoi_rec(n-1, dep, auxiliar, destino, origem)
        end
    end
end

function hanoi(n::Int64, dep::Int64) :: Nothing
    #É responsável por chamar a função recursiva com os parâmetros corretos e também por printar na tela quantos movimentos foram necessários.#
    jogadas = 2^n - 1
    if dep == 1
        hanoi_rec(n, dep, "A", "B", "C")
    end
    println("Foram necessários $jogadas movimentos")
    return
end

# Chamada da função para testar
hanoi(3, 1)
hanoi(1,0)