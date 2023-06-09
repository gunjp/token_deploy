let W = 800;
let C = W/2;
let n = 0;
let f = 1;

function preload() {
    //img = loadImage('https://cdn.discordapp.com/attachments/1064233881559109672/1111280792165945374/xio_p5_test1.png');
    img = loadImage('xio_p5_test1.png');
  }

 function setup() {
    createCanvas(700,700);
    //background(100,61,97);
}

function draw() {
  background(100,61,97);
   noFill();
   stroke(255,20,147,100);
   strokeWeight(22);
   f+=1;
   for(n=f%40;n<300;n+=10){
       circle(W*noise(n-f),W*noise(n-f,1),n);
   }

    image(img,0,0);
  }