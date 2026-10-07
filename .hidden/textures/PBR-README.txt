PBR materials (physically based rendering), one folder per material

Sources (downloaded 2026-10-07, 1K JPG sets):
  ambientCG   https://ambientcg.com    folders named like Bricks059, Concrete045
  Poly Haven  https://polyhaven.com    folders named like wood_textured_concrete
License: Creative Commons CC0 1.0 Universal (public domain), no attribution required
         https://docs.ambientcg.com/license/   https://polyhaven.com/license
         Optional credit: "Created using <material> from ambientCG.com / polyhaven.com, CC0 1.0"

Maps, <Name>_<Map>.jpg, 1024 px (some tiles are 1024x512 or 512x1024):
  Color             base color / albedo (sRGB)
  Roughness         0 = mirror, 1 = matte (linear)
  Metalness         0 = dielectric, 1 = metal (linear); only in metallic materials,
                    use 0 when the map is missing
  NormalGL          tangent space normal map, OpenGL convention (Y+ / green up)
  AmbientOcclusion  linear; not every material has it, use 1 when missing
  Displacement      height map, for parallax or tessellation (linear)
  Opacity           alpha mask (RoofingTiles013A)
  Preview.png       rendered sphere, for material pickers

Materials:
  walls      Bricks059, Bricks097, Concrete034, PaintedPlaster017, Plaster001
  floors     WoodFloor051, WoodFloor043 (metal inlays), Tiles141, Marble012, Carpet016
  wood       Wood094
  metal      Metal049A, CorrugatedSteel009
  roof       RoofingTiles013A
  exterior   PavingStones138, Grass004

Architectural (exposed, fair-faced) concrete, by formwork finish:
  board formed, vertical planks   concrete (Poly Haven, Rob Tuytel, 4.0 x 4.0 m), Concrete045
  board formed, horizontal planks concrete_slab_wall_02 (Poly Haven, Amal Kumar, 2.1 x 2.1 m),
                                  Concrete004
  wood grain imprint              wood_textured_concrete (Poly Haven, Dimitrios Savva, 1.8 x 1.8 m)
  pour lifts / panel joints       concrete_slab_wall (Poly Haven, Dimitrios Savva, 2.3 x 2.3 m),
                                  Concrete031
  fluted / ribbed formwork        ribbed_concrete_wall (Poly Haven, Charlotte Baglioni, 2.0 x 2.0 m),
                                  Concrete013
  smooth fair-faced               Concrete046, Concrete034
  The sizes are the real-world area one tile covers, for the UV scale (Poly Haven gives them,
  ambientCG does not).

Note: glx.LoadTextures only reads the *.png files directly in this folder, so these
subfolders are not loaded by it.
