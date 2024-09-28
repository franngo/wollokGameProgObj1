import randomizer.*
import paleta.*
import personaje.*


class Arma {
    var property estaEquipada = false
    const property position = game.at(randomizer.posicionesRandomArmas().head(),randomizer.posicionesRandomArmas().last() )
    const nivel = 1.randomUpTo(3).round()

    method serEquipada() {
      self.estaEquipada(true) 
    }

    // El pj colsiona con el arma y la mete en la bolsa()
    method colisiono(personaje){
        personaje.equiparArma(self)
    }

    //se implementan en cada una de las subclases de tipos de arma (ya que en todas varía)
    method danho()
    method image() 
    method imagenParaPersonaje()
    method restarDurabilidad(cantidadRestada)
    method chequearDurabilidad()

}

class Espada inherits Arma {
    var property durabilidad = 100.randomUpTo(130).round() //porque es un dato cambiante que debe cambiar y no recalcularse cada vez.
    //y la declaramos acá porque si se declara en la superclase ya no le podemos dar valor inicial personalizado a menos que sea usando 
    //algún método

    override method restarDurabilidad(cantidadRestada) {
        durabilidad -= cantidadRestada
    }

    override method chequearDurabilidad() {
        if (self.durabilidad() <= 5) {
            personaje.armaActual(null) //en realidad hay que fijarse si tiene otra y pasar esa al primero, y si hay tercera pasarla a 2do
            personaje.bolsa().remove(personaje.bolsa().head())
        } else {
            self.restarDurabilidad(5)
        }
    }

    override method danho() {
        return 35 + nivel * 10
    }

    override method image() {
        return "espadaGris-32Bits.png"
    }

    override method imagenParaPersonaje() {
        return "ConEspada"
    }

    // Para test
    method text(){ return "Durabilidad: " + self.durabilidad().toString() + "\nNivel: " + nivel.toString()}
    method textColor() = paleta.azul()


}

class ArcoYFlecha inherits Arma {
    var property durabilidad = 130.randomUpTo(150).round() //porque es un dato cambiante que debe cambiar y no recalcularse cada vez.
    //y la declaramos acá porque si se declara en la superclase ya no le podemos dar valor inicial personalizado a menos que sea usando 
    //algún método

    override method restarDurabilidad(cantidadRestada) {
        durabilidad -= (cantidadRestada * 2)
    }

    override method chequearDurabilidad() {
        if (self.durabilidad() <= 5) {
            personaje.armaActual(null) 
            personaje.bolsa().remove(personaje.bolsa().head())
        } else {
            self.restarDurabilidad(5)
        }
    }

    override method danho() {
        return 20 + nivel * 10
    }
        override method image() {
        return "arcoYFlecha-32Bits.png"
    }

    override method imagenParaPersonaje() {
        return "ConArcoYFlecha"
    }

    // Para test
    method text(){ return "Durabilidad: " + self.durabilidad().toString() + "\nNivel: " + nivel.toString()}
    method textColor() = paleta.azul()

}

class MartilloDeGuerra inherits Arma {
    var property durabilidad = 50.randomUpTo(90).round() //porque es un dato cambiante que debe cambiar y no recalcularse cada vez.
    //y la declaramos acá porque si se declara en la superclase ya no le podemos dar valor inicial personalizado a menos que sea usando 
    //algún método

    override method restarDurabilidad(cantidadRestada) {
        durabilidad = durabilidad - (cantidadRestada / 2)
    }

    override method chequearDurabilidad() {
        if (self.durabilidad() <= 5) {
            personaje.armaActual(null) //en realidad hay que fijarse si tiene otra y pasar esa al primero, y si hay tercera pasarla a 2do
            personaje.bolsa().remove(personaje.bolsa().head())
        } else {
            self.restarDurabilidad(5)
        }
    }

    override method danho() {
        return 80 + nivel * 10
    }

    override method image() {
        return "martilloDeGuerra-32Bits.png"
    }

    override method imagenParaPersonaje() {
        return "ConMartilloDeGuerra"
    }

    // Para test
    method text(){ return "Durabilidad: " + self.durabilidad().toString() + "\nNivel: " + nivel.toString()}
    method textColor() = paleta.azul()

}

//FÁBRICAS (su única función es devolverme en nuevo objeto de la subclase de Arma a la que están ligadas. nos permiten crear armas random)

object fabricaEspada {

    method nuevaArma() {
        return new Espada()
    }

}

object fabricaArcoYFlecha {

    method nuevaArma() {
        return new ArcoYFlecha()
    }

}

object fabricaMartilloDeGuerra {

    method nuevaArma() {
        return new MartilloDeGuerra()
    }

}

 // Prueba de clase de arma 2 ESTO ES UNA PRUEBA NO TOMAR EN SERIO
 class Arma3 {
    var property estaEquipada = false
    const position = game.at(randomizer.posicionesRandomArmas().head(),randomizer.posicionesRandomArmas().last() )
    method nivel() {
        return 1.randomUpTo(3).round()
    }
    var durabilidadDe
    var durabilidadHasta
    var danho
    var image 
    var imagePj


    method serEquipada() {
      self.estaEquipada(true) 
    }

    method danho()  {
        return danho + self.nivel() * 10
    }
    method durabilidad() {
        return durabilidadDe.randomUpTo(durabilidadHasta).round()
    }


    method position() {
        return position
    }

    // El pj colsiona con el arma y la mete en la bolsa()
    method colisiono(pj){
        pj.equiparArma(self)
    }



    method image() {
        return image + ".png"
    }

   method imagenParaPersonaje() {
        return imagePj + ".png"
    }


 }
