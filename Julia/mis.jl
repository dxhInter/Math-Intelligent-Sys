using VMLS
using LinearAlgebra
articles, dictionary, titles=wikipedia_data();
Lth=length(articles);
k=5
assignment, reps=kmeans(articles, k);
d = zeros(500)
for i in 1:500
d[i] = norm(articles[i] - reps[assignment[i]])
end
for j = 1:k
    group=[i for i=1:Lth if assignment[i]==j]
    println()
    println("Cluster: ", j)
    tmp=sortperm(reps[j], rev=true)
    println("5 most common words \n ", dictionary[tmp[1:5]]);
    println("Articles closest to representative: ")
    tmp = sortperm(d[group])
    for i= 1:5
    println(" ", titles[group[tmp[i]]])
    end
end;
