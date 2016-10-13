/*
Fake Album Cover Contest Prompt Generator.
*/

import controlP5.*; // using the CP5 interface library. can be downloaded in the Processing IDE through the contributions manager.
ControlP5 cp5;
Textarea myTextarea;

String Content;


void setup() {
  size(600, 400);
  cp5 = new ControlP5(this);  //Initialising the interface.
  
  myTextarea = cp5.addTextarea("txt")
                  .setPosition(10,10)
                  .setSize(580, 380)
                  .setFont(createFont("tahoma", 20))
                  .setLineHeight(24)
                  .setColor(color(50))
                  .setColorBackground(color(255))
                  .setColorForeground(color(127));
                  ;
  Content = "Welcome to the r/fakealbumcovers Contest Prompt Generator.\nPress any key to generate a new prompt.\n";
  myTextarea.setText( Content );
}

void draw(){
  
}

void keyPressed(){
  if( key == 'p' || key == 'P') println( Content );   // [P] prints the contents to the terminal.
  else{                                               // any other key adds a new prompt to the contens.
    Content += Assembler();
    myTextarea.setText( Content );
  }
}

String Assembler(){
  String output = "";
  String Template = random_from_file( "templates" );  // Get a random template
  output = filter( Template );                        // filter all the tags and add appropriate content.
  return output + ".\n";
}

String filter( String in ){
  String[] line = split( in, ' ' );                   //splits all the words of the incoming string.
  String out = "";
  for( int i = 0; i < line.length; i++ ){
    if( line[i].charAt( 0 ) == '#' ){                 // if any of them start with #...
      
      char tag = line[i].charAt( 1 );
      String add = "";
      
      if( line[i].length() > 2 ) add = line[i].substring( 2 );
      
      switch( tag ){                                                 // we go to the appropriate tag and 
        case 'n': // NAMES, nouns describing real-world things.         replace that word with content from the word library.
          line[i] = random_from_file( "names" );
          break;
        case 'c':// CONCEPTS, nouns describing abstract ideas.
          line[i] = random_from_file( "concepts" );
          break;
        default:
        
          break;
      }
      
      line[i] += add;
    }

    out += line[i]+" ";
  }
  
  boolean clean = true;                          // The filter runs recursively,
  for( int i = 0; i < out.length(); i++ ){       // that means content in the library can also contain tags!
    if( out.charAt( i ) == '#' ){
      clean = false;
      break;
    }
  }
  if( !clean ){
    out = filter( out );
  }
  
  out = out.substring(0, out.length()-1);
  return out;
}

String random_from_file( String file ){
  String[] database = loadStrings( file+".txt" );
  return database[round(random(-0.499, database.length-0.501))] ;
}