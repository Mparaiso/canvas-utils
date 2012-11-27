
###
EN : Utiliy functions for html5 canvas
FR : Fonctions utilitaires pour html5 canvas

function : 
captureMouse
uncaptureMouse
parseColor
colorToRGB
containsPoint
###
CanvasUtils = CanvasUtils || {}

((s)->
    s.keys = 
        ### EN : key mapping ###
        UP: 38
        DOWN: 40
        LEFT: 37
        RIGHT: 39
    
    s.captureMouse = (element)->
        ### EN : CAPTURE MOUSE POSITION ON AN ELEMENT 
            FR : CAPTURE LA POSITION DE LA SOURIS SUR UN ELEMENT ###
        mouse = 
            x:0
            y:0
        element.addEventListener 'mousemove',(event)->

            x = event.pageX || (event.clientX + document.body.scrollLeft  + document.documentElement.scrollLeft)
            y = event.pageY || (event.clientY + document.body.scrollTop + document.documentElement.scrollTop)

            x -= event.target.offsetLeft
            y -= event.target.offsetTop

            mouse.x = x
            mouse.y = y
            return
        ,false
        return mouse

    s.uncaptureMouse = (element)->
        ### EN : STOP CAPTURE 
            FR : ARRETE LA CAPTURE DE LA SOURIS SUR UN ELEMENT ###
        element.removeEventListener 'mousemove',this.captureMouse
        return

    s.parseColor = (color,toNumber=false)->
        ### EN : READ AND TRANSFORM color string 
            FR : TRANSFORME LE FORMANT d'une Couleur ###
        if toNumber==true
            if typeof color == "number"
                return (color | 0)

            if typeof color == "string" && color[0] == "#"
                color = color[1..]

            return parseInt(color,16)

        else
            if typeof color == 'number'
                color = "#"+('00000'+(color|0).toString(16)).substr(-6)
            return color

    s.colorToRGB = (color,alpha=1)->
        # if string convert to number
        if typeof color == "string" && color[0] = "#"
            color = parseInt(color[1..],16)

        # extract components values
        r = color >> 16 & 0xff
        g = color >> 8 & 0xff
        b = color & 0xff
        a = if alpha < 0 then 0 else (if (alpha>1) then 1 else alpha ) # check range

        # use 'rgba' if needed
        if a == 1
            return "rgb(#{r},#{g},#{b})"
        else
            return "rgba(#{r},#{g},#{b},#{a})"

    s.containsPoint = (rect,x,y)->
        ### EN : Return true if a points is contains in a rectangle 
            FR : Retourne vrai si un point est contenu dans un rectangle ###
        !( x<rect.x || x > rect.x + rect.width || y < rect.y || y > rect.y + rect.height ) 

    return

)(CanvasUtils)


