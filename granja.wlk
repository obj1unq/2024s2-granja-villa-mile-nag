import posiciones.*
import wollok.game.*
import hector.*


object granja { 

    const property plantasEnLaGranja = #{}

    method validarDentro(position) {
        if (not self.estaDentro(position)) {
            hector.error("No puedo moverme fuera del tablero")
        }
    }

    method estaDentro(position) {
        return position.x().between(0, game.width() - 1) and position.y().between(0, game.height() - 1)
    }

    method agregarPlanta(planta) {
      plantasEnLaGranja.add(planta)
    }

    method validarSiSePuedePlantarEn(posicion) {
      if (self.hayUnaPlantaEn(posicion)){
        hector.error("No se puede plantar, ya hay una planta acá")
      }
    }

    method hayUnaPlantaEn(posicion) {
      return plantasEnLaGranja.any({planta => planta.position() == posicion})
    }

    method regarPlanta(posicion) {
      self.verificarQueSePuedeRegar(posicion)
      self.plantaActual(posicion).regar()
    }

    method plantaActual(posicion) {
      return plantasEnLaGranja.find({planta => planta.position() == posicion})
    }

    method verificarQueSePuedeRegar(posicion) {
      if (not self.hayUnaPlantaEn(posicion)) {
        hector.error("No se puede regar, no hay ninguna planta.")
      }
    }

    method sacarPlanta(planta) {
      plantasEnLaGranja.remove(planta)
    }

}
