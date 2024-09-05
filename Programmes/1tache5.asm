data SEGMENT
    msg db " 1 sec ecoulee......$"
    chaine db 10,13,"**** Debut du quantum de temps logiciel ****$"
    machaine db 10,10,13,"deroutement fait....",10,10,13,'$'
    compt dw 18         ; la routine 1ch est envoyer chaque 55 ms donc on aura 18 requete/sec
    nbr_iteration db 15 ; chaque 20sec on a une iteraion donc on aura 300/20=15 fois pour arreter le prog a 5mins.

data ENDS

maPile SEGMENT STACK
    
dw 256 dup(?)
tos label word

maPile ENDS

code SEGMENT
    assume CS:code, DS: data , ss:mapile
    

   ; 25h/21h installer un nouveau vecteur ; E/ AL : numero du vect a installer
                                          ;DS:DX  : les adresses cs et ip de la nouvelle routine d int
 ; procedure deroutement                                   
derout_1CH PROC NEAR

push ds   ; pour qu'on sauvegarde le ds de data et on le perd pas car apres le deroutement ds va contenir le cs de la nouvelle routine  
mov ax , seg new
mov ds , ax         ; ds <- cs de new 
mov dx , offset new ; dx <- ip de new
mov ax , 251CH
int 21H
pop ds 
           ret
derout_1CH ENDP

; procedure afficher
affiche PROC NEAR

mov ah , 09h
int 21h
        ret
affiche endp

; procedure methode logicielle
logicielle proc 
           mov cx,00fffh
boucle_ext:            
           mov si,01cf5h
boucle_int: 
          dec si
          jnz boucle_int 
          loop boucle_ext
          mov dx , offset chaine
          dec nbr_iteration 
          jz Exit
          call NEAR PTR affiche 
                
           ret
           
logicielle endp


; routine d'IT 1CH
new: 

    dec compt
    jnz fin               ; tant que le compt n"arrive pas a 0 ca veut dire qu'on est pas arriver a 1 sec donc on fait rien.
                          ; quand le compt arrive a 0 alors 1sec est arriver et donc on affichera le message : / 1 sec ecoulee / .
    mov dx,offset msg     ; on change l'offset avant d"appeler la fonction affiche .
    call NEAR PTR affiche

    mov compt , 18        ; on reinitialise le compt a 18 pour le prochain affichage .
    
 fin: iret

; Programme principal
start:
       mov ax , data
       mov ds , ax
       mov ax , maPile
       mov ss , ax
       lea sp, tos
       ;--------------->              ; changer juste l"offset au lieu d'ecrire 4 procedures car on aura beaucoup de redondance.
       mov dx , offset machaine       ; on met dans dx l'offset de machaine pour appeler la routine d"affichage
       call NEAR PTR affiche
       
       mov dx , offset chaine         
       call NEAR PTR affiche
       
       call NEAR PTR derout_1CH
; Mettre le processeur en attente pour le liberer et ne pas le mettre dans le doute.
infini:
        call near ptr logicielle
        jmp infini
       

      
; Fin programme !         
Exit : mov ax,4c00h
        int 21h
        
code ENDS
END start