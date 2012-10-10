#Version history#

##1.5.1 (10/09/12)
* Fix for pathfinding with no diagonal moves allowed : paths returned looks more "natural".

##1.5.0 (10/06/12)
* Added support for collision maps starting at locations different than (1,1).
* Heuristic name CHEBYSHEV was removed, now on will use DIAGONAL instead.
* Changes in Jumper's initialization arguments
* Various improvements
* Updated Readme

##1.4.1 (10/04/12)
* Third-parties are now git submodules.
* Bugfix with grid reset process
* Optimized the grid reset process. Successive calls to <tt>pather:getPath()</tt> yield faster.
* Removed <tt>grid:reset()</tt>

##1.3.3 (10/01/12)
* Removed useless lines of code

##1.3.2 (09/26/12)
* Compatibility issue with Gideros : Jumper couldn't be required, due to the way Gideros run projects.
* Updated Readme

##1.3.1 (09/25/12)
* Jumper no longer uses internally Lua's <tt>module</tt> function.
* Global env pollution bugfix

##1.3 (09/25/12)
* added autoSmooth feature : returned paths can now be automatically smoothered on return
* <tt>searchPath</tt> renamed to <tt>getPath</tt>
* Added chaining
* Slight enhancements in code, making profit of Lua's multiple return values ability
* Updated Readme
* Updated demos

##1.2 (08/28/12)
* Jumper now uses [30log](http://github.com/Yonaba/30log) as its object orientation library
* Global env pollution when requiring jumper now fixed (See init.lua)
* Updated Readme

##1.1.1 (08/27/12)
* Third party updated (Binary_Heaps v1.5)
* Code cleaning, Fixed indentation

##1.1 (08/01/12)
* Updated with third-party (with Binary_Heaps ported to 1.4)

##1.0 (06/14/12)
* Added Path smoother
* Better handling of straight moves
* Code cleaning

##0.3 (06/01/12)
* Bugfix with internal paths calls to third-parties.

##0.2 (05/28/12)
* Updated third-party libraries (Lua Class System, Binary Heaps)
* Added version_history.md

##0.1 (05/26/12)
* Initial release
			