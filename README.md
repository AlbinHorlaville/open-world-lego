# Open World Lego

## Description
This project is carried out by a team of 4 students in their 4rd year of engineering school at Polytech Grenoble.
This project is a motor game development based on [Godot engine](https://godotengine.org) by using [LDraw](https://www.ldraw.org) model !
Our motive is to create a sandbox made entirely of Lego bricks, where you can import anything you want, from a car to a pyramid. We use Godot and LDraw for this.

> [!NOTE]
> This project was originally supported on gitlab for students, so not all contributors appear in the project. See the authors section at the bottom of the page.

## Concept
The aim of this project is to create an open world entirely built in LEGO where you are able to import every set of LEGO do you want and interact with them. In case, we are creating the utlimate sandbox. 

## Documentations

The documentation and the specification about the project can be found at the following link :

- [Documentatation and specification](https://gricad-gitlab.univ-grenoble-alpes.fr/Projets-INFO4/23-24/04/docs)
  
## Diagram of branches
```mermaid
%%{init: { 'logLevel': 'debug', 'theme': 'base', 'gitGraph': {'showBranches': true}} }%%
gitGraph
   commit id:"c0"
   commit id:"c1"
   branch dev
   checkout dev
   commit id:"c2"
   branch username.featureName
   commit tag:"Adding a new feature" id:"c3"
   checkout dev
   branch dev_backup
   checkout username.featureName
   commit id:"c4"
   checkout dev
   merge username.featureName tag:"Merge request required"
   checkout main
   merge dev tag:"version 1"
   checkout dev
   commit id:"c5"
   branch username.bugBugName
   commit tag:"Fixing bug" id:"c6"
   commit id:"c7"
   checkout dev
   merge username.bugBugName tag:"Merge request required"
   commit id:"c8"
   checkout dev_backup
   merge dev
   checkout main
   merge dev tag:"version 2"
   commit id:"c9"
   
```
## Support
- Subject : https://air.imag.fr/index.php/Open_World_Lego_avec_Godot_et_LDraw

## Contact
- Project manager : albin.horlaville@etu.univ-grenoble-alpes.fr
- Git manager : romain.miras@etu.univ-grenoble-alpes.fr

## Authors
- Romain MIRAS @mirasr (Scrum master)
- Albin HORLAVILLE @horlavia
- Louane LESUR @lesurl
- Gregory PITITTO @pitittog
