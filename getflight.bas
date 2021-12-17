' PRELIMINARY DECLARATIONS (8-10)
filename$ = COMMAND$
DIM P(40, 11), Px(40, 5), Py(40, 5), Vx(40), Vy(40), B(1, 250), Ztel(33), Znme$(42), panel(2, 267), TSflagVECTOR(20)

' GET INPUT STREAM
801     k=1
802     OPEN "R", #1, filename$

        FileLen& = LOF(1)
        IF FileLen& = 0 THEN
          CLOSE #1
          KILL filename$
          PRINT "ERROR: File missing or empty"
          END
        END IF

        LINE INPUT #1, inpSTR$
        GET #1, 1, inpSTR$
        close #1
    
' VERSION AND CHARCHECK
        chkCHAR1$=left$(inpSTR$,1)
        chkCHAR2$=right$(inpSTR$,1)
        ORBITversion$=mid$(inpSTR$, 2, 7)
        ' Check WIP

' GATHER FLIGHT DATA
        DIM outSTR AS STRING

        outSTR += STR$(cvs(mid$(inpSTR$,17,4))) 'eng
        outSTR += STR$(cvi(mid$(inpSTR$,21,2))) 'vflag
        outSTR += STR$(cvi(mid$(inpSTR$,23,2))) 'Aflag
        outSTR += STR$(cvi(mid$(inpSTR$,25,2))) 'Sflag
        outSTR += STR$(cvd(mid$(inpSTR$,27,8))) 'Are
        outSTR += STR$(cvd(mid$(inpSTR$,35,8))) 'mag
        outSTR += STR$(cvs(mid$(inpSTR$,43,4))) 'Sangle
        outSTR += STR$(cvi(mid$(inpSTR$,47,2))) 'cen
        outSTR += STR$(cvi(mid$(inpSTR$,49,2))) 'targ
        outSTR += STR$(cvi(mid$(inpSTR$,51,2))) 'ref
        outSTR += STR$(cvi(mid$(inpSTR$,53,2))) 'trail
        outSTR += STR$(cvs(mid$(inpSTR$,55,4))) 'Cdh
        outSTR += STR$(cvs(mid$(inpSTR$,59,4))) 'SRB
        outSTR += STR$(cvi(mid$(inpSTR$,63,2))) 'tr
        outSTR += STR$(cvi(mid$(inpSTR$,65,2))) 'dte
        outSTR += STR$(cvd(mid$(inpSTR$,67,8))) 'ts
        outSTR += STR$(cvd(mid$(inpSTR$,75,8))) 'OLDts
        outSTR += STR$(cvs(mid$(inpSTR$,83,4))) 'vernP!
        outSTR += STR$(cvi(mid$(inpSTR$,87,2))) 'Eflag

        outSTR += STR$(cvi(mid$(inpSTR$,89,2))) 'year
        outSTR += STR$(cvi(mid$(inpSTR$,91,2))) 'day
        outSTR += STR$(cvi(mid$(inpSTR$,93,2))) 'hr
        outSTR += STR$(cvi(mid$(inpSTR$,95,2))) 'min
        outSTR += STR$(cvd(mid$(inpSTR$,97,8))) 'sec

        outSTR += STR$(cvs(mid$(inpSTR$,105,4)))  'AYSEangle
        outSTR += STR$(cvi(mid$(inpSTR$,109,2)))  'AYSEscrape
        outSTR += STR$(cvs(mid$(inpSTR$,111,4)))  'Wind2
        outSTR += STR$(cvs(mid$(inpSTR$,115,4)))  'Wind3
        outSTR += STR$(cvs(mid$(inpSTR$,119,4)))  'HABrotate%
        outSTR += STR$(cvi(mid$(inpSTR$,123,2)))  'AYSE
        outSTR += STR$(cvs(mid$(inpSTR$,125,4)))  'Ztel(9)
        outSTR += STR$(cvi(mid$(inpSTR$,129,2)))  'MODULEflag
        outSTR += STR$(cvs(mid$(inpSTR$,131,4)))  'AYSEdist
        outSTR += STR$(cvs(mid$(inpSTR$,135,4)))  'OCESSdist
        outSTR += STR$(cvi(mid$(inpSTR$,139,2)))  'explosion
        outSTR += STR$(cvi(mid$(inpSTR$,141,2)))  'explosion1
        outSTR += STR$(cvs(mid$(inpSTR$,143,4)))  'Ztel(1)
        outSTR += STR$(cvs(mid$(inpSTR$,147,4)))  'Ztel(2)
        outSTR += STR$(cvl(mid$(inpSTR$,151,4)))  'NAVmalf
        outSTR += STR$(cvs(mid$(inpSTR$,155,4)))  'Wind1
        outSTR += STR$(cvs(mid$(inpSTR$,159,4)))  'LONGtarg
        outSTR += STR$(cvs(mid$(inpSTR$,163,4)))  'Pr
        outSTR += STR$(cvs(mid$(inpSTR$,167,4)))  'Agrav
        k=171
        FOR i = 1 TO 39 'why the dashes within the numbers?
         outSTR += STR$(cvd(mid$(inpSTR$,k,8))):k=k+8 'Px(i,3)
         outSTR += STR$(cvd(mid$(inpSTR$,k,8))):k=k+8 'Py(i,3)
         outSTR += STR$(cvd(mid$(inpSTR$,k,8))):k=k+8 'Vx(i)
         outSTR += STR$(cvd(mid$(inpSTR$,k,8))):k=k+8 'Vy(i)
        NEXT i
        outSTR += STR$(cvs(mid$(inpSTR$,k,4))):k=k+4 'fuel
        outSTR += STR$(cvs(mid$(inpSTR$,k,4))):k=k+4 'AYSEfuel
        P(39,5)=Vx(37)
        Px(37, 3) = 4446370.8284487# + Px(3, 3): Py(37, 3) = 4446370.8284487# + Py(3, 3): Vx(37) = Vx(3): Vy(37) = Vy(3)
        ufo1 = 0
        ufo2 = 0
        IF Px(39, 3) <> 0 AND Py(39, 3) <> 0 THEN ufo2 = 1
        IF Px(38, 3) <> 0 AND Py(38, 3) <> 0 THEN ufo1 = 1
        Ltx = (P(ref, 5) * SIN(LONGtarg))
        Lty = (P(ref, 5) * COS(LONGtarg))
        Ltr = ref
        TSindex=5
        'for i=1 to 17
        '    if TSflagVECTOR(i)=ts then TSindex=i: goto 816
        'next i
        
        PRINT outSTR
        END

' Custom Data Template

'arraystart% = //0
'arrayend% = // # of data points
'array(arraystart, arrayend) =  //VALUES
'FOR i = 0 TO arrayend
'  IF array[i,2] = 2 THEN
'    outSTR += STR$(cvi(mid$(inpSTR$,"array[i,1]", array[i,2])))

'  ELSEIF array[i,2] = 4 THEN
'    outSTR += STR$(cvs(mid$(inpSTR$,"array[i,1]", array[i,2])))

'  ELSEIF array[i,2] = 8 THEN
'    outSTR += STR$(cvd(mid$(inpSTR$,"array[i,1]", array[i,2])))

'  ELSE
'    PRINT "ERROR"
'    END
'  END IF

'NEXT i
