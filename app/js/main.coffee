Engine = require 'famous/core/Engine'
Surface = require 'famous/core/Surface'
Modifier = require 'famous/core/Modifier'

# Create the main context
mainContext = Engine.createContext()

outline = new Surface
  size: [200, 200]
  content: 'Hello world in Famo.us'
  classes: ['bgColor']
  properties:
    lineHeight: '200px'
    textAlign: 'center'

outlineModifier = new Modifier
  origin: [0.5, 0.5]

mainContext
  .add outlineModifier
  .add outline
