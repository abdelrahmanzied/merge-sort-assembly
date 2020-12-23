org 100h


.data
; Given Arrayes
arr1 db 32h,32h,33h,38h
arr2 db 33h,35h,38h,30h 

;Output
array db 37h, 37h, 37h, 37h, 37h, 37h, 37h, 37h     ;initial values
     
     
          
.code   
; Call Merge
call merge
 
;Call Sort
call sort

;Call Remove Duplicate
call removeDuplicate

;Call Print
call print   
    


; M E R G E
proc merge
    mov ch, 0           ;counter
    mov bx, offset arr1 ;px points to first array  
    
    mergeLoop: 
        mov dh, [bx]    ;dh have arr[i]
        sub dh, 30h     
        mov [bx+8], dh  ;array[i] = arr1&arr2[i]
        
        inc bx          ;increament index
        inc ch          ;increament counter
        cmp ch,8        ;if (i<8)
        jb mergeLoop    ;jump if below
            
    ret
    merge endp



; S O R T                   
proc sort
    mov ch, 0                   ;size f parent loop
    mov bx, offset array        ;px points to output array
    
    sortLoop1:                  ;size of nested loop
        mov cl, 0
        mov bx, offset array    
        sortLoop2:
            mov dh, [bx]        ;df = array[i]
            mov dl, [bx+1]      ;dl = array[i+1]
            
            cmp dh,dl           ;if (dh > dl)
            ja makeSwap         ;jump if equal
            
            jmp sortLoop2End    ;scape swap
            
            makeSwap:
                call swap       ;calling swap
            
            sortLoop2end:       
                inc bx
                inc cl
                cmp cl,8
                jb sortLoop2        
        
        
        sortLoop1End:
            inc bx
            inc ch
            cmp ch,8           
            jb sortLoop1         
                        
    ret
    sort endp
    
 
    
; S W A P    
proc swap
    mov [bx], dl
    mov [bx+1], dh
    
    ret
    swap endp
                  


;R E M O V E  D U P L I C A T E
proc removeDuplicate
    mov ch, 0
    mov bx, offset array
    
    duplicateLoop:
        mov dh, [bx]
        mov dl, [bx+1]
        
        cmp dh,dl               ;if (dh == dl)
        je clear                ;jump if equal
        
        jmp duplicateLoopEnd    ;jump to print
        
        clear:
            call sympol
            
        duplicateLoopEnd:
            inc bx
            inc ch
            cmp ch,8
            jb duplicateLoop 
            
    ret
    removeDuplicate endp



;S Y M P O L
proc sympol
    mov dh,50h      ;dh = "c"
    mov [bx], dh    ;replace df or arr[i] with "c"
    
    ret
    sympol endp



; P R I N T
proc print
    mov ch, 0
    mov bx, offset array
    
    printLoop:
        mov dl, [bx]
        cmp dl, 50h     ;if (dl == 50h)
        je hide         ;skip sympol
        
        mov ah,2        ;ah=2 to print number
        add dl, 30h     ;subtract 30h
        int 21h         ;interrupt
        
        hide:                                      
            inc bx
            inc ch
            cmp ch,8    
            jb printLoop
              
    ret
    print endp                  