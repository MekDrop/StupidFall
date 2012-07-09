Type Platform
    As Integer X1, Y1, W, Ratio, TRatio  
End Type
Screen 19, 8
Dim Platforms(1 to 21) As Platform, Fx As Integer, K As String, Speed As Integer, Score As Integer, Loose As Integer
Let Speed = 1
Do    
    Let K = Inkey 
    If Loose = 0 Then
        Sleep 10
        Line (800, 580)-(0, 0), 0, BF        
        For I = LBound(Platforms) To UBound(Platforms)
            If Platforms(I).Y1 > (600 + 2 + Platforms(I).W) Then
                Platforms(I).W = 0  
                Platforms(I).Y1 = 0
                Let Score = Score + I
                Let Speed = IIf( ( Fix(Score / (231 * Speed)) + 1) > Speed, Speed + 1, Speed)
            ElseIf Platforms(I).W < 1 Then
                If (((I - 1) >= LBound(Platforms)) And (Platforms(I-1).Y1 > 21)) Or ((I - 1) < LBound(Platforms))  Then 
                    Platforms(I).X1 = Fix(Rnd() * 800)            
                    Platforms(I).W = Fix(Rnd() * 30) + 20
                    Platforms(I).Y1 = 0 - Platforms(I).W - 2                
                    Platforms(I).Ratio = 0
                    Platforms(I).TRatio = Fix(Rnd() * 360)    
                End If
            Else
                Platforms(I).Y1 = Platforms(I).Y1 + Speed
                If Fix(Abs(Platforms(I).Ratio - Platforms(I).TRatio)) > 3 Then Platforms(I).Ratio = Platforms(I).Ratio + 3
                Draw "BC14BM" & Str(Platforms(I).X1) & "," & Str(Platforms(I).Y1) & "TA" & Str(Platforms(I).Ratio) & "L" & Str(Fix(2 / 2)) & "TA" & Str(Platforms(I).Ratio+90) & "L" & Str(Platforms(I).W) & "TA" & Str(Platforms(I).Ratio+180) & "L" & Str(2) & "TA" & Str(Platforms(I).Ratio+270) & "L" & Str(Platforms(I).W) & "TA" & Str(Platforms(I).Ratio) & "L" & Str(Fix(2 / 2)) & "BM" & Str(Platforms(I).X1) & "," & Str(Platforms(I).Y1) & "BD" & Str(Fix(Platforms(I).W/2))            
            End If
        Next I    
        For X = Fx To Fx + 20
            For Y = 560 To 580
                If Point(X, Y) > 0 Then Loose = -1
        Next Y, X
        Circle(Fx+10, 570), 10, 14, , , ,F
        Circle(Fx+6, 566), 2, 9, , , ,F
        Circle(Fx+14, 566), 2, 9, , , ,F
        Circle(Fx+10, 570), 2, 7, , , ,F
        Circle(Fx+10, 570), 7, 4, 222 * 3.14 / 180, 333 * 3.14 / 180                
        Let Fx = Fx + IIf(Len(K) > 1, IIf((Right(K, 1) = "M") And (Fx < 780), 20, IIf((Right(K, 1) = "K") And (Fx >= 20), -20, 0)), 0)    
        Line (800, 600)-(0, 580), 2, BF
        WindowTitle "Stupid Fall 0.1.1 : Score - " & Str(Score) & " : Speed - " & Str(Speed) & " : ESC - Exit    
    Else
        Locate 18, Fix((100 - Len("Game Over (Your Score - " & Str(Score) & ")")) / 2)
        Print "Game Over (Your Score - " & Str(Score) & ")"
    End If
Loop Until K = Chr(27)