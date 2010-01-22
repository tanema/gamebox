require 'actor_view'

class GraphicalActorView < ActorView
  def draw(target, x_off, y_off)
    debug = false
    x = @actor.x
    y = @actor.y
    img = @actor.image
    return if img.nil?

    #if @actor.is? :animated or 
    if @actor.is? :physical
      w,h = *img.size
      x = x-w/2
      y = y-h/2
      img.blit target.screen, [x+x_off,y+y_off]
    else
      if @actor.is?(:graphical) && @actor.graphical.tiled?
        x_tiles = @actor.graphical.num_x_tiles
        y_tiles = @actor.graphical.num_y_tiles
        img_w, img_h = *img.size
        x_tiles.times do |col|
          y_tiles.times do |row|
            img.blit target.screen, [x+x_off+col*img_w,y+y_off+row*img_h]
          end
        end
      else
        img.blit target.screen, [x+x_off,y+y_off]
      end

    end
  end
end
