inputPos
dicPos
carRaro = 99
maxLetras = 52
dicDigramPos = dicPos + maxLetras
CIPos = inputPos //current input position
digram = cargarDigrama(CIPos)
inputOffset = 2

while ( digram != null ){
    CDPos = dicDigramPos
    dicDigram = cargarDigrama(CDPos)
    while (dicDigram != null ){
        if ( dicDigram == digram ){
            escribirPos(CDPos)
            break;
        }
        CDPos += 2
        dicDigram = cargarDigrama(CDPos)
    }
    if(dicDigram = null){
        inputOffset = 1;
        digram = cargarLetra(CIPos)
        CDPos = dicPos
        dicLetra = cargarLetra(CDPos)
        while (CDPos != dicDigramPos ){
            if ( dicLetra == digram ){
                escribirPos(CDPos)
                break;
            }
            CDPos += 1
            dicLetra = cargarLetra(CDPos)
        }
        if(CDPos == dicDigramPos){
            escribirLetra(carRaro)
        }
    }

    CIPos += inputOffset
    digram = cargarDigrama(CIPos)

    inputOffset = 2;
}
