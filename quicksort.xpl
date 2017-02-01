<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" xmlns:c="http://www.w3.org/ns/xproc-step" xmlns:ix="http://www.innovimax.fr/ns" version="1.0">
  <p:input port="source">
    <p:inline exclude-inline-prefixes="#all">
      <root>
        <doc>03</doc>
        <doc>04</doc>
        <doc>07</doc>
        <doc>06</doc>
        <doc>02</doc>
        <doc>01</doc>
        <doc>08</doc>
        <doc>10</doc>
        <doc>09</doc>
        <doc>05</doc>
        <doc>03</doc>
        <doc>04</doc>
        <doc>07</doc>
        <doc>06</doc>
        <doc>02</doc>
        <doc>01</doc>
        <doc>08</doc>
        <doc>10</doc>
        <doc>09</doc>
        <doc>05</doc>
        <doc>03</doc>
        <doc>04</doc>
        <doc>07</doc>
        <doc>06</doc>
        <doc>02</doc>
        <doc>01</doc>
        <doc>08</doc>
        <doc>10</doc>
        <doc>09</doc>
        <doc>05</doc>
        <doc>03</doc>
        <doc>04</doc>
        <doc>07</doc>
        <doc>06</doc>
        <doc>02</doc>
        <doc>01</doc>
        <doc>08</doc>
        <doc>10</doc>
        <doc>09</doc>
        <doc>05</doc>
        <doc>03</doc>
        <doc>04</doc>
        <doc>07</doc>
        <doc>06</doc>
        <doc>02</doc>
        <doc>01</doc>
        <doc>08</doc>
        <doc>10</doc>
        <doc>09</doc>
        <doc>05</doc>
        <doc>03</doc>
        <doc>04</doc>
        <doc>07</doc>
        <doc>06</doc>
        <doc>02</doc>
        <doc>01</doc>
        <doc>08</doc>
        <doc>10</doc>
        <doc>09</doc>
        <doc>05</doc>
      </root>
    </p:inline>
  </p:input>
  <p:output port="result"/>
  <p:declare-step type="ix:sort" name="sort">
    <p:documentation>
      <p>XProc QuickSort implementation</p>
      <p>Copyright (C) 2010-2017 Mohamed ZERGAOUI Innovimax</p>
    </p:documentation>
    <p:input port="source" sequence="true"/>
    <p:output port="result" sequence="true"/>
    <p:option name="key" required="true"/>
    <p:count limit="2"/>
    <p:choose>
      <p:when test="number(.) le 1">
        <p:identity>
          <p:input port="source">
            <p:pipe port="source" step="sort"/>
          </p:input>
        </p:identity>
      </p:when>
      <p:otherwise>
        <p:split-sequence test="position() = 1" name="split">
          <p:input port="source">
            <p:pipe port="source" step="sort"/>
          </p:input>
        </p:split-sequence>
        <p:filter name="filter">
          <p:with-option name="select" select="$key">
            <p:empty/>
          </p:with-option>
        </p:filter>
        <p:group>
          <p:variable name="pivot-key" select=".">
            <p:pipe port="result" step="filter"/>
          </p:variable>
          <p:split-sequence name="split-pivot">
            <p:input port="source">
              <p:pipe port="not-matched" step="split"/>
            </p:input>
            <p:with-option name="test" select="concat($key, ' &lt;= ',
              $pivot-key)"/>
          </p:split-sequence>
          <ix:sort name="less">
            <p:with-option name="key" select="$key">
              <p:empty/>
            </p:with-option>
            <p:input port="source">
              <p:pipe port="matched" step="split-pivot"/>
            </p:input>
          </ix:sort>
          <ix:sort name="greater">
            <p:with-option name="key" select="$key">
              <p:empty/>
            </p:with-option>
            <p:input port="source">
              <p:pipe port="not-matched" step="split-pivot"/>
            </p:input>
          </ix:sort>
          <p:identity>
            <p:input port="source">
              <p:pipe port="result" step="less"/>
              <p:pipe port="matched" step="split"/>
              <p:pipe port="result" step="greater"/>
            </p:input>
          </p:identity>
        </p:group>
      </p:otherwise>
    </p:choose>
  </p:declare-step>
  <p:for-each>
    <p:iteration-source select="/root/doc"/>
    <p:identity/>
  </p:for-each>
  <ix:sort key="/doc"/>
  <p:wrap-sequence wrapper="root"/>
</p:declare-step>
