library(igraph)
library(igraphdata)
library(qgraph)
library(influenceR)
library(bootnet)
library(ggplot2)
library(tidyverse)

rawdata = read.csv("Stress CSV.csv", header= TRUE)

# read all rows but only read columns 2 to 11
rawdata = rawdata[,2:11]

# estimating partial correlation matrix with thresholding
network_rawdata <- estimateNetwork(rawdata, default = "pcor",
                                   threshold = 'sig')

# summary of nodes and edges in network
summary(network_rawdata)

# minimise padding of plot
par(mar=c(0,0,0,0)+.1)

# plot qgraph representation
plot(network_rawdata,
     label.cex=3)

# convert to a igraph network object 
network_rawdata_g <- graph_from_adjacency_matrix(network_rawdata$graph, 
                                                 mode = 'undirected', 
                                                 weighted = TRUE)

# plot igraph network 
plot(network_rawdata_g, 
     vertex.size=20, 
     vertex.label.family='sans', 
     vertex.label.cex=2,
     vertex.label=V(network_rawdata_g)$name)

data = igraph::simplify(network_rawdata_g)
is.simple(network_rawdata_g)

# removing negative edges from igraph
## get vertex names
E(network_rawdata_g)

## get edge ID of Transition-Family edge
get.edge.ids(network_rawdata_g, c("T..","F.R"))

## get edge ID of Transition-Academic_Expectations edge
get.edge.ids(network_rawdata_g, c("T..", "A.E"))

## remove Transition-Family edge
one_removed_g <- delete.edges(network_rawdata_g, 5)
plot(one_removed_g)

## remove Transition-Academic_Expectations edge
both_removed_g <- delete.edges(one_removed_g, 2)
plot(both_removed_g)

# get node size based on average rating of stressors for each node
node_ratings <- colMeans(rawdata)
node_size <- node_ratings / max(node_ratings) * 50

# plot network with node size corresponding to average rating
plot(both_removed_g, vertex.size=node_size/1.5,
     vertex.label.family='sans',
     vertex.label.cex=2,
     vertex.label=V(network_rawdata_g)$name)

# community detection using Louvain 
set.seed(88)
stressors_louvain <- cluster_louvain(both_removed_g, weights = E(both_removed_g)$weight)

## membership of nodes in each community 
(comm_membership <- data.frame(node = V(both_removed_g)$name, community = stressors_louvain$membership))

table(comm_membership$community) 

## modularity value of network to detect presence of community structure
modularity(stressors_louvain)  


# finding node with highest strength
strength(both_removed_g) |> sort(decreasing = T) |> head(1) %>% round (3)


# identifying key player problem-positive nodes
k3result <- keyplayer(both_removed_g, k = 3)

set.seed(2)
V(both_removed_g)$color <- 'red'
V(both_removed_g)[k3result]$color <- 'lightgreen' # change colour of key players
    
par(mar=c(0,0,0,0)+.1) # to reduce the margins 
  
plot(both_removed_g, vertex.frame.color = 'black', 
     vertex.label.family = 'sans',
     vertex.size = 10, 
     vertex.color = V(both_removed_g)$color, 
     vertex.label.cex = 0.8,
     vertex.label.color = 'grey',
     vertex.label = substr(V(both_removed_g)$name, 1, 3)
  )

# plot key player network with node size corresponding to average rating
plot(both_removed_g, vertex.size=node_size/1.5,
     vertex.label.family='sans',
     vertex.label.cex=2,
     vertex.label=V(network_rawdata_g)$name)

# local clustering coefficients of all nodes
local_clustering <- rbind(V(both_removed_g)$name, 
                          transitivity(both_removed_g, type = 'local', isolates = 'zero') %>% 
                            round(5))
print(local_clustering)



  