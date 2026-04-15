Algoritmo Simulador_MMU_UES
    // --- Fase 1: Configuracion de Estructuras --- 
    CANT_MARCOS_USUARIO <- 3
    
    // --- Fase 3: Referencias de la Simulacion --- 
    Dimension Referencias[12]
    Referencias[0]<-1; Referencias[1]<-2; Referencias[2]<-3; Referencias[3]<-4
    Referencias[4]<-1; Referencias[5]<-2; Referencias[6]<-5; Referencias[7]<-1
    Referencias[8]<-2; Referencias[9]<-3; Referencias[10]<-4; Referencias[11]<-5
    
    Escribir "--- SIMULADOR DE GESTION DE MEMORIA (MMU) ---"
    Escribir ""
    
    
    f_fifo <- SimularFIFO(Referencias, CANT_MARCOS_USUARIO)
    f_opt <- SimularOPT(Referencias, CANT_MARCOS_USUARIO)
    
    Escribir "-------------------------------------------"
    Escribir "RESULTADOS FINALES:"
    Escribir "Fallos de pagina con FIFO: ", f_fifo
    Escribir "Fallos de pagina con OPTIMO (OPT): ", f_opt
    Escribir "-------------------------------------------"
    Escribir "Analisis: El algoritmo Optimo genera menos fallos porque conoce el futuro."
FinAlgoritmo

// --- FUNCIONES DE APOYO ---

Funcion idx <- BuscarPaginaEnMarcos(pag, Marcos, Ocupado, cant)
    idx <- -1
    Para i <- 0 Hasta cant-1 Hacer 
        Si Ocupado[i] = 1 y Marcos[i] = pag Entonces
            idx <- i
        FinSi
    FinPara
FinFuncion

// --- FASE 3: ALGORITMO FIFO ---
Funcion fallos <- SimularFIFO(Referencias, cant)
    Dimension Marcos[3]
    Dimension Ocupado[3]
    Para i <- 0 Hasta cant-1 Hacer
        Ocupado[i] <- 0
        Marcos[i] <- -1
    FinPara
    
    fallos <- 0
    punteroFIFO <- 0
    
    Para t <- 0 Hasta 11 Hacer
        pag <- Referencias[t]
        Si BuscarPaginaEnMarcos(pag, Marcos, Ocupado, cant) = -1 Entonces
            fallos <- fallos + 1
            Marcos[punteroFIFO] <- pag
            Ocupado[punteroFIFO] <- 1
            punteroFIFO <- (punteroFIFO + 1) MOD cant
        FinSi
    FinPara
FinFuncion

// --- FASE 3: ALGORITMO OPTIMO ---
Funcion victima <- ElegirVictimaOPT(tActual, Referencias, Marcos, cant)
    mejorMarco <- 0
    mayorDist <- -1
    Para i <- 0 Hasta cant-1 Hacer
        pag <- Marcos[i]
        dist <- 99999
        
        Para k <- tActual + 1 Hasta 11 Hacer 
            Si Referencias[k] = pag y dist = 99999 Entonces
                dist <- k - tActual
            FinSi
        FinPara
        Si dist > mayorDist Entonces
            mayorDist <- dist
            mejorMarco <- i
        FinSi
    FinPara
    victima <- mejorMarco
FinFuncion

Funcion fallos <- SimularOPT(Referencias, cant)
    Dimension Marcos[3]
    Dimension Ocupado[3]
    Para i <- 0 Hasta cant-1 Hacer
        Ocupado[i] <- 0
        Marcos[i] <- -1
    FinPara
    
    fallos <- 0
    Para t <- 0 Hasta 11 Hacer
        pag <- Referencias[t]
        Si BuscarPaginaEnMarcos(pag, Marcos, Ocupado, cant) = -1 Entonces
            fallos <- fallos + 1
            libre <- -1
            Para i <- 0 Hasta cant-1 Hacer
                Si Ocupado[i] = 0 Entonces
                    libre <- i
                FinSi
            FinPara
            
            Si libre <> -1 Entonces
                Marcos[libre] <- pag
                Ocupado[libre] <- 1
            Sino
                v <- ElegirVictimaOPT(t, Referencias, Marcos, cant)
                Marcos[v] <- pag
            FinSi
        FinSi
    FinPara
FinFuncion
