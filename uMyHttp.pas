unit uMyHttp;

interface


function XMLHTTPRequest(sUrl: string): string;
implementation
uses
  IOUtils, msxml, Variants;

function XMLHTTPRequest(sUrl: string): string;
var
  req: IXMLHTTPRequest;
  params: string; //Ҫ�ύ������
  enUrl: AnsiString;
begin
  req := CoXMLHTTP.Create;
  req.open('GET', sUrl, False, EmptyParam, EmptyParam);
  req.send(EmptyParam);
  result := req.responseText;
end;


end.
