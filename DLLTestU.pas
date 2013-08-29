1	unit DLLTestU;
2	
3	interface
4	
5	uses
6	  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
7	  Dialogs, StdCtrls;
8	
9	type
10	  TForm1 = class(TForm)
11	    Button1: TButton;
12	    procedure Button1Click(Sender: TObject);
13	  private
14	    { Private declarations }
15	  public
16	    { Public declarations }
17	  end;
18	
19	var
20	  Form1: TForm1;
21	
22	function DecryptString(pXML: PCHAR; pCipherText: PCHAR;  pSourceElement: PCHAR; pPlainText: PCHAR; pPlainTextLen: Integer ): HRESULT; cdecl; external 'ucjissec.dll';
23	function Encrypt(pXML: PCHAR; pPlainText: PCHAR; pSourceElement: PCHAR; pCipherText: PCHAR; pCipherTextLen: Integer; pBase64: WordBool): HRESULT; cdecl; external 'ucjissec.dll';
24	
25	implementation
26	
27	{$R *.dfm}
28	
29	
30	
31	procedure TForm1.Button1Click(Sender: TObject);
32	var
33	 pXML, pSourceElement: String; 
34	 pPlainText, pCipherText: array [0..255] of char;
35	 pCipherTextLen: Integer;
36	 returnValue: HRESULT;
37	begin
38	  fillchar( pCipherText, sizeof(pCipherText), Ord(#0) );
39	  fillchar( pPlainText, sizeof(pPlainText), Ord(#0) );
40	
41	  pXML := '<udps:UDPSXML><udps:DocumentDescriptor type="XID" class="SI" authenticator="DPS" routingCode="L"/></udps:UDPSXML>';
42	  pPlainText := 'chujchuj';
43	  pSourceElement := 'udps:DocumentDescriptor';
44	  pCipherTextLen := 256;
45	
46	  try
47	    returnValue := Encrypt( pCHAR(pXML), pPlainText, pCHAR(pSourceElement), pCipherText, pCipherTextLen, false);
48	    Self.Canvas.TextOut(100,100, IntToStr( 'HI'+returnValue ) );
49	    Self.Canvas.TextOut(100,120, pCipherText );
50	    fillchar( pPlainText, sizeof(pPlainText), Ord(#0) );
51	    Self.Canvas.TextOut(100,150, pPlainText );
52	
53	    returnValue := DecryptString( pCHAR(pXML), pCipherText, pCHAR(pSourceElement), pPlainText, pCipherTextLen);
54	    Self.Canvas.TextOut(300,100, IntToStr( returnValue ) );
55	    Self.Canvas.TextOut(300,120, pPlainText );
56	
57	  finally
58	  end;
59	end;
60	
61	end.