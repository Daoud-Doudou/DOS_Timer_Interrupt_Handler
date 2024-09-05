data SEGMENT
    
    chaine db " tache$"
    msg db " en cours d'execution....",10,13,'$'
    machaine db 10,10,13," deroutement fait....",10,10,13,'$'
    chaineOut db "",10,13,'$'
    compt dw 91
    cpt db 15  ; chaque 20sec on a une iteraion donc on aura 300/20=15 fois pour arreter le prog a 5mins.


data ENDS

maPile SEGMENT STACK
dw 256 dup(?)
tos label word
maPile ENDS

code SEGMENT
    assume CS:code, DS: data , ss:mapile
; 25h/21h installer un nouveau vecteur ; E/ AL : numero du vect a installer
                                       ; DS:DX : les adresses cs et ip de la nouvelle routine d it
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

; routine d'IT 1CH
new : 

    dec compt
    jnz fin1
                                                         
    inc bl                     ; inc a chaque fois pour obtenir 1 - 2 - 3 - 4 . 
    mov dx,offset Chaine                                     ; 31- 32  -33 - 34 en code ascii
    call NEAR PTR affiche
    mov dl,bl                  ; on met dans dl le code Ascii du caractere a afficher
    mov ah,2h                  ; la routine dECRITURE D"UN CARACTERE A L'ECRAN .
    int 21h
    mov dx,offset msg      
    call near PTR affiche
    mov compt,91
    cmp bl,34h                 ; on test si on est arriver au caractere 4 ou pas encore
    jne fin1
                               ; quand on arrive au caractere 4 on execute ces instructions 
    mov dx,offset ChaineOut    ; on met dans dx l'offset de ChaineOut pour appeler la routine d"affichage
    call NEAR PTR affiche      ; on fait un saut de ligne et on retourne a la ligne
    dec cpt                    ; a chaque decrementation ca veut dire que le programme a passer 20sec au plus de temps precedent
    mov bl,30h                 ; reinitialiser le code ascii pour qu"il commmencera la prochaine fois laffichage de 1 (on va l'incrementer apres pour que bl contiendra 31h)

            
      
fin1: iret 

; Programme principal
start : mov ax , data
       mov ds , ax
       mov ax , maPile
       mov ss , ax
       lea sp, tos
       mov bl,30h            ; le code ascii du 0 .
       
       mov dx,offset Machaine
       call NEAR PTR affiche
       
       call NEAR PTR derout_1CH
       
       next:  cmp cpt,0
              jnz next
; Fin programme !        
Exit :            
       mov ax,4c00h
       int 21h    
           
code ENDS
END start