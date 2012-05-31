<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" version="1.0">
  <p:documentation>
    <p>(c) Innovimax/Mohamed ZERGAOUI 2011-2012 - The first XProc Quine</p>
  </p:documentation>
  <p:output port="result"/>
  <p:identity>
    <p:input port="source">
      <p:inline>
        <p:declare-step version="1.0">
          <p:documentation>
            <p>(c) Innovimax/Mohamed ZERGAOUI 2011-2012 - The first XProc Quine</p>
          </p:documentation>
          <p:output port="result"/>
          <p:identity>
            <p:input port="source">
              <p:inline/>
            </p:input>
          </p:identity>
          <p:insert match="p:inline" position="first-child">
            <p:input port="source"/>
            <p:input port="insertion"/>
          </p:insert>
        </p:declare-step>
      </p:inline>
    </p:input>
  </p:identity>
  <p:insert match="p:inline" position="first-child">
    <p:input port="source"/>
    <p:input port="insertion"/>
  </p:insert>
</p:declare-step>
