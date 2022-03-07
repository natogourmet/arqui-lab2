
/******************************************************************************************
inputPos
move
dictStart
dictDigsStart

inputValue = loadDigram(inputPos)
while (inputValue != null) {
    move = 2;
    valueDictPos = searchDigramPos(inputValue)
    if (valueDictPos == 0) {
        inputValue = loadChar(inputPos)
        valueDictPos = searchCharPos(inputValue)
        move = 1;
    }
    writeEncoding(valueDictPos)
    inputPos = inputPos + move
    inputValue = loadDigram(inputPos)
}

searchDigramPos(inputValue) {
    dictPos = dictDigsStart;
    dictValue = loadDigram(dictPos)
    while (dictValue != null) {
        if (inputValue == dictValue) return dictPos;
        dictPos = dictPos + 2;
        dictValue = loadDigram(dictPos)
    }
    return 0;
}

searchCharPos(inputValue) {
    dictPos = dictStart;
    dictValue = loadChar(dictPos)
    while (dictValue != null) {
        if (inputValue == dictValue) return dictPos;
        dictPos = dictPos + 1;
        dictValue = loadChar(dictPos)
    }
    return 0;
}