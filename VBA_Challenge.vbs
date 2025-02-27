Sub AllStocksAnalysisRefactored()
    Dim startTime As Single
    Dim endTime  As Single

    yearValue = InputBox("What year would you like to run the analysis on?")
    
    startTime = Timer
    
    'Format the output sheet on All Stocks Analysis worksheet
    Worksheets("All Stocks Analysis").Activate
    
    Range("A1").Value = "All Stocks (" + yearValue + ")"
    
    'Create a header row
    Cells(3, 1).Value = "Ticker"
    Cells(3, 2).Value = "Total Daily Volume"
    Cells(3, 3).Value = "Return"

    'Initialize array of all tickers
    Dim tickerArray(12) As String
    
    tickerArray(0) = "AY"
    tickerArray(1) = "CSIQ"
    tickerArray(2) = "DQ"
    tickerArray(3) = "ENPH"
    tickerArray(4) = "FSLR"
    tickerArray(5) = "HASI"
    tickerArray(6) = "JKS"
    tickerArray(7) = "RUN"
    tickerArray(8) = "SEDG"
    tickerArray(9) = "SPWR"
    tickerArray(10) = "TERP"
    tickerArray(11) = "VSLR"
    
    'Activate data worksheet
    Worksheets(yearValue).Activate
    
    'Get the number of rows to loop over
    RowCount = Cells(Rows.Count, "A").End(xlUp).Row
    
    '1a) Create a ticker Index
    Dim tickerIndex As Integer
    tickerIndex = 0
    
    '1b) Create three output arrays
    Dim tickerVolumes(12) As Long
    Dim tickerStartingPrices(12) As Single
    Dim tickerEndingPrices(12) As Single
    
    '2a) Create a for loop to initialize the tickerVolumes to zero.
    For i = 0 To 11
        tickerVolumes(i) = 0
    Next i
    
    '2b) Loop over all the rows in the spreadsheet.
    For i = 2 To RowCount
        '3a) Increase volume for current ticker
        If tickerArray(tickerIndex) = Cells(i, 1).Value Then

            tickerVolumes(tickerIndex) = tickerVolumes(tickerIndex) + Cells(i, 8).Value

        End If
        
        '3b) Return
        'starting price for current ticker
        If tickerArray(tickerIndex) <> Cells(i + -1, 1).Value Then
            
            tickerStartingPrices(tickerIndex) = Cells(i, 6).Value
            
        End If
            
        'ending price for current ticker
        If tickerArray(tickerIndex) <> Cells(i + 1, 1).Value Then

            tickerEndingPrices(tickerIndex) = Cells(i, 6).Value
            
        End If
        
        '3c) check if the current row is the last row with the selected ticker
        'If the next row’s ticker doesn’t match, increase the tickerIndex.
        If tickerArray(tickerIndex) <> Cells(i + 1, 1).Value Then
            
            '3d Increase the tickerIndex.
            tickerIndex = tickerIndex + 1
            
        End If
        
    Next i
        
    Worksheets("All Stocks Analysis").Activate
    
    '4) Loop through your arrays to output the Ticker, Total Daily Volume, and Return.
    For i = 0 To 11
        
        Cells(i + 4, 1).Value = tickerArray(i)
        Cells(i + 4, 2).Value = tickerVolumes(i)
        Cells(4 + i, 3).Value = tickerEndingPrices(i) / tickerStartingPrices(i) - 1
        
    Next i
        
    'Formatting
    Worksheets("All Stocks Analysis").Activate
    Range("A3:C3").Font.FontStyle = "Bold"
    Range("A3:C3").Borders(xlEdgeBottom).LineStyle = xlContinuous
    Range("B4:B15").NumberFormat = "#,##0"
    Range("C4:C15").NumberFormat = "0.0%"
    Columns("B").AutoFit

    dataRowStart = 4
    dataRowEnd = 15

    For i = dataRowStart To dataRowEnd
        
        If Cells(i, 3) > 0 Then
            
            Cells(i, 3).Interior.Color = vbGreen
            
        Else
        
            Cells(i, 3).Interior.Color = vbRed
            
        End If
        
    Next i
 
    endTime = Timer
    MsgBox "This code ran in " & (endTime - startTime) & " seconds for the year " & (yearValue)

End Sub
