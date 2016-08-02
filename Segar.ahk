Process, Priority,, High
F12:: reload
;Procesos ;2491
;Comentadrio de mas
; ------------------------------------------------- ------------------------------
; Verifica que Dofus este abierto y con el foco
; ------------------------------------------------- ------------------------------
#IfWinActive Dofus
{
	; ------------------------------------------------- ------------------------------
	; Espera la ejecucion de la tecla Fin
	; ------------------------------------------------- ------------------------------
	~End::
	{
		;==================== Inico del script ====================
		
		; Las variables se inicializan globalmente para qur puedan mantener su valor en todas las funciones:
		Global 	Cordenadas := {base: {addr: Func("ArrayGrupos_Addr"), __Set: Func("ArrayGrupos_Setter")}} ; Creamos una matriz que tendra dos dimensiones para almacenar las cordenadas del recurso inferior
		
		Global Contador ; Se crea un contador para almacenar el numero de veces que se env�a el comando de cortar recurso.
		
		Global ContadorPods ; Igual que el anterior, pero esta vez para guardar los los pods que almacena por recurso ###Editarcomentario##
		
		Global ColorSalmon ; Este color lo vamoa a usar mucho para buscar detalles especificos
		
		;Global Frases ; Inicializa la variable y luego se le asigna un valor aleatorio.
		
		ColorSalmon = 0xFF6600 ; Iniciamos el color salmon con su hexadecimal
		
		Contador := 0 ; Se inicaliza el contador en  0.
		
		; ------------------------------------------------- ------------------------------
		; Se encarga de la siega
		; ------------------------------------------------- ------------------------------
		Segar()
		;Frases()
	}
	
	Segar() ;Declaracion de la funcion que se encarga de segar
	{
		Global Contador
		Global Frases
		Global Cordenadas
		Global ContadorPods
		trigo  = %A_WorkingDir%\Img\trigo1.png ; Imagen que identifica el trigo
		Random, SleepTime, 12000, 14000 ; Tomamos un valor al azar del tiempo de inactividad de la siega y lo guardamos en la variable SleepTime
		If (Contador = 50) ; Si el ya se ha segado 50 veces entonces se escribira una frase al azar, para despistar ue no sea un boot
			Frases() ; Ejecutamos la funcion que lanza frases al azar
		
		CoordMode, Pixel, Screen
		ImageSearch, FoundX, FoundY, 0, 0, 1274, 775,*130 %trigo% ; Buscamos la imagen del trigo con una diferencia de contraste del 115
		If ErrorLevel = 0 ; Si encontro la imagen
		{   
			Cordenadas[1] := FoundX ; Asigamos la cordenadas X a la variable global de Cordenadas
 			Cordenadas[2] := FoundY ; Hacemos lo mismo pero con Y
  			;MsgBox, Encontro la imagen del TRIGO
  			Contador++ ; Le a�adimos uno al contador de Segadas
  			ContadorPods++ ; Le a�adimos 1 item
			MouseClick, left, FoundX, FoundY ; Movemos el mouse hacia el trigo y le damos click 
			Sleep, 400
			MouseMove, FoundX+22, FoundY+50 ;
			Sleep, 600
			PixelSearch, X, Y, FoundX+22, FoundY+50, FoundX+50, FoundY+63, ColorSalmon, 0, Fast RGB ; Buscamos el pixel en una peque�a region  el pixel naranja que nos muestra cuando apuntamos sobre segar.
			If ErrorLevel = 1 ; Si no encontro el color
				Verificar() ; Verificamos la causa de no haberlo encontrado
			MouseClick, left, FoundX+22, FoundY+50
			Sleep, SleepTime ; Esperamos el tiempo indicado para que termine de segar el PJ
			
		}
		;MsgBox, No Encontro la imagend del Trigo
		Verificar() ; Lanzamos la funcion de verificar para confirmar los pods y relanzar la funcion Segar

	}
	
	Verificar() ; Verificamos que realmente no puede segar y lo notificamos por medio de beeps si es necesario
	{
		Global ContadorPods
		Global ColorSalmon
		combate = %A_WorkingDir%\Img\combate.png ; Imagen que solo se ve cuando hay un combate (ente estas posiciones: 590, 870, 625, 900)
		
		If ContadorPods > 20 ; Se comprueba si el numero de veces que se ha segado es mayor a 10, Revisamos el inventario
		{
			ContadorPods = 0 ; Iniciamos el contador de pods a cero
			MouseClick, left, 938, 804 ; Le damos click al boton de abrir inventario
			Sleep, 2000 ; Esperamos 2 segundos hasta que se abra el inventario
			PixelGetColor, capacidad, 860, 422 ; Obtenemos el color del final de la barra de pods.
			If capacidad = ColorSalmon ; Si el color del limite de pods marcado por nosotros es naranja inicia la funcion inventario lleno
				InventarioLLeno() ; Lanzamos la funcion que nos reporta que se lleno el inventario
			MouseClick, left, 938, 804 ; Le damos click al boton de inventario para cerrarlo
			Sleep, 1000 ; Esperamos un segundo para que el inventario se cierre
		}
		
		ImageSearch, FoundX, FoundY, 590, 870, 625, 900,*15 %combate% ; Buscamos en la posicion: 590, 870, 625, 900; la imagen que nos indica que estamos en combate. 
		If ErrorLevel = 0 ; Si encontro la imagen de batalla
			Avisar("Tu pj se ha metido a una pelea") ; Avisar que el personaje esta en batalla.
			
		Segar() ; Continuamos Segando
	}
	
	InventarioLLeno()
	{
		MouseClick, left, 938, 804 ; Le damos click al boton de inventario para cerrarlo
		Avisar("El Inventario se ha llenado") ; Le indicamos al usuario que se lleno el inventario
		Segar() ; Despues de vaciar el inventario volvemos a segar
	}
	
	Avisar(msg)
	{
		SoundBeep, 349 * 2, 500
		SoundBeep, 262 * 2, 500
		SoundBeep, 349 * 2, 500
		SoundBeep, 262 * 2, 500
		SoundBeep, 294 * 2, 750
 		SoundBeep, 349 * 2, 500
 		SoundBeep, 262 * 2, 500
 		SoundBeep, 349 * 2, 500
 		SoundBeep, 262 * 2, 500
 		SoundBeep, 294 * 2, 750
 		SoundBeep, 349 * 2, 500
 		SoundBeep, 262 * 2, 500
 		SoundBeep, 349 * 2, 500
 		SoundBeep, 262 * 2, 500
 		SoundBeep, 294 * 2, 750
		SoundBeep, 294 * 2, 750
 		SoundBeep, 349 * 2, 500
 		SoundBeep, 262 * 2, 500
 		SoundBeep, 349 * 2, 500
 		SoundBeep, 262 * 2, 500
 		SoundBeep, 294 * 2, 750
 		SoundBeep, 349 * 2, 500
 		SoundBeep, 262 * 2, 500
 		SoundBeep, 349 * 2, 500
 		SoundBeep, 262 * 2, 500
 		SoundBeep, 294 * 2, 750

		MsgBox % msg
	}
	Frases() ;Creamos una funcion con frases aleatorias
	{
		Global Contador
		
		CoordChatX := 472 ; Cordenada en el eje X del Chat
		CoordChatY := 970 ; Cordenada en el eje Y del Chat
		Random, Frases, 1, 5 ; Sirve para esoger una de las frases al azar
		;Frases := 1
		MouseClick, left, CoordChatX, CoordChatY ;Clickeamos en el chat para que podemas escibir sobre el
		
		If Frases = 1 
			Send Tambien estas leveando el campesino?
		If Frases = 2 
			Send Men, tu eres level 100 campesino
		If Frases = 3 
			Send Segar es facil
		If Frases = 4 
			Send Casi soy panadero 100
		If Frases = 5 
			Send Mmmmm!
		
		Sleep, 1300 ; Espamos un poquito mas de un segundo 
		Send {Enter} ; Y presionamos enter
		Contador := 0 ; Reinicializamos el contador
	}

	return
}