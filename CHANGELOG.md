# Changelog

## [Unreleased]
- Add input field value checking at GUI
- Add input value checking at interface.m

## [v0.5.1] - 2021-1-21
## Fixed
- Fix airfoil name compatibility bug for XTurb v1.9 in xturbreader.m

## [v0.5.0] - 2021-1-21
### Added
- Add limited support for XTurb v1.9

### Fixed
- Fix input path forward/back-slash sensitivity

### Changed
- Output messages now flash blank for 5ms to reflect button presses

## [v0.4.0] - 2020-7-27
### Added
- Add coupling for twist and chord switches in property-generator
- Add geometry plotting for property-generator

### Fixed
- Fix endtable header construction in xturbreader.m

### Changed
- Change deflecfxf.m to output as table with header
- Change afpropgen.m and simplepropgen.m to output as struct

## [v0.3.0] - 2020-07-24
### Added
- Add xturb input file parser, xturbinp.m

### Fixed
- Fix deflecfxf.m output to include radial position
- Fix sign error in deflecfxf.m

### Changed
- Change deflecfxf.m variable assignments (swap u's and M's for y and z)

## [v0.2.0] - 2020-07-10
### Added
- Add asterisk support in matrixloader.m
- Add support for material E and density

### Fixed
- Fix property-generator output to display twist

## [v0.1.0] - 2020-07-02
### Added
- Initial release
