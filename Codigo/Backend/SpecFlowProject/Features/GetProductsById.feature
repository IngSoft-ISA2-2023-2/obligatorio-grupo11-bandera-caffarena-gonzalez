Feature: getProductById

@mytag
Scenario: Correcta obtencion de los productos
	Given un producto de id 12345
	And se ingresa el id 12345
	When hago la peticion
	Then obtengo el producto

@mytag
Scenario: Incorrecta obtencion del producto por Id
	Given un id de producto 12345 que no existe
	When quiero ver el producto
	Then no obtengo nada y aparece un error

