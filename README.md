Infraestructura Virtual
====

[![Build Status](https://travis-ci.org/patamimbre/IV_Proyecto.svg?branch=master)](https://travis-ci.org/patamimbre/IV_Proyecto)

### Descripción del proyecto

Una API REST muy simple para el [proyecto principal](https://github.com/LazyHackerOrg/LazyHacker/). Puesto que mi compañero realizará la API completa, en esta únicamente se muestra un esqueleto de ella.

-------

#### Herramientas para la realización del proyecto:

* **Ruby** como lenguaje de programación
* **Sinatra** como web framework
* Despliegue hecho en **Heroku**
* **CodeShip** para integración continua 

### Funcionalidad básica

La aplicación se encuentra desplegada en Heroku, siendo accesible en
[](https://lit-springs-30407.herokuapp.com/). Para comprobar su correcto funcionamiento hay que hacer una petición **get** a **/**.
Las otras rutas son:
**/search/:id** devuelve un json con el cve indicado.
**/service/:service** devuelve un json con los cves que contienen al servicio.
