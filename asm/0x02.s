//cerinta 0x02
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
   
   
   
   read_mode: .asciz  "r"
   write_mode: .asciz  "w"
   fisier_in: .asciz "in.txt"
   fisier_out: .asciz "out.txt"
   format_fscanf: .asciz "%d"
   format_fprintf: .asciz "%d "
   format_fprintf_endl: .asciz "\n"
   continut_fisier: .space 4
   
   //memoram adresele fisierelor in.txt/out.txt pentru a le putea folosi 
   //la inchidere (fclose) / afisare (out.txt --> %edi)
   adresa_edi: .space 4
   adresa_esi: .space 4
  
  

.text

.global main

main:
   //deschidem fisierul in.txt
   push $read_mode        
   push $fisier_in     
   call fopen                    
   pop %ebx
   pop %ebx                   
   mov %eax,%esi  
   mov %esi,adresa_esi                 

   //deschidem fisierul out.txt
   push $write_mode      
   push $fisier_out  
   call fopen                  
   pop %ebx
   pop %ebx                   
   mov %eax,%edi
   mov %edi,adresa_edi
   
   

   //citire m (linii)
   push $continut_fisier     
   push $format_fscanf    
   push %esi                      
   call fscanf                   
   pop %ebx
   pop %ebx
   pop %ebx 
   //bordare
   mov continut_fisier,%ebx
   movl %ebx,m
   movl %ebx,m_vechi
   incl m
   incl m
   
   
   
   
   //citire n (coloane)
   push $continut_fisier      
   push $format_fscanf    
   push %esi                      
   call fscanf                   
   pop %ebx
   pop %ebx
   pop %ebx 
   //bordare
   mov continut_fisier,%ebx
   movl %ebx,n
   movl %ebx,n_vechi
   incl n
   incl n
   
   
   
   
   //citire p (nr celule vii)
   push $continut_fisier      
   push $format_fscanf    
   push %esi                      
   call fscanf                   
   pop %ebx
   pop %ebx
   pop %ebx  
   mov continut_fisier,%ebx
   movl %ebx,p
   



movl $0,%ecx  
et_citire_matrice:

   cmp p,%ecx
   je et_citire_k
   
   
   push %ecx
   
   //incrementam pozitiile (i,j) pentru a afla pozitiile celulelor vii in matricea bordata(extinsa)
   //citire pozitie i(linie)
   push $continut_fisier      
   push $format_fscanf    
   push %esi                      
   call fscanf                   
   pop %ebx
   pop %ebx
   pop %ebx 
   mov continut_fisier,%ebx
   movl %ebx,i
   incl i
   
   //citire pozitie j(coloana)
   push $continut_fisier      
   push $format_fscanf    
   push %esi                      
   call fscanf                   
   pop %ebx
   pop %ebx
   pop %ebx  
   mov continut_fisier,%ebx
   movl %ebx,j
   incl j
   
   pop %ecx
   
   
   //calculam indicele unde trebuie plasat elementul 1 --> pozitie=i*n+j
   movl i,%eax
   mull n
   addl j,%eax
   
   //incarcam elementele in matrice 
   lea a,%edi
   movl $1,(%edi,%eax,4)
   
   incl %ecx
   jmp et_citire_matrice
   
   
et_citire_k://citim valoarea lui k = nr transformari
   push $continut_fisier      
   push $format_fscanf    
   push %esi                      
   call fscanf                   
   pop %ebx
   pop %ebx
   pop %ebx  
   mov continut_fisier,%ebx
   movl %ebx,k



movl $0,index

et_modificare://avem k iteratii / transformari

incl index 
movl index,%ecx
cmp %ecx,k
jl et_afisare
   
   
movl $0,i
for_linie://parcurgere pe linie
    incl i
    movl i,%ecx
    cmp %ecx, m_vechi
    jl et_update_a    
      
    movl $0,j
    for_coloana://parcurgere pe coloana
       incl j
       movl j,%ecx
       cmp %ecx, n_vechi
       jl for_linie
       
       
       
       
       //calculam suma vecinilor lui a[i][j] , care va fi numarul total de celule vii / vecini de 1
       //in %ecx memoram suma
       //in %ebx memoram ,pe rand, vecinii
       //in %eax memoram pozitia vecinului
       //calculcam pentru fiecare element pozitia corespunzatoare
       
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
      
      
      
      
      //verificam daca celula este vie sau moarta
      //memoram elementul curent in %ebx
      //calculam pozitia lui %ebx in cadrul matricei(extinse)
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
      
      
      
     

celula_vie: //studiem cazurile posibile pentru o celula vie ,nr_vecini = %ecx
   cmp $2,%ecx
   jl subpopulare
   
   cmp $2,%ecx
   je continuitate_vie
   
   cmp $3,%ecx
   je continuitate_vie
   
   cmp $3,%ecx
   jl ultrapopulare
   
celula_moarta://studiem cazurile posibile pentru o celula moarta , nr_vecini= %ecx
   cmp $3,%ecx
   je creare
   
   jmp continuitate_moarta
   
   
   
   
//subcazuri
//memoram in a_nou matricea obtinuta dupa transformare
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
   
 
 
//memoram a_nou in a pentru a putea trece la urmatoarea iteratie <=> a=a_nou 
et_update_a:
   movl $0,%ecx
   //calculam cate iteratii facem pentru update => n*m = %eax
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
      
 
 
//afisare matrice 
et_afisare: 
    
   movl $0,i
   
   for_lines:
      incl i
      movl i,%ecx
      cmp %ecx,m_vechi
      jl et_exit
      
      movl $1,j
      for_col:
         movl j,%ecx
         cmp %ecx,n_vechi
         jl continuare
         
         
         
         //calculare indice 
         movl i,%eax
         mull n
         addl j,%eax
         lea a ,%edi 
         movl (%edi,%eax,4),%ebx
         
         
         //punem in %edi adresa s-a initiala(de la deschiderea out.txt) pentru afisare 
         mov adresa_edi,%edi
         
         
         push %ebx     
         push $format_fprintf             
         push %edi                    
         call fprintf                
         pop %ebx
         pop %ebx
         pop %ebx  
         
                
         incl j
         jmp for_col
         
   
   continuare:
         //afisam un endl   
         push $format_fprintf_endl           
         push %edi                    
         call fprintf                
         pop %ebx
         pop %ebx
         jmp for_lines
   
      
et_exit:
  
   //inchidem fisierele in.txt/out.txt
   mov adresa_esi,%esi
   mov adresa_edi,%edi
   push %esi                   
   call fclose                 
   pop %ebx                 
   push %edi                    
   call fclose                 
   pop %ebx
   pushl $0
   call fflush
   popl %ebx
   movl $1,%eax
   movl $0,%ebx
   int  $0x80   

