using CSV
using DataFrames
using Plots

#definindo o DataFrame
caminho = "C:\\Users\\Guilherme Acirón\\Desktop\\Guilherme\\MAC0115\\miniep7\\movies.csv"
df = CSV.read(caminho, DataFrame)

#filtrando o DataFrame para apenas década de 1990
df_1990s = df[(df.year .≥ 1990) .& (df.year .≤ 1999), :]

#criando um vetor com a coluna da avaliação dos filmes
coluna_rating = df_1990s.rating

histogram(
    coluna_rating, #vetor usado
    bins=10, #número de colunas
    title="Histograma - Avaliação de filmes da década de 1990", #título
    xlabel="Avaliação", #nome do eixo x
    ylabel="Frequência", #nome do eixo y
    legend=false, #habilitar ou não legenda
    ylims=(0, 600), #limites de y
    color =:white) #cor do gráfico
savefig("histograma.png")
