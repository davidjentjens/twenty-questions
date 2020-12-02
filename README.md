# Animal Twenty Questions

A project originally devoleped for an artificial intelligence programming course teached by [Augusto Baffa](http://www.inf.puc-rio.br/blog/professor/@augusto-baffa) at the Pontificial Catholic University of Rio de Janeiro. 
Prolog-based implementation of a decision tree algorithm that identifies animals by asking simple yes or no questions.

## Presentation
[Link to the presentation video](https://www.loom.com/share/1302bd4994a642858ca25cf39c5cc2a7)

## Installation

To run this code, you need to install SWI-PROLOG which can be downloadead [Clicking Here](https://www.swi-prolog.org/download/stable).

## Usage

To start the algorithm, you'll need to execute the file main.pl using SWI-PROLOG, and than run the 'start.' command. 
Remember to put a dot in the end of all your answers, it's prolog command sintaxe. 

## Data Structure

The decision data structure is represented by a binary tree. Each node of the tree represents a question which separates an animal or a subsection of animals from another. The leaves of the tree represents animals, stored in the decision memory(in the saved_tree.txt file). This data structure is used in the decision making process, so the algorithm can guess the user's animal. 

This is an example of a decision tree structure:

```prolog 
tree(guessTree, 
  t('É um mamífero?', 
    t('Tem listras?', 
      t('Zebra', nil, nil),
      t('Ele ruge?',
        t('Ele hiberna?',
          t('Urso',nil,nil),
          t('Leão',nil,nil),
        )
        t('Cavalo',nil,nil))
      ),
    ),
    t('É um passaro?',
      t('Ele voa?', 
        t('Águia', nil, nil),
        t('Pinguim', nil, nil)
      ),
      t('Ele tem pernas?',
        t('Lagarto',nil,nil),
        t('Cobra',nil,nil)
      )
    )
  )
).

```

## Developed by

[David Jentjens](https://github.com/davidjentjens)

[Frederico Lacis](https://github.com/fredlacis)

[Pedro Gabriel Sales](https://github.com/salespedrogabriel)



