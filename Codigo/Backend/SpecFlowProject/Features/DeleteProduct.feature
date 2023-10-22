Feature: deleteProduct

@mytag
Scenario: Correcta eliminacion de un nuevo producto
	Given que se ingresa un producto de id 12345
	And que se ingresa un id de un product 12345 para eliminar
	When presiono el botón de eliminar
	Then se elimina el producto correctamente

@mytag
Scenario: Incorrecta eliminacion de un nuevo producto
	Given que se ingresa un id de un product 12345 que no existe
	When presiono el botón de eliminar en el caso error
	Then no se elimina el producto 


