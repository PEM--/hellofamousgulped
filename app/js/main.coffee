'use strict'

# Use Famo.us polyfills: Universal access to CSS3 transforms
require 'famous-polyfills/index'

# Get nice colors
require 'colors/coffee/colors'

# Require Famo.us libraries
Engine = require 'famous/core/Engine'
Surface = require 'famous/core/Surface'

# Create the main context
mainContext = Engine.createContext()

HeaderFooterLayout = require 'famous/views/HeaderFooterLayout'
layout = new HeaderFooterLayout
  headerSize: 100
  footerSize: 50
mainContext.add  layout
layout.header.add new Surface
  content: 'Header'
  size: [undefined, 100]
  classes: ['header-surface']
  properties:
    lineHeight: '100px'
    textAlign: 'center'
layout.content.add new Surface
  content: 'Content'
  size: [undefined, undefined]
  properties:
    lineHeight: '300px'
    textAlign: 'center'
layout.footer.add new Surface
  content: 'Footer'
  size: [undefined, 50]
  classes: ['footer-surface']
  properties:
    lineHeight: '50px'
    textAlign: 'center'
