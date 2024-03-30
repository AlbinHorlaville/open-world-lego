# Open World Lego

## Description
This project is carried out by a team of 4 students in their 4rd year of engineering school at Polytech Grenoble.
This project is a motor game development based on [Godot engine](https://godotengine.org) by using [LDraw](https://www.ldraw.org) model !

## Concept
The aim of this project is to create an open world entirely built in LEGO where you are able to import every set of LEGO do you want and interact with them. In case, we are creating the utlimate sandbox. 

## Table of contents

- [Description du projet](./OpenWorldLego/README.md)

- [Fiche de Suivi](./Document%20de%20Gestion/Fiche%20de%20suivi.md)

- [Planning](gantt.md)
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
