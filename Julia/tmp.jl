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
for i in 1:5
    sorted_indices = sortperm(reps[i], rev=true)
    cluster_words = dictionary[sorted_indices[1:5]]
    println("Cluster $(i) words: ", cluster_words)
    sorted_indices = sortperm(d)
    closest_articles = titles[sorted_indices[1:5]]
    println("Closest articles to Representative $(i): ", closest_articles)
    end