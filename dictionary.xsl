<?xml version="1.0" encoding="ISO-8859-1"?>
<!-- This XSLT is modified from by Jörn Zaefferer's API-Browser XSLT.     -->
<!-- http://jquery.bassistance.de/api-browser/                            -->
<!-- http://jqueryjs.googlecode.com/svn/trunk/tools/api-browser/style.xsl -->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="xml" indent="yes" />
    <xsl:variable name="lcletters">abcdefghijklmnopqrstuvwxyz</xsl:variable>
    <xsl:variable name="ucletters">ABCDEFGHIJKLMNOPQRSTUVWXYZ</xsl:variable>
	
    <xsl:template name="ref">
        <xsl:value-of select="translate(@cat, $ucletters, $lcletters)"/>
    	<xsl:text>-</xsl:text>
    	<xsl:value-of select="translate(@name, '$.|', '')"/>
    	<xsl:text>-</xsl:text>
    	<xsl:for-each select="params">
    	    <xsl:value-of select="translate(@name, '&lt;&gt;|$.', '')" />
        </xsl:for-each>
    </xsl:template>

    <xsl:template name="href">
    	<xsl:attribute name="href">
    		<xsl:text>#</xsl:text>
    		<xsl:call-template name="ref" />
    	</xsl:attribute>
    </xsl:template>
	
    <xsl:template name="id">
    	<xsl:attribute name="id">
            <xsl:value-of select="generate-id(.)"/>
    	</xsl:attribute>
    </xsl:template>
	
    <xsl:template name="x_title">
        <xsl:attribute name="title" namespace="http://www.apple.com/DTDs/DictionaryService-1.0.rng">
            <xsl:value-of select="@cat"/>
            <xsl:text>/</xsl:text>
    	    <xsl:value-of select="@name"/>
    	    <xsl:if test="name(.) != 'property'"><xsl:text>(</xsl:text>
    	        <xsl:for-each select="params">
    			    <span class='arg-type'>
    			        <xsl:call-template name="type" />
    			    </span>
    			    <xsl:text> </xsl:text>
    			    <span class='arg-name' title='{desc}'><xsl:value-of select="@name"/></span>
    			    <xsl:if test="position() != last()">, </xsl:if>
    		    </xsl:for-each>
    	        <xsl:text>)</xsl:text>
    	    </xsl:if>
    	</xsl:attribute>
    </xsl:template>

    <xsl:template name="d_title">
        <xsl:attribute name="title" namespace="http://www.apple.com/DTDs/DictionaryService-1.0.rng">
            <xsl:value-of select="@cat"/>
    	    <xsl:text>/</xsl:text>
    	    <xsl:value-of select="@name"/>
    	    <xsl:if test="name(.) != 'property'">
    	        <xsl:text>(</xsl:text>
    	        <xsl:for-each select="params">
    		        <xsl:value-of select="@name"/>
    			    <xsl:if test="position() != last()">, </xsl:if>
    		    </xsl:for-each>
    		    <xsl:text>)</xsl:text>
    	    </xsl:if>
        </xsl:attribute>
    </xsl:template>
	
    <xsl:template name="title">
        <xsl:value-of select="@cat"/>
    	<xsl:text>/</xsl:text>
    	<xsl:value-of select="@name"/>
    	<xsl:if test="name(.) != 'property'">
    	    <xsl:text>(</xsl:text>
    	    <xsl:for-each select="params">
    		    <xsl:value-of select="@name"/>
    			<xsl:if test="position() != last()">, </xsl:if>
    		</xsl:for-each>
    		<xsl:text>)</xsl:text>
    	</xsl:if>
    </xsl:template>
    
    <xsl:template name="name">
    	<xsl:value-of select="@name"/>
    	<xsl:if test="name(.) != 'property'">
    	    <xsl:text>(</xsl:text>
    	    <xsl:for-each select="params">
    		    <xsl:value-of select="@name"/>
    			<xsl:if test="position() != last()">, </xsl:if>
    		</xsl:for-each>
    		<xsl:text>)</xsl:text>
    	</xsl:if>
    </xsl:template>
	
	
    <xsl:template name="value">
    	<xsl:attribute name="value" namespace="http://www.apple.com/DTDs/DictionaryService-1.0.rng">
    		<xsl:value-of select="@name"/>
    	</xsl:attribute>
    	<xsl:call-template name="d_title" />
    </xsl:template>
	
    <xsl:template name="return">
    	<xsl:attribute name="title">
    		<xsl:choose>
    			<xsl:when test="@return='jQuery'">A jQuery object.</xsl:when>
    			<xsl:when test="@return='Boolean'">true or false.</xsl:when>
    			<xsl:when test="@return='Object'">A simple Javascript object..</xsl:when>
    			<xsl:when test="@return='String'">A string of characters.</xsl:when>
    			<xsl:when test="@return='Number'">A valid numeric.</xsl:when>
    			<xsl:when test="@return='String|Number'">A string of characters or a number.</xsl:when>
    			<xsl:when test="@return='Element'">The Javascript object representation of a DOM Element.</xsl:when>
    			<xsl:when test="@return='Element|Array&lt;Element&gt;'">One or more DOM Elements (a single one or an array).</xsl:when>
    			<xsl:when test="@return='Map'">A Javascript object that contains key/value pairs in the form of properties and values.</xsl:when>
    			<xsl:when test="@return='Array&lt;Element&gt;'">An Array of DOM Elements.</xsl:when>
    			<xsl:when test="@return='Array&lt;String&gt;'">An Array of strings.</xsl:when>
    			<xsl:when test="@return='Function'">A reference to a Javascript function.</xsl:when>
    			<xsl:when test="@return='XMLHttpRequest'">An XMLHttpRequest object (referencing a HTTP request).</xsl:when>
    		</xsl:choose>
    	</xsl:attribute>
    	<xsl:value-of select="@return"/>
    </xsl:template>

    <xsl:template name="type">
    	<xsl:attribute name="title">
    		<xsl:choose>
    			<xsl:when test="@type='jQuery'">A jQuery object.</xsl:when>
    			<xsl:when test="@type='Boolean'">true or false.</xsl:when>
    			<xsl:when test="@type='Object'">A simple Javascript object..</xsl:when>
    			<xsl:when test="@type='String'">A string of characters.</xsl:when>
    			<xsl:when test="@type='Number'">A valid numeric.</xsl:when>
    			<xsl:when test="@type='String|Number'">A string of characters or a number.</xsl:when>
    			<xsl:when test="@type='Element'">The Javascript object representation of a DOM Element.</xsl:when>
    			<xsl:when test="@type='Element|Array&lt;Element&gt;'">One or more DOM Elements (a single one or an array).</xsl:when>
    			<xsl:when test="@type='Map'">A Javascript object that contains key/value pairs in the form of properties and values.</xsl:when>
    			<xsl:when test="@type='Array&lt;Element&gt;'">An Array of DOM Elements.</xsl:when>
    			<xsl:when test="@type='Array&lt;String&gt;'">An Array of strings.</xsl:when>
    			<xsl:when test="@type='Function'">A reference to a Javascript function.</xsl:when>
    			<xsl:when test="@type='XMLHttpRequest'">An XMLHttpRequest object (referencing a HTTP request).</xsl:when>
    		</xsl:choose>
    	</xsl:attribute>
    	<xsl:value-of select="@type"/>
    </xsl:template>
	
    <xsl:template match="/*">
        <xsl:comment> This file is generated from api-1.3.xml using XSLT and dictionary.xsl </xsl:comment>
        <d:dictionary xmlns="http://www.w3.org/1999/xhtml" xmlns:d="http://www.apple.com/DTDs/DictionaryService-1.0.rng">
    	<xsl:for-each select="//function|//selector|//property">
    		<xsl:sort select="translate(@name,'$.','')"/>
    		<xsl:sort select="count(params)"/>
    		<d:entry>
    		    <xsl:call-template name="id" />
    		    <xsl:call-template name="d_title" />
    		    <d:index>
    			    <xsl:call-template name="value" />
    		    </d:index>

            	<p class="title"><xsl:call-template name="title" /></p>
            	
        	    <xsl:for-each select="desc">
            	<p>
    		        <xsl:call-template name="break" />
            	</p>
    		    </xsl:for-each>
    					
    			<xsl:for-each select="longdesc">
    			<p>
    			    <xsl:call-template name="break" />
    		    </p>
    			</xsl:for-each>

    			<xsl:if test="params">
    				<h2>Params</h2>
    		        <p>
    				<ul class="params">
    				<xsl:for-each select="params">
    				    <li>
    					    <span><xsl:value-of select="@name"/>
    					    <xsl:text> (</xsl:text>
    						<span class='arg-type'>
    						<xsl:call-template name="type" />
    						</span>)<!--, default: <xsl:value-of select="@default"/></span> -->
    					    </span>
    						- <xsl:value-of select="desc"/>						    
    					</li>
    			    </xsl:for-each>
    				</ul>
    			    </p>
    			</xsl:if>
    			<xsl:for-each select="example">
    			    <h2>Example:</h2>
    			    <xsl:if test="desc">
    		            <p><xsl:value-of select="desc"/></p>
    			    </xsl:if>
    				<pre><code class="javascript">
		    			<xsl:call-template name="left-trim">
							<xsl:with-param name="s" select="code" />
		 				</xsl:call-template>			    			
					</code></pre>
    				<xsl:if test="html">
    				    <h3>HTML:</h3>
    				    <pre><code class="html"><xsl:text>  </xsl:text>
		    			<xsl:call-template name="left-trim">
							<xsl:with-param name="s" select="html" />
		 				</xsl:call-template>			    		
					</code></pre>
    				</xsl:if>
    				<xsl:if test="results">
    				    <h3>Result:</h3>
    					<pre><code class="html">
    					<xsl:call-template name="left-trim">
							<xsl:with-param name="s" select="results" />
			 			</xsl:call-template>
    					</code></pre>
    				</xsl:if>
    		    </xsl:for-each>
    	    </d:entry>
    	</xsl:for-each>
        </d:dictionary>
    </xsl:template>

    <xsl:template name="break">
    	<xsl:param name="text" select="." />
    	<xsl:choose>
    		<xsl:when test="contains($text, '&#xa;&#xa;')">
    			<xsl:value-of select="substring-before($text, '&#xa;&#xa;')" />
    			<br /><br />
    			<xsl:call-template name="break">
    				<xsl:with-param name="text"	select="substring-after($text, '&#xa;&#xa;')" />
    			</xsl:call-template>
    		</xsl:when>
    		<xsl:otherwise>
    			<xsl:value-of select="$text" />
    		</xsl:otherwise>
    	</xsl:choose>
    </xsl:template>

	<xsl:template name="left-trim">
	  <xsl:param name="s" />
	  <xsl:choose>
	    <xsl:when test="substring($s, 1, 1) = ''">
	      <xsl:value-of select="$s"/>
	    </xsl:when>
	    <xsl:when test="normalize-space(substring($s, 1, 1)) = ''">
	      <xsl:call-template name="left-trim">
	        <xsl:with-param name="s" select="substring($s, 2)" />
	      </xsl:call-template>
	    </xsl:when>
	    <xsl:otherwise>
	      <xsl:value-of select="$s" />
	    </xsl:otherwise>
	  </xsl:choose>
	</xsl:template>

</xsl:stylesheet>

