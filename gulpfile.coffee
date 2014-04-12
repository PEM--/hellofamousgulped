'use strict'
gulp       = require 'gulp'
gp         = (require 'gulp-load-plugins') lazy: false
path       = require 'path'
browserify = require 'browserify'
source     = require 'vinyl-source-stream'

# HTML
gulp.task 'html', ->
  gulp.src 'app/index.jade'
    .pipe gp.plumber()
    .pipe gp.jade locals: pageTitle: 'Famo.us built with Gulp'
    .pipe gulp.dest 'www'

# JS
gulp.task 'js', ->
  browserify
    entries: ['./app/js/main.coffee']
    extensions: ['.coffee', '.js']
  .transform 'coffeeify'
  .transform 'deamdify'
  .transform 'debowerify'
  .transform 'uglifyify'
  .bundle()
  # Pass desired file name to browserify with vinyl
  .pipe source 'main.js'
  # Start piping stream to tasks!
  .pipe gulp.dest 'www/js'

# CSS
gulp.task 'css', ->
  gulp.src 'app/css/*.sass'
    .pipe gp.plumber()
    .pipe gp.rubySass style: 'compressed', loadPath: ['bower_components', '.']
    .pipe gp.cssmin keepSpecialComments: 0
    .pipe gp.autoprefixer 'last 1 version'
    .pipe gulp.dest 'www/css'

# Images
gulp.task 'img', ->
  gulp.src ['app/img/*.jpg', 'app/img/*.png']
    .pipe gp.cache gp.imagemin
      optimizationLevel: 3
      progressive: true
      interlaced: true
    .pipe gulp.dest 'www/img'

# Clean
gulp.task 'clean', ->
  gulp.src ['www', 'tmp'], read: false
    .pipe gp.clean force: true

# Build
gulp.task 'build', ['html', 'js', 'css']

# Default task
gulp.task 'default', ['clean'], -> gulp.start 'build'

# Connect
gulp.task 'connect', ['default'], ->
  gp.connect.server
    root: 'www'
    port: 9000
    livereload: true

# Watch
gulp.task 'watch', ['connect'], ->
  gulp.watch 'app/**/*', read:false, (event) ->
    ext = path.extname event.path
    taskname = null
    reloadasset = null
    switch ext
      when '.jade', '.md', '.svg'
        taskname = 'html'
        reloadasset = 'www/index.html'
      when '.sass'
        taskname = 'css'
        reloadasset = 'www/css/main.css'
      when '.coffee', '.js'
        taskname = 'js'
        reloadasset = 'www/js/main.js'
      else
        taskname = 'img'
        reloadasset = "www/img/#{path.basename event.path}"
    gulp.task 'reload', [taskname], ->
      gulp.src reloadasset
        .pipe gp.connect.reload()
    gulp.start 'reload'
