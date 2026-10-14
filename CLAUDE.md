# GambasCAD

Open-source 2D CAD program (GPL) written in **Gambas 3**, being extended into 3D. Version 0.0.36. Authors: terco, tincho (trkSoft). Upstream: https://github.com/tercoide/GambasCAD. About 92k lines across ~185 classes/modules; comments are mostly in Spanish.

## What it does
- **Drawing and editing:** AutoCAD-style. Lines, arcs, circles, ellipses, splines, polylines, text and multi-line text, hatches, blocks and inserts, all dimension types, leaders, viewports, paper-space sheets.
- **File formats:** DXF is native, with its own reader/writer in `.src/Dxf/dxf.module`. DWG goes through an external converter (LibreDWG or ODAFileConverter) that converts to DXF and back (`.src/gcd.module`). DGN, STL, OBJ, glTF and JSON modules are in `.src/Library/`.
- **Rendering:** everything is drawn with OpenGL in a GTK3 `GLArea`. `.src/Library/glx.module` replaces normal 2D painting with OpenGL calls (LFF vector fonts, textures, `VBO.class` buffers, GLSL shaders in `.hidden/shaders`).
- **Printing:** print styles, print dialog, preview (`fPrint`, `fPrintPreview`).

## Architecture
| Area | Location | Role |
|---|---|---|
| Entry point | `.src/main.module` | Detects installed vs. IDE run, loads config from `~/.config/gambascad`, creates working folders, loads colors/menus/patterns/cursors, opens `fMain` |
| Global state | `.src/gcd.module` | Current drawing, snap mode, active tool (`gcd.clsJob`), redraws, DWG conversion |
| Document model | `.src/Drawing/Drawing.class`, `.src/Drawing/Tables/*` | Mirrors the DXF structure: headers, tables (layers, line types, text/dim styles, UCS, views), blocks, inserts, objects, sheets |
| Entities | `.src/Drawing/Entities/cad*.class` | One static class per entity type, built on `EntityBase`: drawing, selection tests, grips, transforms, DXF/JSON import/export, geometry building. `Entity.class` holds the data; its defining points `Entity.P` are a `Punto3d[]` (one object per point, `.x .y .z`), while the derived `Polygon`/`PolyLine` stay flat `Float[]` x,y |
| Tools | `.src/Tools/cad*.class` | One class per command, built on `ToolsBase` (mouse/key events, `Start`, `Run`, `Finish`, `Cancel`) |
| UI | `.src/Forms/`, `.src/actions.module` | Main window `fMain` and dialogs; `actions.module` handles menu and file actions (New, Open, Save) |
| Drawing aids | `.src/DrawingAids.class`, `.src/clsMouseTracking.class` | Object snaps, tracking, command-line prompts |
| Math | `.src/Library/puntos.class`, `modAlgebra`, `.src/Drawing/3D/Matrix4.class`, `Quaternion` | Geometry and matrix math |
| Undo | `.src/Library/Undo.class` | Undo stack |
| BIM ("Smart") | `.src/Smart/` | Early building elements (beam, column, wall, slab) and a plant designer form |
| 3D | `.src/Drawing/3D/`, `.src/Tools/3D/` | `Scene3d`, `glCamera`, `ShaderMatrices`, extrude and navigate tools |

## Current direction
Moving from 2D toward 3D: 2D/3D code split, drawing on the three main planes, GLSL matrix/shader manager, 3D scene and camera, ray-plane tests, and a working Extrude tool (`.src/Tools/3D/cadExtrude.class`, uses Newell's method for face normals). Navigation (`cadNavigate`) and 3D shapes (box, cylinder, mesh) are in progress.

## Things worth knowing
- Working with `Entity.P`: use the helpers in `puntos` (`P3d`, `FromXY`, `ToXY`, `ToXYZ`, `CopyP`, `ResizeP`, `TranslateP`, `RotateP`, `ScaleP`, `LimitsP`) and in `glx` (`DrawLinesP`, `PolyLinesP`, `DrawpointsP`). `New` can't be used inside an expression in Gambas, so build points with `puntos.P3d(x, y, z)`. `Array.Copy()` is shallow for objects, so copy point arrays with `puntos.CopyP`. `NewEntity` accepts a `Punto3d[]` or flat x,y numbers. `.gcd` files store points as `"pts"` (x,y,z triplets); the old `"p"` (x,y pairs) is still read.
- Local coordinate systems: `puntos.LocalToGlobal` and `puntos.GlobalToLocal`/`GlobalToLocalP` (inverse, quaternion-based) share the axes from `puntos.EjesLocales(Normal)`. For many points, compute `CuaternionGlobalToLocal` once and call `GlobalToLocalQ` per point.
- `.class~` / `.module~` files are editor backups committed next to the real sources; edit the files without `~`.
- On every start, `Initialize` in `main.module` runs `rm -R` on the user's dwgin/dxfin/dwgout/dxfout/printstyles/templates folders, wiping anything in them.
- Resources and design notes live in `.hidden/`: `TODO`, `ISSUES`, `LIMITATIONS`, `CHANGELOG`, and spreadsheets on data flow and internal data structures.
- Project metadata and required Gambas components are in `.project`.
