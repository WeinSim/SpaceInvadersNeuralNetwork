class NeuralNetwork {
  float sum;
  
  Neuron n0 [] [] = new Neuron [layers.length] [258];
  Bias b1 [] [] = new Bias [layers.length] [258];
  Weight w1 [] [] [] = new Weight [layers.length-1] [258] [15];
  
  NeuralNetwork () {
    for (int c=0; c<layers.length; c++) {
      for (int d=0; d<layers[c]; d++) {
        n0[c][d] = new Neuron(random(-1, 1));
        if (c != 0) {
          b1[c][d] = new Bias(random(-5, 5));
        }
        if (c < layers.length-1) {
          for (int e=0; e<layers[c+1]; e++) {
            w1[c][d][e] = new Weight(random(-5, 5));
          }
        }
      }
    }
  }
  
  void update(float input []) {
    for (int f=0; f<input.length; f++) {
      n0[0][f].activation = input[f];
      //println(input);
    }
    for (int a=1; a<layers.length-1; a++) {
      for (int b=0; b<layers[a]; b++) {
        sum = 0;
        for (int f=0; f<layers[a-1]; f++) {
          sum += n0[a-1][f].activation*w1[a-1][f][b].value;
        }
        sum += b1[a][b].value;
        //println(n0[a][b].activation);
        n0[a][b].activation = sigmoid(sum);
        //println(n0[a][b].activation);
      }
    }
    //println(n0[3][1].activation);
  }
  
  void child(NeuralNetwork f, NeuralNetwork m) {
    for (int c=0; c<layers.length; c++) {
      for (int d=0; d<layers[c]; d++) {
        if (!(c==0)) {
          b1[c][d].value = (f.b1[c][d].value+m.b1[c][d].value)/2+random(-0.5, 0.5);
        }
        if (c < layers.length-1) {
          for (int e=0; e<layers[c+1]; e++) {
            w1[c][d][e].value = (f.w1[c][d][e].value+m.w1[c][d][e].value)/2+random(-0.5, 0.5);
          }
        }
      }
    }
  }
  
  float sigmoid(float input) {
    return(1/(1+pow(2.718281828459, -input)));
  }
}