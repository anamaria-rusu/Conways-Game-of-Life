//cerinta 0x01
.data
   a: .space 1600
   m: .space 4
   n: .space 4
   p: .space 4
   k: .space 4
   index: .space 4
   i: .space 4
   j: .space 4
   
   a_nou: .space 1600
   m_vechi: .space 4
   n_vechi: .space 4
   i_suma: .space 4
   j_suma: .space 4
   
   
   
   mesaj_xorat: .space 1600
   a_mesaj: .space 1600
   cript_decript: .space 4
   index_af: .space 4
   index_for: .space 4
   adresa: .space 4
   adresa_final: .space 4
   
   lungime_mesaj: .space 4
   len_a: .space 4
   len_a_mesaj: .space 4
   contor: .space 4
   diferenta_xor: .space 4
   contor_xorat: .space 4
   xor_afisare: .space 4
   diferenta_0: .space 4
   caracter_mesaj: .space 4
   mesaj: .space 10
   
   scan_format_d: .asciz "%d"
   scan_format_s: .asciz "%s"
   print_format_d: .asciz "%d"
   print_format_c: .asciz "%c"
   print_format_X: .asciz "%X"
   print_0x: .asciz "0x"
 



.text

.global main

main:
   //codul de la cerinta 0x00:
   //citire m (linii)
   pushl $m
   pushl $scan_format_d
   call scanf
   popl %ebx
   popl %ebx
   movl m,%ebx
   movl %ebx,m_vechi
   incl m
   incl m
   
   
   //citire n (coloane)
   pushl $n
   pushl $scan_format_d
   call scanf
   popl %ebx
   popl %ebx
   movl n,%ebx
   movl %ebx,n_vechi
   incl n
   incl n
   
   
   //citire p (nr celule vii)
   pushl $p
   pushl $scan_format_d
   call scanf
   popl %ebx
   popl %ebx
   



movl $0,%ecx  
et_citire_matrice:

   cmp p,%ecx
   je et_citire_k
   
   push %ecx
   pushl $i
   pushl $scan_format_d
   call scanf
   popl %ebx
   popl %ebx
   incl i
   
   pushl $j
   pushl $scan_format_d
   call scanf
   popl %ebx
   popl %ebx
   incl j
   pop %ecx
  
   movl i,%eax
   mull n
   addl j,%eax
   
   lea a,%edi
   movl $1,(%edi,%eax,4)
   
   incl %ecx
   jmp et_citire_matrice
   
   
 

et_citire_k:/
   pushl $k
   pushl $scan_format_d
   call scanf
   popl %ebx
   popl %ebx



movl $0,index
et_modificare:

incl index 
movl index,%ecx
cmp %ecx,k
jl et_cerinta_0x01
   
   
movl $0,i
for_linie:
    incl i
    movl i,%ecx
    cmp %ecx, m_vechi
    jl et_update_a    
      
    movl $0,j
    for_coloana:
       incl j
       movl j,%ecx
       cmp %ecx, n_vechi
       jl for_linie
      
      
       movl $0,%ecx
       movl i,%edx
       movl %edx,i_suma
       movl j,%edx
       movl %edx,j_suma
       
       //a[i-1][j-1]
       decl i_suma
       decl j_suma
       movl $0,%edx
       movl i_suma,%eax
       mull n
       addl j_suma,%eax
       lea a,%edi
       movl (%edi,%eax,4),%ebx
       addl %ebx,%ecx
       
       //a[i-1][j]
       incl j_suma
       movl $0,%edx
       movl i_suma,%eax
       mull n
       addl j_suma,%eax
       lea a,%edi
       movl (%edi,%eax,4),%ebx
       addl %ebx,%ecx
      
       //a[i-1][j+1] 
       incl j_suma
       movl $0,%edx
       movl i_suma,%eax
       mull n
       addl j_suma,%eax
       lea a,%edi
       movl (%edi,%eax,4),%ebx
       addl %ebx,%ecx
      
       //a[i][j+1] 
       incl i_suma
       movl $0,%edx
       movl i_suma,%eax
       mull n
       addl j_suma,%eax
       lea a,%edi
       movl (%edi,%eax,4),%ebx
       addl %ebx,%ecx
     
        //a[i][j-1]
       decl j_suma
       decl j_suma
       movl $0,%edx
       movl i_suma,%eax
       mull n
       addl j_suma,%eax
       lea a,%edi
       movl (%edi,%eax,4),%ebx
       addl %ebx,%ecx
      
        //a[i+1][j-1]
       incl i_suma
       movl $0,%edx
       movl i_suma,%eax
       mull n
       addl j_suma,%eax
       lea a,%edi
       movl (%edi,%eax,4),%ebx
       addl %ebx,%ecx
       
        //a[i+1][j]
       incl j_suma
       movl $0,%edx
       movl i_suma,%eax
       mull n
       addl j_suma,%eax
       lea a,%edi
       movl (%edi,%eax,4),%ebx
       addl %ebx,%ecx
      
        //a[i+1][j+1]
       incl j_suma
       movl $0,%edx
       movl i_suma,%eax
       mull n
       addl j_suma,%eax
       lea a,%edi
       movl (%edi,%eax,4),%ebx
       addl %ebx,%ecx
      
      
       movl $0,%edx
       movl i,%eax
       mull n
       addl j,%eax
       lea a,%edi
       movl (%edi,%eax,4),%ebx
       
      
       cmp $1,%ebx
       je celula_vie
       cmp $0,%ebx
       je celula_moarta
      
      
     

celula_vie: 
   cmp $2,%ecx
   jl subpopulare
   
   cmp $2,%ecx
   je continuitate_vie
   
   cmp $3,%ecx
   je continuitate_vie
   
   cmp $3,%ecx
   jl ultrapopulare
   
celula_moarta:
   cmp $3,%ecx
   je creare
   jmp continuitate_moarta
   
   
 
subpopulare: 
   lea a_nou,%edi
   movl $0,(%edi,%eax,4)
   jmp for_coloana
   
continuitate_vie:
   lea a_nou,%edi
   movl $1,(%edi,%eax,4)
   jmp for_coloana   
   
ultrapopulare:
   lea a_nou,%edi
   movl $0,(%edi,%eax,4)
   jmp for_coloana
   
creare:
   lea a_nou,%edi
   movl $1,(%edi,%eax,4)
   jmp for_coloana  
 
continuitate_moarta:
   lea a_nou,%edi
   movl $0,(%edi,%eax,4)
   jmp for_coloana
   
 

et_update_a:
   movl $0,%ecx
   movl n,%eax
   mull m
  
  
   et_iteratie:
      cmp %eax,%ecx
      je et_modificare
   
      lea a_nou ,%esi
      movl (%esi,%ecx,4),%ebx
      lea a, %edi
      mov %ebx,(%edi,%ecx,4)
      incl %ecx
      jmp et_iteratie
      





et_cerinta_0x01:
   //citim variabila cript_decript ( criptare - 0 || decriptare - 1 )
   push $cript_decript
   push $scan_format_d
   call scanf
   pop %ebx
   pop %ebx

   //citim mesajul ; folosim functia "strlen" din C care returneaza in registul %eax nr de caractere 
   //ale unui string
   push $mesaj
   push $scan_format_s
   call scanf
   pop %ebx
   pop %ebx
   push $mesaj
   call strlen
   pop %ebx
   movl %eax, lungime_mesaj 
   


   //verificam daca este vorba despre o criptare sau despre o decriptare
   movl cript_decript,%edx
   cmp $0,%edx
   je et_criptare
   jmp et_decriptare
  
  
   
et_criptare:
   //mesajul in clar este indexat de la 0
   movl $0, index_for
   jmp et_parcurgere_mesaj
   
   
et_decriptare:
   //mesajul in hexa(string) este indexat de la 2
   //conform cerintei , sirul incepe cu "0x" , caractere de care nu avem nevoie la decriptare
   movl $2,index_for
   jmp et_parcurgere_mesaj



et_parcurgere_mesaj:
   //parcurgem mesajul caracter cu caracter
   movl index_for,%ecx
   cmp lungime_mesaj,%ecx
   je et_xor
   movl $2,%ebx
   movl $0,%eax
   lea mesaj,%edi
   mov (%edi,%ecx,1),%al 
   incl index_for
   movl $0,%ecx
   
   
   //verificam daca avem criptare su decriptare
   movl cript_decript,%edx
   cmp $0,%edx
   movl $8,diferenta_0
   je et_binar_criptare
   
   movl $4,diferenta_0
   jmp et_dictionar_decriptare
   

//pentru criptare luam codul ASCII al fiecarui caracter si il transformam in binar
et_binar_criptare:
   cmp $0,%eax
   je et_0_criptare
   movl $0,%edx
   divl %ebx
   push %edx
   incl index_af
   decl diferenta_0
   jmp et_binar_criptare  


//numarul obtinut trenuie sa fie pe 8 biti . pentru codificare ascii ,care nu are 8 biti initial (ex: '5':
//110101 - lipsesc 2 "biti" de 0) , va trebuie sa ii adaugam in et_0_criptare 
et_0_criptare:
   movl diferenta_0,%ecx
   cmp $0,%ecx
   je et_incarare_mesaj
   push $0
   incl index_af
   decl diferenta_0
   jmp et_0_criptare
   
   
   
   
//pentru decriptare analizam fiecare caz posibil  
et_dictionar_decriptare:
   cmp $48 ,%al
   je et_0
   cmp $49 ,%al
   je et_1
   cmp $50 ,%al
   je et_2
   cmp $51,%al
   je et_3
   cmp $52 ,%al
   je et_4
   cmp $53 ,%al
   je et_5
   cmp $54 ,%al
   je et_6
   cmp $55 ,%al
   je et_7
   cmp $56 ,%al
   je et_8
   cmp $57 ,%al
   je et_9
   cmp $65 ,%al
   je et_A
   cmp $66 ,%al
   je et_B
   cmp $67 ,%al
   je et_C
   cmp $68 ,%al
   je et_D
   cmp $69 ,%al
   je et_E
   cmp $70 ,%al
   je et_F
   
   
   
et_0:
   movl $0,%eax
   jmp et_binar_decriptare
et_1:
   movl $1,%eax
   jmp et_binar_decriptare
et_2:
   movl $2,%eax
   jmp et_binar_decriptare
et_3:
   movl $3,%eax
   jmp et_binar_decriptare
et_4:
   movl $4,%eax
   jmp et_binar_decriptare
et_5:
   movl $5,%eax
   jmp et_binar_decriptare
et_6:
   movl $6,%eax
   jmp et_binar_decriptare
et_7:
   movl $7,%eax
   jmp et_binar_decriptare
et_8:
   movl $8,%eax
   jmp et_binar_decriptare
et_9:
   movl $9,%eax
   jmp et_binar_decriptare
et_A:
   movl $10,%eax
   jmp et_binar_decriptare
et_B:
   movl $11,%eax
   jmp et_binar_decriptare
et_C:
   movl $12,%eax
   jmp et_binar_decriptare   
et_D:
   movl $13,%eax
   jmp et_binar_decriptare
et_E:
   movl $14,%eax
   jmp et_binar_decriptare
et_F:
   movl $15,%eax
   jmp et_binar_decriptare
   
   
et_binar_decriptare:
   cmp $0,%eax
   je et_0_decriptare
   movl $0,%edx
   divl %ebx
   push %edx
   incl index_af
   decl diferenta_0
   jmp et_binar_decriptare 

//numerele ar trebuie sa fie pe 4 biti . restul de "0" de care avem nevoie vor fi adaugati in at_0_decriptare   
et_0_decriptare:
   movl diferenta_0,%ecx
   cmp $0,%ecx
   je et_incarare_mesaj
   push $0
   incl index_af
   decl diferenta_0
   jmp et_0_decriptare
      
   
   
   
//incarcam ce am obtinut din fiecare caracter in "a_mesaj" 
et_incarare_mesaj:
   movl index_af,%ecx
   cmp $0,%ecx
   je et_parcurgere_mesaj

   lea a_mesaj,%esi
   pop %ebx
   movl adresa, %eax
   movl %ebx, (%esi,%eax,4)
   incl adresa
   
   
   movl index_af,%ecx
   decl %ecx
   movl %ecx,index_af
   jmp et_incarare_mesaj






et_xor:
   //lungimea cheii(a)
   movl $0,%edx
   movl n,%eax
   mull m
   movl %eax, len_a
   
   movl adresa,%eax
   //eax=len_a-len_a_mesaj(=adresa)
   sub len_a ,%eax
   movl %eax, diferenta_xor
   movl $0,%ecx
   movl $0,%edx
   
   
   //cazuri posibile 
   cmp $0,%eax
   jg et_prelungire_cheie
   
   cmp $0,%eax
   jl et_mesaj_xorat
   
   cmp $0,%eax
   je et_mesaj_xorat
   
   



et_prelungire_cheie:
   cmp contor,%eax
   jl et_mesaj_xorat
   
   lea a,%edi
   movl contor,%ecx
   movl len_a,%edx
   addl contor,%edx
   
   movl (%edi,%ecx,4),%ebx
   movl %ebx,(%edi,%edx,4)
   
   incl contor 
   jmp et_prelungire_cheie




//xor-am a si a_mesaj pentru a afla mesjul criptat/decriptat de care avem nevoie
et_mesaj_xorat:
    movl contor_xorat ,%eax
    cmp adresa,%eax
    je et_verificare_afisare
    
    
    lea a,%edi
    lea a_mesaj,%esi
    lea mesaj_xorat, %ebp
   
    movl (%edi,%eax,4),%ecx
    movl (%esi,%eax,4),%edx
    xor %ecx,%edx
    movl %edx ,(%ebp,%eax,4)
    
    incl contor_xorat
    jmp et_mesaj_xorat
    




//verificam ce trebuie sa afisam
et_verificare_afisare:
   movl cript_decript,%edx
   cmp $0,%edx
   je et_0x
   jmp et_afisare_decriptare
 
 
 
 
 
//pentru criptare trebuie sa afisam si "0x" (prefixarea pentru un sir hexazecimal)   
et_0x:
     push $print_0x
     call printf
     pop %ebx
     pushl $0
     call fflush
     popl %ebx
     jmp et_afisare_criptare
      
     
et_afisare_criptare:
     movl xor_afisare,%ecx
     cmp adresa,%ecx
     je et_exit
     
     movl $0,%ecx
     
     //contruim numarul in zecimal , grupand cate 4 , apoi afisam in hexa
     movl $8,%eax
     movl xor_afisare,%edx
     lea mesaj_xorat,%ebp
     movl (%ebp,%edx,4),%ebx
     movl $0,%edx
     mull %ebx
     addl %eax,%ecx
     incl xor_afisare
     
     movl $4,%eax
     movl xor_afisare,%edx
     lea mesaj_xorat,%ebp
     movl (%ebp,%edx,4),%ebx
     movl $0,%edx
     mull %ebx
     addl %eax,%ecx
     incl xor_afisare
     
     movl $2,%eax
     movl xor_afisare,%edx
     lea mesaj_xorat,%ebp
     movl (%ebp,%edx,4),%ebx
     movl $0,%edx
     mull %ebx
     addl %eax,%ecx
     incl xor_afisare
     
     movl $1,%eax
     movl xor_afisare,%edx
     lea mesaj_xorat,%ebp
     movl (%ebp,%edx,4),%ebx
     movl $0,%edx
     mull %ebx
     addl %eax,%ecx
     incl xor_afisare
     
     push %ecx
     push $print_format_X
     call printf
     pop %ebx
     pop %ebx
     pushl $0
     call fflush
     popl %ebx
     
     jmp et_afisare_criptare
  

 
 
et_afisare_decriptare:
     movl xor_afisare,%ecx
     cmp adresa,%ecx
     je et_exit
     
     
     movl $0,%ecx
     
     //contruim numarul in zecimal , grupand cate 8 , apoi afisam in clar
     movl $128,%eax
     movl xor_afisare,%edx
     lea mesaj_xorat,%ebp
     movl (%ebp,%edx,4),%ebx
     movl $0,%edx
     mull %ebx
     addl %eax,%ecx
     incl xor_afisare
     
     movl $64,%eax
     movl xor_afisare,%edx
     lea mesaj_xorat,%ebp
     movl (%ebp,%edx,4),%ebx
     movl $0,%edx
     mull %ebx
     addl %eax,%ecx
     incl xor_afisare
     
     movl $32,%eax
     movl xor_afisare,%edx
     lea mesaj_xorat,%ebp
     movl (%ebp,%edx,4),%ebx
     movl $0,%edx
     mull %ebx
     addl %eax,%ecx
     incl xor_afisare
     
     movl $16,%eax
     movl xor_afisare,%edx
     lea mesaj_xorat,%ebp
     movl (%ebp,%edx,4),%ebx
     movl $0,%edx
     mull %ebx
     addl %eax,%ecx
     incl xor_afisare
     
     movl $8,%eax
     movl xor_afisare,%edx
     lea mesaj_xorat,%ebp
     movl (%ebp,%edx,4),%ebx
     movl $0,%edx
     mull %ebx
     addl %eax,%ecx
     incl xor_afisare
     
     movl $4,%eax
     movl xor_afisare,%edx
     lea mesaj_xorat,%ebp
     movl (%ebp,%edx,4),%ebx
     movl $0,%edx
     mull %ebx
     addl %eax,%ecx
     incl xor_afisare
     
     movl $2,%eax
     movl xor_afisare,%edx
     lea mesaj_xorat,%ebp
     movl (%ebp,%edx,4),%ebx
     movl $0,%edx
     mull %ebx
     addl %eax,%ecx
     incl xor_afisare
     
     movl $1,%eax
     movl xor_afisare,%edx
     lea mesaj_xorat,%ebp
     movl (%ebp,%edx,4),%ebx
     movl $0,%edx
     mull %ebx
     addl %eax,%ecx
     incl xor_afisare
     
     push %ecx
     push $print_format_c
     call printf
     pop %ebx
     pop %ebx
     pushl $0
     call fflush
     popl %ebx
     
     jmp et_afisare_decriptare
   
   
   
et_exit:
   pushl $0
   call fflush
   popl %ebx
   movl $1,%eax
   movl $0,%ebx
   int  $0x80

