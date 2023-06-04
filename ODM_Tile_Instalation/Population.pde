import java.util.*; // Needed to sort arrays

class Population {
  Tile[] individuals;
  int generations;

  Population() {
    individuals = new Tile [population_size];
    initialize();
  }

  void initialize() {
    for (int i = 0; i < individuals.length; i++) {
      individuals[i] = new Tile();
    }

    generations = 0;
  }

  void evolve() {
    sortIndividualsByFitness();
    
    Tile [] next_generation = new Tile[population_size];
    
    int elite_size = getNSelectedTiles();
    if(elite_size > max_elite_size) elite_size = max_elite_size;

    for (int i = 0; i < elite_size; i++)
    {
      next_generation[i] = individuals[i].getCopy();
      individuals[i] = next_generation[i];
    }
    
    for (int i = elite_size; i < population_size; i++)
    {
      if (random(1) <= crossover_rate) next_generation[i] = crossover(tournamentSelection(), tournamentSelection());
      else next_generation[i] = individuals[i].getCopy();
      next_generation[i].mutate();
      individuals[i] = next_generation[i];
    }
    
    sortIndividualsByFitness();
    generations ++ ;
  }
  
  Tile tournamentSelection() {
    // Select a random set of individuals from the population
    Tile[] tournament = new Tile[tournament_size];
    for (int i = 0; i < tournament.length; i++) {
      int random_index = int(random(0, individuals.length));
      tournament[i] = individuals[random_index];
    }
    // Get the fittest individual from the selected individuals
    Tile fittest = tournament[0];
    for (int i = 1; i < tournament.length; i++) {
      if (tournament[i].getFitness() > fittest.getFitness()) {
        fittest = tournament[i];
      }
    }
    return fittest;
  }
  
  Tile crossover(Tile parent_1, Tile parent_2)
  {
    Tile child = new Tile();
    int cut_point = floor(random(1, parent_1.genes.size() -1));
    for (int i = 0; i < child.genes.size(); i++)
    {
      if (i < cut_point || parent_2.genes.size() < i && parent_1.genes.size() >= i) child.genes.set(i, parent_1.genes.get(i));
      else if(parent_1.genes.size() < i && parent_2.genes.size() >= i){
        float gene = parent_2.genes.get(i);
        child.genes.set(i, gene);
      }
    }
    return child;
  }
  
  int getNSelectedTiles(){
    int nSelected = 0;
    for(int i = 0; i < individuals.length; i++){
      if(individuals[i].getFitness() > 0) nSelected ++;
    }
    return nSelected;
  }

  void sortIndividualsByFitness() {
    Arrays.sort(individuals, new Comparator<Tile>() {
      public int compare(Tile indiv1, Tile indiv2) {
        return Float.compare(indiv2.getFitness(), indiv1.getFitness());
      }
    }
    );
  }

  Tile getIndividual(int i) {
    return individuals[i];
  }

  int getSize() {
    return population_size;
  }

  int getGenerations() {
    return generations;
  }
}
