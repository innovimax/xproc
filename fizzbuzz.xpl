<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc"
  xmlns:c="http://www.w3.org/ns/xproc-step"
  xmlns:ix="http://www.innovimax.fr/ns"
  version="1.0" exclude-inline-prefixes="c ix">
  <p:documentation>
    <p>(c) Innovimax/Mohamed ZERGAOUI 2012 - The fizzbuzz XProc</p>
  </p:documentation>  
  <p:output port="result"/>
  <p:declare-step name="replicate" type="ix:replicate">
    <p:input port="source" sequence="true">
      <p:documentation>The sequence of document you want to replicate</p:documentation>
    </p:input>
    <p:output port="result" sequence="true">
      <p:documentation>The output where the replicate sequence will be provided</p:documentation>
    </p:output>
    <p:option name="count">
      <p:documentation>The number of time you want to replicate</p:documentation>
    </p:option>
    <p:choose>
      <p:when test="$count &lt; 1">
        <p:identity>
          <p:input port="source">
            <p:empty/>
          </p:input>
        </p:identity>
      </p:when>
      <p:when test="$count = 1">
        <p:identity>
          <p:input port="source">
            <p:pipe port="source" step="replicate"/>
          </p:input>
        </p:identity>        
      </p:when>
      <p:otherwise>
        <ix:replicate name="tail">
          <p:input port="source">
            <p:pipe port="source" step="replicate"/>
          </p:input>
          <p:with-option name="count" select="$count - 1"/>            
        </ix:replicate>
        <p:identity>
          <p:input port="source">            
            <p:pipe port="source" step="replicate"/>  
            <p:pipe port="result" step="tail"/>
          </p:input>
        </p:identity>
      </p:otherwise>
    </p:choose>    
  </p:declare-step>
  <ix:replicate>
    <p:documentation>First, we create a list of item</p:documentation>
    <p:input port="source">
      <p:inline><item/></p:inline>      
    </p:input>
    <p:with-option name="count" select="100"/>
  </ix:replicate>
  <p:for-each name="fill">
    <p:documentation>...then we fill it...</p:documentation>
    <p:choose>
      <p:when test="p:iteration-position() mod (3 * 5) = 0">
        <p:add-attribute match="/item" attribute-name="value" attribute-value="fizzbuzz"/>
      </p:when>
      <p:when test="p:iteration-position() mod 5 = 0">
        <p:add-attribute match="/item" attribute-name="value" attribute-value="buzz"/>
      </p:when>
      <p:when test="p:iteration-position() mod 3 = 0">
        <p:add-attribute match="/item" attribute-name="value" attribute-value="fizz"/>
      </p:when>
      <p:otherwise>
        <p:add-attribute match="/item" attribute-name="value">
          <p:with-option name="attribute-value" select="p:iteration-position()"/>
        </p:add-attribute>        
      </p:otherwise>
    </p:choose>
  </p:for-each>
  <p:wrap-sequence wrapper="list">
    <p:documentation>...and then we wrapp it. Done!</p:documentation>
  </p:wrap-sequence>
</p:declare-step>