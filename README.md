# apebar
apebar is bar framework for macOS which is built on top of Übersicht.


## Getting started

#### Install apebar to Übersicht's widget directory:
```
git clone https://github.com/kinglouie/apebar.git $HOME/Library/Application\ Support/Übersicht/widgets/apebar
```

## Configuration

..

## Developer Guide

..

##  Dependencies
Some of the widgets depend on additional binaries which are not shipped with apebar.
The easiest way to install them is the macOS package manager [homebrew](http://brew.sh).

#### Bandwidth widget
```
brew install ifstat
```
#### CurrentApplication widget
This widget will only work if you're using chunkwm (tiling window manager)
```
brew tap crisidev/homebrew-chunkwm
brew install chunkwm
```