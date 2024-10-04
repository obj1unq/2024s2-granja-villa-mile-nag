import wollok.game.*
import hector.*
import granja.*

class Maiz {
  var property image = self.bebe()
  var property position = null
  var esAdulto = false
  
  method regar() {
    image = self.adulto()
    esAdulto = true
  }
  
  method bebe() = "corn_baby.png"
  
  method adulto() = "corn_adult.png"
  
  method cosechar() {
    game.removeVisual(self)
    granja.sacarPlanta(self)
  }
  
  method estaListaParaCosechar() = esAdulto
  
  method loQueVale() = 150
}

class Trigo {
  var property image = "wheat_0.png"
  var property position = null
  var property etapa = 0
  
  method regar() {
    etapa = (etapa + 1) % 4
    self.image(("wheat_" + etapa) + ".png")
  }
  
  method estaListaParaCosechar() = etapa >= 1
  
  method cosechar() {
    game.removeVisual(self)
    granja.sacarPlanta(self)
  }
  
  method loQueVale() = (etapa - 1) * 100
}

class Tomaco {
  var property image = "tomaco.png"
  var property position = null
  
  method regar() {
    var nuevaPos = position.up(1)
    
    if (granja.estaDentro(nuevaPos) and (not granja.hayUnaPlantaEn(nuevaPos))) {
      position = nuevaPos
    }
    //elegí que en caso de que no haya lugar o este en el borde superior, la planta no haga nada. 
  }
  
  method estaListaParaCosechar() = true
  
  method cosechar() {
    game.removeVisual(self)
    granja.sacarPlanta(self)
  }
  
  method loQueVale() = 80
}