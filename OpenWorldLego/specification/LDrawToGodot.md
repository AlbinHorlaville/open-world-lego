# Disponible Formats

## LDraw exported files 
- 3DS : 3D-Studio File
- POV : POV-Ray Scene File
- STL: Stereo Lithography File

## Godot imported files
- glTF (recommanded)
- Blender
- DAE Collada
- OBJ Wavefront
- FBX

<br>

# Strategies to import assets into the Godot project

## Strategy 1
In the web, there is already 3D Lego construction. They arn't in the great format for Godot (usually LDR files), so you can use Blender to convert them in gltf.<br>
At first we wanted to use this strategy, but we didn't find the 3D Lego construction we need.

## Strategy 2
Create the wanted construction with a software called **LeoCad**. The exported file is DAE COLLADA, so there is no need to convert it. You can directly import it into the Godot Project.<br>
It's the strategy we mainly used.