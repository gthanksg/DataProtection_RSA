Unit Main;

Interface

Uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, System.IOUtils, System.Math, System.StrUtils;

Type
    TMainForm = class(TForm)
        EditP: TEdit;
        EditQ: TEdit;
    EncButton: TButton;
    DecButton: TButton;
        InfoMemo: TMemo;
    EditD: TEdit;
    EditR: TEdit;
        ResultMemo: TMemo;
        Procedure FormCreate(Sender: TObject);
    Procedure EditPChange(Sender: TObject);
    Procedure EditQChange(Sender: TObject);
    Procedure EncButtonClick(Sender: TObject);
    Procedure EditDChange(Sender: TObject);
    Procedure EditRChange(Sender: TObject);
    Procedure DecButtonClick(Sender: TObject);
    Private
       { Private declarations }
    Public
       { Public declarations }
    End;

Var
    MainForm: TMainForm;

Implementation

{$R *.dfm}

Const
    FILENAME = 'test.txt';
    DECFILENAME = 'dec.txt';

Type
    TStringDynArray = Array of String;


Function IsPrime(X: Integer): Boolean;
Var
    I: Integer;
Begin
    Result := False;
    If not Odd(X) And (X <> 2) Then Exit;
    I := 3;
    While i <= Sqrt(X) do
    Begin
        If X Mod I = 0 then Exit;
        Inc(I, 2);
    End;
    Result := true;
End;

Procedure TMainForm.EditDChange(Sender: TObject);
Begin
    DecButton.Enabled := (Length(EditD.Text) > 0) And (Length(EditR.Text) > 0);
End;

Procedure TMainForm.EditPChange(Sender: TObject);
Begin
    EncButton.Enabled := (Length(EditP.Text) > 0) And (Length(EditQ.Text) > 0);
End;

Procedure TMainForm.EditQChange(Sender: TObject);
Begin
    EncButton.Enabled := (Length(EditP.Text) > 0) And (Length(EditQ.Text) > 0);
End;

Procedure TMainForm.EditRChange(Sender: TObject);
Begin
    DecButton.Enabled := (Length(EditD.Text) > 0) And (Length(EditR.Text) > 0);
End;

Procedure ClearMemos(ResultMemo: TMemo; InfoMemo: TMemo);   
Begin
    ResultMemo.Clear;
    InfoMemo.Clear;
End;

Function GCD(A, B: Integer) : Integer;
Var
    Temp: Integer;
Begin
    While not(B = 0) do
    Begin
        Temp := B;
		B := A Mod B;
		A := Temp;
    End;
    Result := A;
End;

Function GetRandExp(Phi, R: Integer) : Integer;
Var
    E: Integer;
Begin
    E := 2 + Random(Phi - 1);
    While (True) Do
    Begin
        If GCD(E, Phi) = 1 then
        Begin
            Result := E;
            Break;
        End;
        E := (E + 1) Mod R;
        If (E <= 2) then 
            E := 3;
    End;
End;

Function GetRandExp1(Phi, R: Integer) : Integer;
Var
    E, I: Integer;
Begin
    For I := 2 to R - 1 do 
    Begin
        If GCD(I, Phi) = 1 then
        Begin
            Result := I;
            Break;
        End;
    End;
End;

Function Inverse(N, Modulus: Integer) : Integer;
Var
    A, B, X, Y, X0, Y0, Q, Temp: Integer;
Begin
    A := N;
    B := Modulus;
    X := 0;
    Y := 1;
    X0 := 1;
    Y0 := 0;
    While not (B = 0) do
    Begin
        Q := A Div B;
		Temp := A Mod B;
		A := B;
		B := Temp;
		Temp := X; X := X0 - Q * X; X0 := Temp;
		Temp := Y; Y := Y0 - Q * Y; Y0 := Temp;
    End;
    If (X0 < 0) then
        X0 := X0 + Modulus;
	Result := X0;
End;

Function FileToBytes(const AName: String; var Bytes: TBytes): Boolean;
Var
    Stream: TFileStream;
Begin
    If not FileExists(AName) then
    Begin
        Result := False;
        Exit;
    End;
    Stream := TFileStream.Create(AName, fmOpenRead);
    Try
        SetLength(Bytes, Stream.Size);
        Stream.ReadBuffer(Pointer(Bytes)^, Stream.Size);
    Finally
         Stream.Free;
    End;
    Result := True;
End;

Function FastPower(Value, Pow: Int64) : Int64;
Var
    Res: Int64;
Begin
    Res := 1;
    While (Pow > 0) do
    Begin
        If (Pow Mod 2) = 1 then
            Res := Res * Value;
        Value := Value * Value;
        Pow := Pow Div 2;
    End;
    Result := Res;
End;

Function ModPow1(A, B: Int64; C: Integer) : Integer;
Var
    Res: Int64;
Begin
    Res := FastPower(A, B);
    Res := Res mod C;
    Result := Res;
End;

Function ModPow(A, B: Int64; C: Integer) : Integer;
Var
    Res: Int64;
Begin
    Res := 1;
    While (B > 0) do
    Begin
        If ((B Mod 2) = 1) then
        Begin
            Res := (Res * A) Mod C;     
        End;
        B := B Shr 1;
        A := (A * A) Mod C;
    End;
    Result := Res;
End;

Function Encode(X, E, N: Integer) : Integer;
Begin
    Result := ModPow(X, E, N);
End;

Function Decode(X, D, N: Integer) : Integer;
Begin
    Result := ModPow(X, D, N);
End;

Procedure EncodeFile(Exp, R: Integer; FileContents: TBytes; ResultMemo: TMemo);
Var
    I: Integer;
    ResString: String;
Begin
    For I := 0 to Length(FileContents) - 1 do
    Begin
        ResString := ResString + IntToStr(Encode(FileContents[I], Exp, R)) + ' ';
    End;
    ResultMemo.Lines.Add('Result: ');
    ResultMemo.Text := ResString;
End;

Procedure TMainForm.EncButtonClick(Sender: TObject);
Var
    P, Q, R, Phi, Exp, D: Integer;
    FileContents: TBytes;
Begin
    ClearMemos(ResultMemo, InfoMemo);
    P := StrToInt(EditP.Text);
    Q := StrToInt(EditQ.Text);
    If (IsPrime(P) and IsPrime(Q)) then
    Begin
        InfoMemo.Lines.Add('> P: ' + EditP.Text + ' is prime number;');
        InfoMemo.Lines.Add('> Q: ' + EditQ.Text + ' is prime number;');
        R := P * Q;
        InfoMemo.Lines.Add('> R: ' + IntToStr(R) + ';');
        If R < 128 then
        Begin
            ShowMessage('Modulus size can''t be less than 128! Try bigger P & Q values!');
            Exit;
        End;
        Phi := (P - 1) * (Q - 1);
        InfoMemo.Lines.Add('> Phi: ' + IntToStr(Phi) + ';');
        Exp := GetRandExp(Phi, R);
        InfoMemo.Lines.Add('> Exp: ' + IntToStr(Exp) + ';');
        D := Inverse(Exp, Phi);
        InfoMemo.Lines.Add('> Private Exponent: ' + IntToStr(D) + ';');
        InfoMemo.Lines.Add('> Private Key: {' + IntToStr(D) + ', ' + IntToStr(R) + '};');
        InfoMemo.Lines.Add('> Public Key: {' + IntToStr(Exp) + ', ' + IntToStr(R) + '};');
        FileToBytes(FILENAME, FileContents);
        InfoMemo.Lines.Add('> File {' + FILENAME + '} opened, size ' + IntToStr(Length(FileContents)) + ' bytes;');
        InfoMemo.Lines.Add('> Encoding... ');
        EncodeFile(Exp, R, FileContents, ResultMemo);
    End
    Else
        ShowMessage('Given numbers are not prime numbers!');
End;

Function SplitString(Const S, Delimiters: String): TStringDynArray;
Var
    StartIdx: Integer;
    FoundIdx: Integer;
    SplitPoints: Integer;
    CurrentSplit: Integer;
    I: Integer;
Begin
    Result := nil;

    if S <> '' then
    Begin
        SplitPoints := 0;
        For i := 1 to S.Length do
            If IsDelimiter(Delimiters, S, i) then
                Inc(SplitPoints);
        SetLength(Result, SplitPoints + 1);
        StartIdx := 1;
        CurrentSplit := 0;
        Repeat
            FoundIdx := FindDelimiter(Delimiters, S, StartIdx);
            If FoundIdx <> 0 then
            Begin
                Result[CurrentSplit] := Copy(S, StartIdx, FoundIdx - StartIdx);
                Inc(CurrentSplit);
                StartIdx := FoundIdx + 1;
            End;
        Until CurrentSplit = SplitPoints;
        Result[SplitPoints] := Copy(S, StartIdx, S.Length - StartIdx + 1);
    end;
End;

Procedure DecryptFile(D, R: Integer; DecFileContent: TStringDynArray; ResultMemo: TMemo);
Var
    I: Integer;
    ResString, TempString: String;
Begin
    For I := 0 to Length(DecFileContent) - 1 do
    Begin
        TempString := Chr(Decode(StrToInt(DecFileContent[I]), D, R));
        ResString := ResString + TempString;
    End;
    ResultMemo.Text := ResString;
End;

Procedure TMainForm.DecButtonClick(Sender: TObject);
Var
    R, D: Integer;
    DecFile: TextFile;
    DecString: String;
    DecFileContent: TStringDynArray;
Begin
    R := StrToInt(EditR.Text);
    D := StrToInt(EditD.Text);
    AssignFile(DecFile, DECFILENAME);
    Reset(DecFile);
    ReadLn(DecFile, DecString);
    
    InfoMemo.Lines.Add('> File {' + DECFILENAME + '} opened;');
    InfoMemo.Lines.Add('> Decrypting...;');
    DecFileContent := SplitString(DecString, ' ');
    DecryptFile(D, R, DecFileContent, ResultMemo); 
End;

Procedure TMainForm.FormCreate(Sender: TObject);
Begin
    ClearMemos(ResultMemo, InfoMemo);
End;

End.
