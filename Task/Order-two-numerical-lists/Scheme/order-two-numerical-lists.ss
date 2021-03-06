(define (lex<? a b)
        (cond ((null? b) #f)
              ((null? a) #t)
              ((= (car a) (car b)) (lex<? (cdr a) (cdr b)))
              (else (< (car a) (car b)))))
