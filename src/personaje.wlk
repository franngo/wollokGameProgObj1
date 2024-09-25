import wollok.game.*
import posiciones.*
import extras.*
import paleta.*
import enemigos.*

object personaje {

    var property vida = 100
	const property bolsa = []
	//de momento, la idea es que las armas NO sean ÚNICAS, por lo que el pj puede tener 2 de la misma. por tanto, usamos una lista
	//en vez de un conjunto.
	//para esta idea de armas no únicas usamos la clase Arma
	//propongo un máximo de 3. Podría agrandarse si pasa x cosa (o sino lo dejamos fijo en 3)
	var property isMoving = true //flag
	var  property position = game.at(7,2); //lo ponemos como atributo porque tenemos que inicializarlo en una cierta celda pero tmb va cambiando.
								 //si fuera estático podríamos tener simplemente un metodo posición que devuelva esa pos estática
	var property armaActual = punio
    var property tieneArmaEquipada = false


	method image() { //image() se calcula a cada frame al igual que position(), si no entendí mal
		return "knight" +  ".png" //self.estado() + ".png"
	}

/* por ahora sin estado.
	method estado() {
		if(armaActual==null) {
			return ""
		} else {
			return armaActual.imagenParaPersonaje()
		}
	}
*/


	/// ARMA    
    method equiparArma(armaNueva){
        bolsa.add(armaNueva)
        //armaNueva.serEquipada()
        self.armaActual(bolsa.head())   // el arma que tiene el la mano es la primera arma que agarro
        self.tieneArmaEquipada(true) 
        self.mostrarArmaEquipada()
        //armaActual.estaEquipada(true)
        
    }

    method mostrarArmaEquipada() {
            armaActual.position( game.at(self.position().x() + 1 , self.position().y()) )

    }
    


    method armaActual(arma){
        armaActual = arma
    }

	//acciones con teclas

	method mover(direccion) {
        self.validarMoverEnPelea()
		position = direccion.siguiente(position)
		enemigo1.mover()
	}

    method validarMoverEnPelea(){
        if(estaEnCombate){
            self.error("Estoy Peleando")
        }
    }

	//se ataca con la primer arma que se tiene en la bolsa, que viene a ser el arma actual. El ataque, de momento, no causa ningún efecto
	//además de bajar la durabilidad del arma.

    /* Lo comento para probar otro método con el mismo nombre, no deberia ir comentado
	method atacar() { 
		if (!bolsa.isEmpty()) { //para que no se ejecute bolsa.head() si está vacía la lista, lo cual daría error (queremos que simplemente no pase nada)
			bolsa.head().atacar()
			if(bolsa.head().durabilidad()<=0) {
				bolsa.remove(bolsa.head()) //dps del ataque, se revisa si el arma quedó con durabilidad menor a 0. ifso, se rompe y descarta
		
			}
		}
	}
    */
    var estaEnCombate = false

    method estaEnCombate(condicion){
        estaEnCombate = condicion
    }

    // por ahora ataca con espada porque es una prueba
    //cuando se toca la Q ataca (implementado en pelea - barraDeEstado.aparecer())
    method atacar(enemigo){
        if(estaEnCombate){
            enemigo.recibirDanho(armaActual.danho())
			armaActual.durabilidad()
        }
    }

}

