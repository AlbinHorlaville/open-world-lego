# List of BugFounded but Not Resolved Yet

### Upload Importing 
- Description : Try to upload new content in the world when the game just convert it 
- Step to reproduce :
1. Add a new Ldraw Files to the list of importedFiles ( By Interface or Manualy)
2. Upload the file at the same instance of the game that convert it
3. The load will be "null" even if the file have been converted -> Should not happens
- Idea of issues It's fix while restarting the world, so it's can be linked to the file system.

### Auto Import des assets 
- Description : Assets are reupload with different ID, this is annoying when we have to take a specific node like in the animation.
- Step to reproduce :
1. Refresh the projet
