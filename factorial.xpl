<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc"
  xmlns:c="http://www.w3.org/ns/xproc-step" xmlns:ix="http://www.innovimax.fr/ns" version="1.0" exclude-inline-prefixes="ix">
  <p:documentation>
    <p>(c) Innovimax/Mohamed ZERGAOUI 2010-2012 - XProc recursive factorial </p>
  </p:documentation>  
  <p:output port="result"/>  
  <p:declare-step name="factorial" type="ix:factorial">
    <p:input port="source"/>
    <p:output port="result"/>
    <p:choose>
      <p:when test="/c:result/@value &lt; 2">
        <p:identity>
          <p:input port="source">
            <p:inline><c:result value="1"/></p:inline>
          </p:input>
        </p:identity>
      </p:when>
      <p:otherwise>
        <p:variable name="value" select="/c:result/@value"/>        
        <p:add-attribute match="/c:result" attribute-name="value">
          <p:with-option name="attribute-value" select="$value - 1"/>
        </p:add-attribute>
        <ix:factorial/>
        <p:add-attribute match="/c:result" attribute-name="value">
          <p:with-option name="attribute-value" select="/c:result/@value * $value"/>
        </p:add-attribute>                    
      </p:otherwise>
    </p:choose>              
  </p:declare-step>
  <p:identity>
    <p:input port="source">
      <p:inline>
        <c:result value="9"/>
      </p:inline>
    </p:input>
  </p:identity>
  <ix:factorial/>
</p:declare-step>