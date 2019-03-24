#using scripts\shared\hud_util_shared;

#namespace luminns_utils;

function createRectangle(align, relative, x, y, width, height, sort = 1, color = (1, 1, 1), shader = "white") 
{
	element = newClientHudElem( self );
	element.x = x;
	element.y = y;
	element.width = width;
	element.height = height;
	element.xOffset = 0;
	element.yOffset = 0;
	element.sort = sort;
	element.color = color;
    element hud::setPoint(align, relative, x, y);
	element setShader( shader, width, height );
	element.hidden = false;
    element.hidewheninmenu = false;
	
	return element;
}

function createText(align, relative, x, y, text, sort = 1, color = (1, 1, 1), alpha = 1, size = 1.4, font = "default")
{
    element = self hud::createFontString(font, size);
    element hud::setPoint(align, relative, x, y);
    
    // Allows us to use this method instead of duping it below
    if( text != undefined )
        element setText(text);
    
    element.sort = sort;
    element.hidewheninmenu = true;
    element.alpha = alpha;
    element.color = color;

    return element;
}

// Relys on luminns_utils::createText
function createValue(align, relative, x, y, value, label = "", sort = 1, color = (1, 1, 1), alpha = 1, size = 1.4, font = "default")
{
    element = createText(align, relative, x, y, undefined, sort, color, alpha, size, font);
    element.label = label;
    element setValue(value);

    return element;
}
