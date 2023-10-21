Feature: newProduct

@mytag
Scenario: Correcta creación de un nuevo producto
	Given que se ingresa un código numérico de 12345
	And se ingresa un nombre de producto "Shampoo"
	And se ingresa una descripción "Dale vida a tu pelo!"
	And se coloca un precio de 100
	When presiono el botón de creación
	Then se da de alta el producto correctamente

@mytag
Scenario: Incorrecta creación de un nuevo producto por codigo largo
	Given que en el escenario_II se ingresa un código numérico de 1234567
	And en el escenario_II ingresa un nombre de producto "Shampoo"
	And en el escenario_II ingresa una descripción "Dale vida a tu pelo!"
	And en el escenario_II coloca un precio de 100
	When en el escenario_II presiono el botón de creación
	Then en el escenario_II no se da de alta el producto

@mytag
Scenario: Incorrecta creación de un nuevo producto por codigo corto
	Given que en el escenario_III se ingresa un código numérico de 123
	And en el escenario_III ingresa un nombre de producto "Shampoo"
	And en el escenario_III ingresa una descripción "Dale vida a tu pelo!"
	And en el escenario_III coloca un precio de 100
	When en el escenario_III presiono el botón de creación
	Then en el escenario_III no se da de alta el producto

@mytag
Scenario: Incorrecta creación de un nuevo producto por codigo repetido
	Given que en el escenario_IV se ingresa un código numérico de 12345
	And en el escenario_IV ingresa un nombre de producto "Shampoo"
	And en el escenario_IV ingresa una descripción "Dale vida a tu pelo!"
	And en el escenario_IV coloca un precio de 100
	When en el escenario_IV presiono el botón de creación
	Then en el escenario_IV no se da de alta el producto

@mytag
Scenario: Incorrecta creación de un nuevo producto nombre largo mayor a 30 caracteres
	Given que en el escenario_V se ingresa un código numérico de 1234567
	And en el escenario_V ingresa un nombre de producto "Shampooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo"
	And en el escenario_V ingresa una descripción "Dale vida a tu pelo!"
	And en el escenario_V coloca un precio de 100
	When en el escenario_V presiono el botón de creación
	Then en el escenario_V no se da de alta el producto

@mytag
Scenario: Incorrecta creación de un nuevo producto descripcion largo mayor a 70 caracteres
	Given que en el escenario_VI se ingresa un código numérico de 1234567
	And en el escenario_VI ingresa un nombre de producto "Shampoo"
	And en el escenario_VI ingresa una descripción "Dale vida a tu pelooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo!"
	And en el escenario_VI coloca un precio de 100
	When en el escenario_VI presiono el botón de creación
	Then en el escenario_VI no se da de alta el producto

@mytag
Scenario: Incorrecta creación de un nuevo producto precio menor a 0
	Given que en el escenario_VII se ingresa un código numérico de 1234567
	And en el escenario_VII ingresa un nombre de producto "Shampoo"
	And en el escenario_VII ingresa una descripción "Dale vida a tu pelo!"
	And en el escenario_VII coloca un precio de -100
	When en el escenario_VII presiono el botón de creación
	Then en el escenario_VII no se da de alta el producto
