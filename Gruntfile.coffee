module.exports = (grunt) ->
  # Project configuration.
  grunt.initConfig
    pkg: grunt.file.readJSON("package.json")
    distdir : 'dist'
    vender : '../../vendor'
    src : 
      js : ['src/**/*.js']
    banner :   
      '/*! <%= pkg.title || pkg.name %> - v<%= pkg.version %> - <%= grunt.template.today("yyyy-mm-dd") %>\n' +
      '<%= pkg.homepage ? " * " + pkg.homepage + "\\n" : "" %>' +
      ' * Copyright (c) <%= grunt.template.today("yyyy") %> <%= pkg.author %>;\n' +
      ' * Licensed <%= _.pluck(pkg.licenses, "type").join(", ") %>\n */\n'
    clean: ['<%= distdir %>/*'] 
    coffee : 
      core : 
        expand : true 
        cwd : 'src'
        src : ['*.coffee', '**/*.coffee']
        dest : '.'
        ext: '.js'
        options: 
          bare : true 
    watch : 
      scripts : 
        files : ['src/*.coffee', 'src/**/*.coffee', 'src/**/*.t.coffee'] 
        tasks : ['coffee']
    # uglify:
    #   options:
    #     banner: "/*! <%= pkg.name %> <%= grunt.template.today(\"yyyy-mm-dd\") %> */\n"
    #   build:
    #     src: "src/<%= pkg.name %>.js"
    #     dest: "build/<%= pkg.name %>.min.js"


  
  # Load the plugin that provides the "uglify" task.
  # grunt.loadNpmTasks "grunt-contrib-uglify"
  grunt.loadNpmTasks 'grunt-contrib-concat'
  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-contrib-copy'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  
  # Default task(s).
  grunt.registerTask 'watchCoffee' , ['watch']