class NeuralNetwork {
  float sum;  //sum between adding neuron activations
  
  Neuron n0 [] [] = new Neuron [layers.length] [258];  //the 1st dimension specifies the layer  of the neuron, the second one it's index
  Bias b1 [] [] = new Bias [layers.length] [258];  //same like neuron
  Weight w1 [] [] [] = new Weight [layers.length-1] [258] [15];  //first two dimension s specifie the dimensions of the neuron in the lower("leftern") layer that it is connected to, the third one the index of the neuron in the "righter" layer
  
  NeuralNetwork () {
    for (int c=0; c<layers.length; c++) {
      for (int d=0; d<layers[c]; d++) {
        n0[c][d] = new Neuron(random(-1, 1));
        if (c != 0) {
          b1[c][d] = new Bias(random(-5, 5));  //creating a random network
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
      n0[0][f].activation = input[f];  //assiging activations to the neuron in the 0th layer
      //println(input);
    }
    for (int a=1; a<layers.length-1; a++) {  //iterating through all of the neurons, in each of them iterate through all of the neurons in the previous layer
      for (int b=0; b<layers[a]; b++) {
        sum = 0;  //sum starts out at 0
        for (int f=0; f<layers[a-1]; f++) {
          sum += n0[a-1][f].activation*w1[a-1][f][b].value;  //it increases by the neuron it the lefter layer's activation multiplied by the corresponding weight
        }
        sum += b1[a][b].value;  //the "bias" is added to this sum
        //println(n0[a][b].activation);
        n0[a][b].activation = sigmoid(sum);  //and the neurons activation is set to sigmoid of the sum
        //println(n0[a][b].activation);
      }
    }
    //println(n0[3][1].activation);
  }
  
  void child(NeuralNetwork f, NeuralNetwork m) {  //this is for the not yet programmed mutation
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
  
  float sigmoid(float input) {  //the sigmoid function takes all real numbers and squishing them into the space between 0 and 1. 
    return(1/(1+pow(2.718281828459, -input)));  //this number(2.718281828459) is a mathematical constant called "e".
  }
}