import wollok.game.*
import cultivos.*
import granja.*
import posiciones.*

object hector {

	var property position = game.center()
	const property image = "player.png"
	const property plantasCosechadas = []
	var property plata = 0
	
	method sembrarMaiz() {
		const cultivo = new Maiz(position = self.position())
		granja.validarSiSePuedePlantarEn(self.position())
		granja.agregarPlanta(cultivo)
		game.addVisual(cultivo)
	}
	
	method sembrarTrigo() {
		const cultivo = new Trigo(position = self.position())
		granja.validarSiSePuedePlantarEn(self.position())
		granja.agregarPlanta(cultivo)
		game.addVisual(cultivo)
	}
	
	method sembrarTomaco() {
		const cultivo = new Tomaco(position = self.position())
		granja.validarSiSePuedePlantarEn(self.position())
		granja.agregarPlanta(cultivo)
		game.addVisual(cultivo)
	}
	
	method mover(direccion) {
		granja.validarDentro(direccion.siguiente(position))
		position = direccion.siguiente(position)
	}

	method regar() {
		granja.regarPlanta(self.position())
	}

	method agregarPlanta(planta) {
	  plantasCosechadas.add(planta)
	}

	method cosechar() {
	  self.validarSiSePuedeCosechar()
	  const planta =  granja.plantaActual(self.position())
	  self.agregarPlanta(planta)
	  planta.cosechar()
	}

	method validarSiSePuedeCosechar() { 
	  self.validarSiHayUnaPlantaAca()
	  self.validarSiLaPlantaEstLista()
	}

	method validarSiHayUnaPlantaAca() {
	  if (not granja.hayUnaPlantaEn(self.position()) ){
		self.error("No hay una planta acá")
	  }
	}

	method validarSiLaPlantaEstLista() {
	  if (not granja.plantaActual(self.position()).estaListaParaCosechar()){
		self.error("La planta no está lista para ser cosechada")
	  }
	}

	method vender() {
	  plata = plata + self.ventaTotal()
	  plantasCosechadas.clear()
	}

	method hablar() {
	   game.say(self, "Tengo " + self.cuantasPlantasTieneParaVender() + " plantas para vender y " + plata + " monedas de oro")
	}

	method ventaTotal() {
	  return plantasCosechadas.sum({planta => planta.loQueVale()})
	}

	method cuantasPlantasTieneParaVender() {
	  return plantasCosechadas.size()
	}

	//tengo la duda sobre si estoy o no delegando bien las cuestiones

	
}