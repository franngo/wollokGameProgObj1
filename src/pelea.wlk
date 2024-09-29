import wollok.game.*
import posiciones.*
import extras.*
import paleta.*
import enemigos.*
import personaje.*



object barraEstadoPeleas {

    var property enemigo = null
    var property jugador = personaje

    method text() = "Barra De Peleas"
    method textColor() = paleta.rojo()


    // aparece todo lo que tiene que mostrar la barra de estado
    method aparecer() {
        self.validarAparecer()
            game.addVisual(self)
            game.addVisual(vidaPersonaje)
            game.addVisual(vidaEnemigo)
            game.addVisual(ataque)
            game.addVisual(combate)

            // el personaje ataca
            //jugador.estaEnCombate(true)
            //keyboard.q().onPressDo( { jugador.atacar(enemigo)})

            //se evalua si la pelea termino o no
            //game.onTick(500, "evaluarPelea", { self.desaparecer() } )

    }

    method validarAparecer() {
        if(jugador.estaEnCombate()){
            self.error("A ya esta puesto")
        }
    }

    // desaparece la barra y todo lo que muestra, evaluando si alguno de los dos, personaje o enemigo, murio
    method desaparecer() {

       if(jugador.vida() <= 0 || enemigo.vida() <= 0){

            jugador.estaEnCombate(false)

            game.removeTickEvent("evaluarPelea")
            game.removeVisual(self)
            game.removeVisual(vidaPersonaje)
            game.removeVisual(vidaEnemigo)
            game.removeVisual(ataque)
            enemigo.morir()
           // game.stop()
            
        }
    }


    method position() = game.at(7, personaje.position().y() - 3)


}

object vidaPersonaje{

    method text() = "Vida: " + personaje.vida().toString()
        method textColor() = paleta.rojo()

    method position() = barraEstadoPeleas.position().down(1).left(2)

}

object vidaEnemigo {

    method text() = "Enemigo Vida: " + barraEstadoPeleas.enemigo().vida().toString()
    method textColor() = paleta.rojo()

    method position() = vidaPersonaje.position().right(3)

}

object ataque{

    method position() = game.at(3, game.height() - 2)//vidaPersonaje.position().down(1)
    method text() = "Durabilidad: " + personaje.armaActual().durabilidad().toString() + "\nNivel: " + personaje.armaActual().nivel().toString()
    //personaje.armaActual()
    method textColor() = paleta.rojo()

}

object combate{
    var property turno = 0
    var property enemigoX = null
    var estado = enemigoX
    method cambiarTurno() {
        turno = (turno + 1 ) % 2
    }

    method ataque(){
        if(turno == 1){
            estado = enemigoX
            enemigoX.atacar()
        } else {
            estado = personaje
            personaje.esTurno(true)
            personaje.debeAtacar(enemigoX)
        }
        barraEstadoPeleas.desaparecer()
    }

    method text() = "Turno: " + self.turno().toString()
    method textColor() = paleta.rojo()

    var property position = game.at(10,10)
}